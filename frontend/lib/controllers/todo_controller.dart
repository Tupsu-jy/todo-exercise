import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../providers/company_provider.dart';
import '../models/todo.dart';

class TodoController {
  final String notepadId;
  final BuildContext context;

  TodoController(this.context, this.notepadId);

  CompanyProvider _getCompanyProvider() {
    return Provider.of<CompanyProvider>(context, listen: false);
  }

  void addTodo(TodoProvider todoProvider, String description) {
    // Create optimistic todo
    final newTodo = Todo(
      id: 'optimistic_temp',
      description: description,
      isDone: false,
      orderIndex: 2147483647, // Using maximum integer value
    );

    // Update UI optimistically
    final todos = [...todoProvider.getTodosForNotepad(notepadId), newTodo];
    todoProvider.updateTodosForNotepad(notepadId, todos);

    // Make API call
    todoProvider.addTodo(description, notepadId);
  }

  void editTodo(TodoProvider todoProvider, Todo todo, String newDescription) {
    // Update optimistically
    final todos =
        todoProvider
            .getTodosForNotepad(notepadId)
            .map(
              (t) =>
                  t.id == todo.id ? t.copyWith(description: newDescription) : t,
            )
            .toList();
    todoProvider.updateTodosForNotepad(notepadId, todos);

    // Make API call
    todoProvider.editTodo(todo.id, newDescription, notepadId);
  }

  void deleteTodo(TodoProvider todoProvider, Todo todo) {
    // Remove optimistically
    final todos = [...todoProvider.getTodosForNotepad(notepadId)];
    todos.removeWhere((t) => t.id == todo.id);
    todoProvider.updateTodosForNotepad(notepadId, todos);

    // Make API call
    todoProvider.deleteTodo(todo.id, notepadId);
  }

  void toggleTodo(TodoProvider todoProvider, Todo todo, bool newValue) {
    // Update optimistically
    final todos =
        todoProvider
            .getTodosForNotepad(notepadId)
            .map((t) => t.id == todo.id ? t.copyWith(isDone: newValue) : t)
            .toList();
    todoProvider.updateTodosForNotepad(notepadId, todos);

    // Make API call
    todoProvider.toggleTodo(todo.id, newValue, notepadId);
  }

  Future<void> reorderTodo(
    TodoProvider todoProvider,
    List<Todo> todos,
    int oldIndex,
    int newIndex,
  ) async {
    if (newIndex > oldIndex) newIndex--;

    // Get IDs for API call
    final String? beforeId = newIndex > 0 ? todos[newIndex - 1].id : null;
    final String? afterId =
        newIndex < todos.length - 1 ? todos[newIndex].id : null;

    // Get the version from CompanyProvider
    final orderVersion = _getCompanyProvider().getNotepadOrderVersion(
      notepadId,
    );

    // Optimistically update the list
    final movedTodo = todos.removeAt(oldIndex);
    todos.insert(newIndex, movedTodo);
    todoProvider.updateTodosForNotepad(notepadId, todos);

    try {
      await todoProvider.moveTodo(
        movedTodo.id,
        beforeId,
        afterId,
        notepadId,
        orderVersion,
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to move todo')));
      }
    }
  }
}
