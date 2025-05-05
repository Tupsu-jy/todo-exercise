import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/company_provider.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';

class TodoController {
  final String notepadId;
  final BuildContext context;
  final TodoService _todoService = TodoService();

  TodoController(this.context, this.notepadId);

  CompanyProvider _getProvider() {
    return Provider.of<CompanyProvider>(context, listen: false);
  }

  Future<void> loadTodos() async {
    final provider = _getProvider();
    final todos = await _todoService.getTodos(notepadId);
    provider.updateTodosForNotepad(notepadId, todos);
  }

  Future<void> addTodo(CompanyProvider provider, String description) async {
    // Create optimistic todo
    final newTodo = Todo(
      id: 'optimistic_temp',
      description: description,
      isDone: false,
      orderIndex: 2147483647,
    );

    // Update UI optimistically
    final todos = [...provider.getTodosForNotepad(notepadId), newTodo];
    provider.updateTodosForNotepad(notepadId, todos);

    // Make API call
    try {
      final todo = await _todoService.addTodo(description, notepadId);
    } catch (e) {
      print(e);
      loadTodos(); // Revert on error
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to add todo')));
      }
    }
  }

  void editTodo(CompanyProvider provider, Todo todo, String newDescription) {
    // Update optimistically
    final todos =
        provider
            .getTodosForNotepad(notepadId)
            .map(
              (t) =>
                  t.id == todo.id ? t.copyWith(description: newDescription) : t,
            )
            .toList();
    provider.updateTodosForNotepad(notepadId, todos);

    // Make API call
    _todoService.editTodo(todo.id, newDescription).catchError((e) {
      loadTodos(); // Revert on error
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to edit todo')));
      }
    });
  }

  void deleteTodo(CompanyProvider provider, Todo todo) {
    // Remove optimistically
    final todos = [...provider.getTodosForNotepad(notepadId)];
    todos.removeWhere((t) => t.id == todo.id);
    provider.updateTodosForNotepad(notepadId, todos);

    // Make API call
    _todoService.deleteTodo(todo.id).catchError((e) {
      loadTodos(); // Revert on error
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to delete todo')));
      }
    });
  }

  void toggleTodo(CompanyProvider provider, Todo todo, bool newValue) {
    // Update optimistically
    final todos =
        provider
            .getTodosForNotepad(notepadId)
            .map((t) => t.id == todo.id ? t.copyWith(isDone: newValue) : t)
            .toList();
    provider.updateTodosForNotepad(notepadId, todos);

    // Make API call
    _todoService.toggleTodo(todo.id, newValue).catchError((e) {
      loadTodos(); // Revert on error
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to toggle todo')));
      }
    });
  }

  Future<void> reorderTodo(
    CompanyProvider provider,
    List<Todo> todos,
    int oldIndex,
    int newIndex,
  ) async {
    if (newIndex > oldIndex) newIndex--;

    // Optimistically update the list
    final movedTodo = todos.removeAt(oldIndex);
    todos.insert(newIndex, movedTodo);
    provider.updateTodosForNotepad(notepadId, todos);

    // Get IDs for API call
    final String? beforeId = newIndex > 0 ? todos[newIndex - 1].id : null;
    final String? afterId =
        newIndex < todos.length - 1 ? todos[newIndex + 1].id : null;

    try {
      await _todoService.moveTodo(
        movedTodo.id,
        beforeId,
        afterId,
        notepadId,
        provider.getNotepadOrderVersion(notepadId),
      );
      // Increment version after successful move
      //final notepad = provider.notepads.firstWhere((n) => n.id == notepadId);
      //notepad.orderVersion++;
      //provider.notifyListeners();
    } catch (e) {
      await loadTodos(); // Revert on error
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to move todo')));
      }
    }
  }
}
