import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/company_provider.dart';
import '../models/todo.dart';

class TodoController {
  final String notepadId;
  final BuildContext context;

  TodoController(this.context, this.notepadId);

  CompanyProvider _getProvider() {
    return Provider.of<CompanyProvider>(context, listen: false);
  }

  void addTodo(CompanyProvider provider, String description) {
    // Create optimistic todo
    final newTodo = Todo(
      id: 'optimistic_temp',
      description: description,
      isDone: false,
      orderIndex: 2147483647, // Using maximum integer value
    );

    // Update UI optimistically
    final todos = [...provider.getTodosForNotepad(notepadId), newTodo];
    provider.updateTodosForNotepad(notepadId, todos);

    // Make API call
    provider.addTodo(description, notepadId);
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
    provider.editTodo(todo.id, newDescription, notepadId);
  }

  void deleteTodo(CompanyProvider provider, Todo todo) {
    // Remove optimistically
    final todos = [...provider.getTodosForNotepad(notepadId)];
    todos.removeWhere((t) => t.id == todo.id);
    provider.updateTodosForNotepad(notepadId, todos);

    // Make API call
    provider.deleteTodo(todo.id, notepadId);
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
    provider.toggleTodo(todo.id, newValue, notepadId);
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

    // Get the version directly from the provider
    final orderVersion = provider.getNotepadOrderVersion(notepadId);

    try {
      await provider.moveTodo(
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
