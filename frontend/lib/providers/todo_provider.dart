import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';
import '../providers/company_provider.dart';

// Create a new TodoProvider
class TodoProvider extends ChangeNotifier {
  final TodoService _todoService = TodoService();
  final CompanyProvider _companyProvider = CompanyProvider();
  Map<String, List<Todo>> todosByNotepad = {};

  List<Todo> getTodosForNotepad(String notepadId) {
    return todosByNotepad[notepadId] ?? [];
  }

  // TODO: why are all these even here?
  Future<void> loadTodos(String notepadId) async {
    todosByNotepad[notepadId] = await _todoService.getTodos(notepadId);
    notifyListeners();
  }

  Future<void> addTodo(String message, String notepadId) async {
    try {
      final todo = await _todoService.addTodo(message, notepadId);
      todosByNotepad[notepadId]!.removeWhere(
        (todo) => todo.id == 'optimistic_temp',
      );
      todosByNotepad[notepadId]!.add(todo);
      notifyListeners();
    } catch (e) {
      await loadTodos(notepadId);
      rethrow;
    }
  }

  Future<void> deleteTodo(String id, String notepadId) async {
    try {
      await _todoService.deleteTodo(id);
    } catch (e) {
      await loadTodos(notepadId);
      rethrow;
    }
  }

  Future<void> editTodo(String id, String newMessage, String notepadId) async {
    try {
      await _todoService.editTodo(id, newMessage);
    } catch (e) {
      await loadTodos(notepadId);
      rethrow;
    }
  }

  Future<void> toggleTodo(String id, bool isDone, String notepadId) async {
    try {
      await _todoService.toggleTodo(id, isDone);
    } catch (e) {
      await loadTodos(notepadId);
      rethrow;
    }
  }

  Future<void> moveTodo(
    String todoId,
    String? beforeId,
    String? afterId,
    String notepadId,
    int orderVersion,
  ) async {
    try {
      await _todoService.moveTodo(
        todoId,
        beforeId,
        afterId,
        notepadId,
        orderVersion,
      );
    } catch (e) {
      await loadTodos(notepadId);
      rethrow; // Rethrow so widget can still show error message
    }
  }

  // For when updates are received from the server via WebSocket
  void handleWebSocketUpdate(Map<String, dynamic> data) {
    if (data['event'] == 'todo.reordered') {
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
            _companyProvider.incrementOrderVersion(notepadId);
            return;
          }
        }
      });
    }
  }

  // Add these three new handlers:
  void handleTodoCreated(Map<String, dynamic> todoData, int orderIndex) {
    final todo = Todo(
      id: todoData['id'],
      description: todoData['description'],
      isDone: todoData['is_completed'] ?? false,
      orderIndex: orderIndex,
    );

    final notepadId = todoData['notepad_id'];
    if (todosByNotepad.containsKey(notepadId)) {
      todosByNotepad[notepadId]!.add(todo);
      todosByNotepad[notepadId]!.sort(
        (a, b) => a.orderIndex.compareTo(b.orderIndex),
      );
      notifyListeners();
    }
  }

  void handleTodoDeleted(String todoId) {
    todosByNotepad.forEach((notepadId, todos) {
      final beforeLength = todos.length;
      todos.removeWhere((todo) => todo.id == todoId);

      // Only notify if we actually removed something
      if (todos.length != beforeLength) {
        updateTodosForNotepad(notepadId, todos);
      }
    });
  }

  void handleTodoUpdated(Map<String, dynamic> todoData) {
    final todoId = todoData['id'];
    final notepadId = todoData['notepad_id'];

    if (todosByNotepad.containsKey(notepadId)) {
      final todos = todosByNotepad[notepadId]!;
      for (var i = 0; i < todos.length; i++) {
        if (todos[i].id == todoId) {
          todos[i] = Todo(
            id: todoId,
            description: todoData['description'],
            isDone: todoData['is_completed'] ?? todos[i].isDone,
            orderIndex: todos[i].orderIndex, // Preserve existing order
          );
          updateTodosForNotepad(notepadId, todos);
          break;
        }
      }
    }
  }

  void updateTodosForNotepad(String notepadId, List<Todo> todos) {
    todosByNotepad[notepadId] = todos;
    notifyListeners();
  }
}
