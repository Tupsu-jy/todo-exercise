<?php
namespace App\Http\Controllers;

use App\Models\Notepad;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

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
        $notepads = Notepad::where('company_id', $companyId)
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

            DB::commit();
            return response()->json($notepad, 201);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['error' => 'Failed to create notepad'], 500);
        }
    }
}
