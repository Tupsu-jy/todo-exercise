<?php
namespace App\Http\Controllers;

use App\Events\NotepadReordered;
use App\Events\NotepadCreated;
use App\Events\NotepadDeleted;
use App\Events\NotepadUpdated;
use App\Models\Notepad;
use App\Models\NotepadOrder;
use App\Models\Company;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

/**
 * @group Notepad Management
 *
 * APIs for managing notepads within companies. Notepads are collections of todos
 * that belong to a specific company application process.
 */
class NotepadController extends Controller
{
    /**
     * List Company Notepads
     *
     * Retrieves all notepads belonging to a specific company.
     * Notepads are returned in chronological order by creation date.
     *
     * @urlParam companyId string required The UUID of the company. Example: 0195bd90-4b5f-72e6-baa2-18b5343dc7e7
     *
     * @response 200 [{
     *   "id": "0195bd90-4b67-73ce-9409-08595c3a4910",
     *   "name": "Interview Preparation",
     *   "company_id": "0195bd90-4b5f-72e6-baa2-18b5343dc7e7",
     *   "created_at": "2024-03-24T12:00:00Z",
     *   "updated_at": "2024-03-24T12:00:00Z"
     * }]
     *
     * @response 404 {
     *   "message": "Company not found"
     * }
     */
    public function getNotepads($companyId)
    {
        $notepads = DB::table('notepads')
            ->join('notepad_orders', 'notepads.id', '=', 'notepad_orders.notepad_id')
            ->where('notepads.company_id', $companyId)
            ->select('notepads.*', 'notepad_orders.order_index')
            ->orderBy('notepad_orders.order_index', 'asc')
            ->get();
            
        return response()->json($notepads);
    }

    /**
     * Create Notepad
     *
     * Creates a new notepad for a specific company.
     * Each notepad can contain multiple todos and helps organize different aspects
     * of the job application process.
     *
     * @urlParam companyId string required The UUID of the company. Example: 0195bd90-4b5f-72e6-baa2-18b5343dc7e7
     * @bodyParam name string required The name of the notepad. Example: Technical Interview Notes
     *
     * @response 201 {
     *   "id": "0195bd90-4b67-73ce-9409-08595c3a4910",
     *   "name": "Technical Interview Notes",
     *   "company_id": "0195bd90-4b5f-72e6-baa2-18b5343dc7e7",
     *   "created_at": "2024-03-24T12:00:00Z",
     *   "updated_at": "2024-03-24T12:00:00Z"
     * }
     *
     * @response 422 {
     *   "message": "The name field is required.",
     *   "errors": {
     *     "name": ["The name field is required."]
     *   }
     * }
     *
     * @response 500 {
     *   "error": "Failed to create notepad"
     * }
     */
    public function store(Request $request, $companyId)
    {
        DB::beginTransaction();
        try {
            $request->validate([
                'name' => 'required|string'
            ]);

            $notepad = Notepad::create([
                'name' => $request->name,
                'company_id' => $companyId
            ]);

            $maxOrder = NotepadOrder::where('company_id', $companyId)
                ->orderBy('order_index', 'desc')
                ->lockForUpdate()
                ->first()
                ?->order_index ?? 0;

            $newOrder = $this->calculateNewOrderIndex($maxOrder, null);

            NotepadOrder::create([
                'company_id' => $companyId,
                'notepad_id' => $notepad->id,
                'order_index' => (int)$newOrder
            ]);

            DB::commit();

            broadcast(new NotepadCreated($notepad, $newOrder));

            return response()->json([
                'notepad' => $notepad,
                'order_index' => $newOrder
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['error' => 'Failed to create notepad'], 500);
        }
    }

    public function reorderNotepads(Request $request)
    {
        Log::info('Starting reorderNotepads', ['request' => $request->all()]);
        DB::beginTransaction();
        try {
            $request->validate([
                'notepad_id' => 'required|uuid',
                'before_id' => 'nullable|uuid',
                'after_id' => 'nullable|uuid',
                'company_id' => 'required|uuid',
                'order_version' => 'required|integer'
            ]);

            $company = Company::where('id', $request->company_id)
                ->where('order_version', $request->order_version)
                ->lockForUpdate()
                ->first();

            if (!$company) {
                throw new \Exception('Order version mismatch');
            }

            $notepad_orders = NotepadOrder::where('company_id', $request->company_id)
                ->lockForUpdate();

            $orderIndexes = $notepad_orders->whereIn('notepad_id', array_filter([$request->before_id, $request->after_id]))
                ->pluck('order_index', 'notepad_id');

            $beforeOrder = $request->before_id ? ($orderIndexes[$request->before_id] ?? null) : null;
            $afterOrder = $request->after_id ? ($orderIndexes[$request->after_id] ?? null) : null;

            Log::info('Order indexes', [
                'before' => $beforeOrder,
                'after' => $afterOrder
            ]);

            $newOrder = $this->calculateNewOrderIndex($beforeOrder, $afterOrder);

            Log::info('New order', [
                'new_order' => $newOrder
            ]);

            $updated = NotepadOrder::where('company_id', $request->company_id)
                ->where('notepad_id', $request->notepad_id)
                ->update(['order_index' => $newOrder]);

            $company->increment('order_version');
            $company->save();

            DB::commit();

            broadcast(new NotepadReordered($request->notepad_id, $newOrder));

            return response()->json(['success' => true]);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'error' => 'Failed to move notepad',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    private function calculateNewOrderIndex(?int $beforeOrder, ?int $afterOrder): int 
    {
        $minPossible = -2147483648;
        $maxPossible = 2147483647;

        $beforeOrder = $beforeOrder ?? $minPossible;
        $afterOrder = $afterOrder ?? $maxPossible;

        return $beforeOrder + (($afterOrder - $beforeOrder) / 2);
    }

    public function destroy($id)
    {
        DB::beginTransaction();
        try {
            $notepad = Notepad::where('id', $id)
                ->lockForUpdate()
                ->firstOrFail();

            NotepadOrder::where('notepad_id', $id)
                ->lockForUpdate()
                ->firstOrFail();

            $notepad->delete();
            
            DB::commit();

            broadcast(new NotepadDeleted($id))->toOthers();

            return response()->json(['success' => true]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['error' => 'Failed to delete notepad'], 500);
        }
    }

    public function update(Request $request, $id)
    {
        DB::beginTransaction();
        try {
            $request->validate([
                'name' => 'required|string'
            ]);

            $notepad = Notepad::findOrFail($id);
            $notepad->update([
                'name' => $request->name
            ]);

            DB::commit();

            broadcast(new NotepadUpdated($notepad))->toOthers();

            return response()->json($notepad);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['error' => 'Failed to update notepad'], 500);
        }
    }
}
