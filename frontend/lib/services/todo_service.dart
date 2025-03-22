import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo.dart';

class TodoService {
  final String baseUrl = 'http://localhost:8000/api';
  // Temp
  final notepad = '0195bd90-4b67-73ce-9409-08595c3a4910';

  Future<List<Todo>> getTodos(String notepadId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/notepads/$notepad/todos'),
    );
    final List jsonResponse = json.decode(response.body);
    return jsonResponse.map((todo) => Todo.fromJson(todo)).toList();
  }

  Future<void> addTodo(String message, String notepadId) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/notepads/$notepad/todos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(Todo.createRequestJson(description: message)),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add todo');
    }
  }

  Future<void> deleteTodo(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/todos/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }

  Future<void> editTodo(String id, String newMessage) async {
    final response = await http.put(
      Uri.parse('$baseUrl/todos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(Todo.createRequestJson(description: newMessage)),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to edit todo');
    }
  }

  Future<void> toggleTodo(String id, bool isDone) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/todos/$id/status'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(Todo.createRequestJson(isCompleted: isDone)),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to toggle todo');
    }
  }

  Future<void> moveTodo(
    String todoId,
    String? beforeId,
    String? afterId,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/notepads/$notepad/todo-order'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'todo_id': todoId,
        'before_id': beforeId,
        'after_id': afterId,
        'notepad_id': notepad, // Using the existing notepad ID
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to move todo');
    }
  }
}
