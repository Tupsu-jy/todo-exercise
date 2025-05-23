<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\TodoController;
use App\Http\Controllers\NotepadController;
use App\Http\Controllers\CompanyController;
use App\Http\Controllers\CvController;
use App\Http\Controllers\CoverLetterController;
use App\Http\Controllers\ProjectInfoController;

// Autogenerated. Left here for reference.
Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::prefix('todo-order')->group(function () {
    Route::patch('/reorder', [TodoController::class, 'reorderTodos']); // Reorders todos
});

Route::prefix('notepad-order')->group(function () {
    Route::patch('/reorder', [NotepadController::class, 'reorderNotepads']); // Reorders notepads
});

Route::prefix('notepads')->group(function () {
    // Get and create todos for a notepad
    Route::get('/{notepad}/todos', [TodoController::class, 'getAllTodos']); // Gets all todos for a notepad
    Route::post('/{notepad}/todos', [TodoController::class, 'store']); // Creates todo and adds it to the notepad
    // These are for notepads
    Route::get('/{company_id}', [NotepadController::class, 'getNotepads']);
    Route::post('/{company_id}', [NotepadController::class, 'store']);
    Route::delete('/{notepad_id}', [NotepadController::class, 'destroy']);
    Route::put('/{notepad_id}', [NotepadController::class, 'update']);
});

Route::prefix('todos')->group(function () {
    // Todo operations
    Route::delete('/{id}', [TodoController::class, 'destroy']); // Deletes todo
    // TODO: seems wrong there are 2 like this
    Route::put('/{id}', [TodoController::class, 'update']); // Updates todo
    Route::patch('/{id}/status', [TodoController::class, 'toggleStatus']); // Toggles status of todo
});

Route::prefix('companies')->group(function () {
    Route::get('/{company_slug}', [CompanyController::class, 'getCompany']);
});

Route::prefix('cv')->group(function () {
    Route::get('/', [CvController::class, 'getCv']);
});

Route::prefix('cover-letters')->group(function () {
    Route::get('/{id}', [CoverLetterController::class, 'getCoverLetter']);
});

Route::prefix('project-info')->group(function () {
    Route::get('/', [ProjectInfoController::class, 'getLatest']);
});