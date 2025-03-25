import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';

// Create a new TodoProvider
class TodoProvider extends ChangeNotifier {
  final TodoService _todoService = TodoService();
  Map<String, List<Todo>> todosByNotepad = {};

  List<Todo> getTodosForNotepad(String notepadId) {
    return todosByNotepad[notepadId] ?? [];
  }

  Future<void> loadTodos(String notepadId) async {
    todosByNotepad[notepadId] = await _todoService.getTodos(notepadId);
    notifyListeners();
  }

  Future<void> addTodo(String message, String notepadId) async {
    await _todoService.addTodo(message, notepadId);
    await loadTodos(notepadId);
  }

  Future<void> deleteTodo(String id, String notepadId) async {
    await _todoService.deleteTodo(id);
    await loadTodos(notepadId);
  }

  Future<void> editTodo(String id, String newMessage, String notepadId) async {
    await _todoService.editTodo(id, newMessage);
    await loadTodos(notepadId);
  }

  Future<void> toggleTodo(String id, bool isDone, String notepadId) async {
    await _todoService.toggleTodo(id, isDone);
    await loadTodos(notepadId);
  }

  Future<void> moveTodo(
    String todoId,
    String? beforeId,
    String? afterId,
    String notepadId,
  ) async {
    await _todoService.moveTodo(todoId, beforeId, afterId, notepadId);
  }

  void handleWebSocketUpdate(Map<String, dynamic> data) {
    if (data['event'] == 'todo.reordered') {
      // Update the todo order when receiving WebSocket message
      final String todoId = data['todoId'];
      final int newOrder = data['newOrder'];

      todosByNotepad.forEach((notepadId, todos) {
        for (var i = 0; i < todos.length; i++) {
          if (todos[i].id == todoId) {
            todos[i] = Todo(
              id: todos[i].id,
              description: todos[i].description,
              isDone: todos[i].isDone,
              orderIndex: newOrder,
            );
            todos.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
            updateTodosForNotepad(notepadId, todos);
            return;
          }
        }
      });
    }
  }

  void updateTodosForNotepad(String notepadId, List<Todo> todos) {
    todosByNotepad[notepadId] = todos;
    notifyListeners();
  }
}
