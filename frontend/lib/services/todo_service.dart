import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo.dart';

class TodoService {
  final String baseUrl = 'http://localhost:8080/todos';

  Future<List<Todo>> getTodos() async {
    final response = await http.get(Uri.parse(baseUrl));
    final List jsonResponse = json.decode(response.body);
    return jsonResponse.map((todo) => Todo.fromJson(todo)).toList();
  }

  Future<void> addTodo(String message) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(Todo.createRequestJson(description: message)),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add todo');
    }
  }

  Future<void> deleteTodo(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }

  Future<void> editTodo(String id, String newMessage) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(Todo.createRequestJson(description: newMessage)),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to edit todo');
    }
  }

  Future<void> toggleTodo(String id, bool isDone) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(Todo.createRequestJson(isCompleted: isDone)),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to toggle todo');
    }
  }
}
