<?php
namespace App\Http\Controllers;

use App\Events\TodoReordered;
use App\Models\Todo;
use Illuminate\Http\Request;
use App\Models\TodoOrder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use App\Models\Notepad;

/**
 * @group Todo Management
 * 
 * APIs for managing todos within notepads
 */
class TodoController extends Controller
{
    /**
     * Reorder Todos
     * 
     * Reorders a todo by placing it between two other todos.
     * Uses a numeric ordering system to maintain todo positions.
     * 
     * @urlParam todo_id string required UUID of the todo to move. Example: 550e8400-e29b-41d4-a716-446655440000
     * @urlParam before_id string UUID of the todo that will be before the moved todo. Example: 550e8400-e29b-41d4-a716-446655440001
     * @urlParam after_id string UUID of the todo that will be after the moved todo. Example: 550e8400-e29b-41d4-a716-446655440002
     * @urlParam notepad_id string required UUID of the notepad. Example: 550e8400-e29b-41d4-a716-446655440003
     * @urlParam order_version int required The version number of the order. Example: 1
     * 
     * @response 200 {
     *   "success": true
     * }
     * 
     * @response 422 {
     *   "message": "The todo_id field is required.",
     *   "errors": {
     *     "todo_id": ["The todo_id field is required."]
     *   }
     * }
     * 
     * @response 500 {
     *   "error": "Failed to move todo"
     * }
     */
    public function reorderTodos(Request $request)
    {
        Log::info('Starting reorderTodos', ['request' => $request->all()]);
        DB::beginTransaction();
        try {
            Log::info('Moving todo', ['request' => $request->all()]);
            // TODO: Add handling for exceptions. ie when todo does not have correct order index
            // 1. Validation
            $request->validate([
                'todo_id' => 'required|uuid',      // The todo being moved
                'before_id' => 'nullable|uuid',    // The todo that will be BEFORE our moved todo
                'after_id' => 'nullable|uuid',     // The todo that will be AFTER our moved todo
                'notepad_id' => 'required|uuid',    // To ensure we're working in correct notepad
                'order_version' => 'required|integer' // To ensure we're working in correct order version
            ]);

            $notepad = Notepad::where('id', $request->notepad_id)
                ->where('order_version', $request->order_version)
                ->lockForUpdate()
                ->first();

            if (!$notepad) {
                throw new \Exception('Order version mismatch');
            }

            // Lock all todo orders for the notepad being reordered. Will fail if another process is modifying the same notepad.
            $todo_orders = TodoOrder::where('notepad_id', $request->notepad_id)
                ->lockForUpdate();

            Log::info('After validation');

            // 2. Get order indexes for positioning
            $beforeOrder = null;
            $afterOrder = null;
            
            if ($request->before_id) {
                $beforeOrder = $todo_orders->where('todo_id', $request->before_id)
                    ->value('order_index');
                Log::info('Before order', ['order' => $beforeOrder]);
            }
            
            if ($request->after_id) {
                $afterOrder = $todo_orders->where('todo_id', $request->after_id)
                    ->value('order_index');
            }

            // 3. Calculate new position
            $newOrder = $this->calculateNewOrderIndex($beforeOrder, $afterOrder);

            // 4. Update the todo's position
            $todo_orders->where('todo_id', $request->todo_id)
                ->update(['order_index' => $newOrder]);

            // 5. Increment the order version
            $notepad->increment('order_version');
            $notepad->save();

            DB::commit();
            Log::info('Transaction committed successfully');

            // 6. Broadcast the new order index to all clients
            broadcast(new TodoReordered($request->todo_id, $newOrder, $notepad))->toOthers();

            return response()->json(['success' => true]);

        } catch (\Exception $e) {
            Log::error('Failed to move todo', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            DB::rollBack();
            return response()->json([
                'error' => 'Failed to move todo',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Calculate New Order Index
     * 
     * Gets the halfway point between the before and after order indexes.
     * 
     * @param int|null $beforeOrder The order index of the todo before the moved todo.
     * @param int|null $afterOrder The order index of the todo after the moved todo.
     * 
     * @return int The new order index for the todo.
     */
    private function calculateNewOrderIndex(?int $beforeOrder, ?int $afterOrder): int 
    {
        // Define PostgreSQL integer boundaries
        $minPossible = -2147483648;  // PostgreSQL integer minimum
        $maxPossible = 2147483647;   // PostgreSQL integer maximum

        // Use min/max when null
        $beforeOrder = $beforeOrder ?? $minPossible;
        $afterOrder = $afterOrder ?? $maxPossible;

        // Now we can always use the same formula
        return $beforeOrder + (($afterOrder - $beforeOrder) / 2);
    }

    /**
     * Get All Todos
     * 
     * Retrieves all todos for a specific notepad, including their order index.
     * 
     * @urlParam notepad_id string required UUID of the notepad. Example: 550e8400-e29b-41d4-a716-446655440000
     * 
     * @response 200 [{
     *   "id": "550e8400-e29b-41d4-a716-446655440000",
     *   "notepad_id": "550e8400-e29b-41d4-a716-446655440001",
     *   "description": "Buy milk",
     *   "is_completed": false,
     *   "created_at": "2024-03-24T12:00:00Z",
     *   "updated_at": "2024-03-24T12:00:00Z"
     * }]
     */
    public function getAllTodos($notepadId)
    {
        $todos = DB::table('todos')
            ->join('todo_orders', 'todos.id', '=', 'todo_orders.todo_id')
            ->where('todos.notepad_id', $notepadId)
            ->select('todos.*', 'todo_orders.order_index') // Include order_index
            ->get();

        return response()->json($todos);
    }

    /**
     * Create Todo
     * 
     * Creates a new todo in the specified notepad and assigns it the last position.
     * 
     * @urlParam notepad_id string required UUID of the notepad. Example: 550e8400-e29b-41d4-a716-446655440000
     * @bodyParam description string required The todo description. Example: Buy groceries
     * 
     * @response 201 {
     *   "id": "550e8400-e29b-41d4-a716-446655440000",
     *   "notepad_id": "550e8400-e29b-41d4-a716-446655440001",
     *   "description": "Buy groceries",
     *   "is_completed": false,
     *   "created_at": "2024-03-24T12:00:00Z",
     *   "updated_at": "2024-03-24T12:00:00Z"
     * }
     * 
     * @response 422 {
     *   "message": "The description field is required.",
     *   "errors": {
     *     "description": ["The description field is required."]
     *   }
     * }
     * 
     * @response 500 {
     *   "error": "Failed to create todo"
     * }
     */
    public function store(Request $request, $notepadId)
    {
        DB::beginTransaction();
        try {
            $request->validate([
                'description' => 'required|string'
            ]);

            $todo = Todo::create([
                'notepad_id' => $notepadId,
                'description' => $request->description,
                'is_completed' => false
            ]);

            // Get the highest order_index for this notepad
            $maxOrder = TodoOrder::where('notepad_id', $notepadId)
                ->orderBy('order_index', 'desc')
                ->lockForUpdate()
                ->first()
                ?->order_index ?? 0;

            // Calculate new order_index
            $newOrder = $this->calculateNewOrderIndex($maxOrder, null);

            TodoOrder::create([
                'notepad_id' => $notepadId,
                'todo_id' => $todo->id,
                'order_index' => (int)$newOrder
            ]);

            DB::commit();
            return response()->json([
                'todo' => $todo,
                'order_index' => $newOrder
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['error' => 'Failed to create todo'], 500);
        }
    }

    /**
     * Delete Todo
     * 
     * Deletes a specific todo by its ID.
     * 
     * @urlParam id string required UUID of the todo. Example: 550e8400-e29b-41d4-a716-446655440000
     * 
     * @response 200 {
     *   "success": true
     * }
     * 
     * @response 404 {
     *   "message": "Todo not found"
     * }
     * 
     * @response 500 {
     *   "error": "Failed to delete todo"
     * }
     */
    public function destroy($id)
    {
        DB::beginTransaction();
        try {
            // Lock and get just the specific todo
            $todo = Todo::where('id', $id)
                ->lockForUpdate()
                ->firstOrFail();

            // Lock and get just this todo's order entry
            TodoOrder::where('todo_id', $id)
                ->lockForUpdate()
                ->firstOrFail();

            $todo->delete();  // This will cascade delete the todo_order
            
            DB::commit();
            return response()->json(['success' => true]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['error' => 'Failed to delete todo'], 500);
        }
    }

    /**
     * Toggle Todo Status
     * 
     * Toggles the completion status of a specific todo.
     * 
     * @urlParam id string required UUID of the todo. Example: 550e8400-e29b-41d4-a716-446655440000
     * @bodyParam is_completed boolean required The new completion status. Example: true
     * 
     * @response 200 {
     *   "id": "550e8400-e29b-41d4-a716-446655440000",
     *   "description": "Buy groceries",
     *   "is_completed": true,
     *   "updated_at": "2024-03-24T12:00:00Z"
     * }
     * 
     * @response 422 {
     *   "message": "The is_completed field is required."
     * }
     */
    public function toggleStatus(Request $request, $id)
    {
        DB::beginTransaction();
        try {
            $request->validate([
                'is_completed' => 'required|boolean'
            ]);

            $todo = Todo::findOrFail($id);
            $todo->update([
                'is_completed' => $request->is_completed
            ]);
            DB::commit();
            return response()->json($todo);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['error' => 'Failed to toggle todo status'], 500);
        }
    }

    /**
     * Update Todo
     * 
     * Updates the description of a specific todo.
     * 
     * @urlParam id string required UUID of the todo. Example: 550e8400-e29b-41d4-a716-446655440000
     * @bodyParam description string required The new todo description. Example: Buy milk and bread
     * 
     * @response 200 {
     *   "id": "550e8400-e29b-41d4-a716-446655440000",
     *   "description": "Buy milk and bread",
     *   "is_completed": false,
     *   "updated_at": "2024-03-24T12:00:00Z"
     * }
     * 
     * @response 422 {
     *   "message": "The description field is required."
     * }
     */
    public function update(Request $request, $id)
    {
        DB::beginTransaction();
        try {
            $request->validate([
                'description' => 'required|string'
            ]);

            $todo = Todo::findOrFail($id);
            $todo->update([
                'description' => $request->description
            ]);

            DB::commit();
            return response()->json($todo);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['error' => 'Failed to update todo'], 500);
        }
    }
}
