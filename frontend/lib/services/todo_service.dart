import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo.dart';
import '../config/env_config.dart';
import '../providers/company_provider.dart';

class TodoService {
  final String baseUrl = EnvConfig.apiUrl;
  final CompanyProvider _companyProvider = CompanyProvider();

  Future<List<Todo>> getTodos(String notepadId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/notepads/$notepadId/todos'),
    );
    final List jsonResponse = json.decode(response.body);
    jsonResponse.sort((a, b) => a['order_index'].compareTo(b['order_index']));
    return jsonResponse.map((todo) => Todo.fromJson(todo)).toList();
  }

  Future<Todo> addTodo(String message, String notepadId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/notepads/$notepadId/todos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'description': message}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add todo: ${response.body}');
    }

    final data = jsonDecode(response.body);
    return Todo.fromJson({...data['todo'], 'order_index': data['order_index']});
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
    String notepadId,
    int orderVersion,
  ) async {
    final Map<String, dynamic> data = {
      'todo_id': todoId,
      'before_id': beforeId,
      'after_id': afterId,
      'notepad_id': notepadId,
      'order_version': orderVersion,
    };

    final response = await http.patch(
      Uri.parse('$baseUrl/todo-order/reorder'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(data),
    );

    print('Request sent: ${jsonEncode(data)}');
    print('Response: ${response.statusCode} - ${response.body}');

    // if (response.statusCode == 200) {
    //   _companyProvider.incrementOrderVersion(notepadId);
    //   return;
    // }
    if (response.statusCode != 200) {
      throw Exception('Failed to move todo: ${response.body}');
    }
  }
}
