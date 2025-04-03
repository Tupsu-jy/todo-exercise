import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/notepad.dart';
import '../config/env_config.dart';

class NotepadService {
  final String baseUrl = EnvConfig.apiUrl;

  Future<List<Notepad>> getNotepads(String companyId) async {
    final response = await http.get(Uri.parse('$baseUrl/notepads/$companyId'));
    final List jsonResponse = json.decode(response.body);
    jsonResponse.sort((a, b) => a['order_index'].compareTo(b['order_index']));
    return jsonResponse.map((notepad) => Notepad.fromJson(notepad)).toList();
  }

  Future<Notepad> addNotepad(String name, String companyId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/notepads/$companyId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add notepad: ${response.body}');
    }

    final data = jsonDecode(response.body);
    return Notepad.fromJson({
      ...data['notepad'],
      'order_index': data['order_index'],
    });
  }

  Future<void> deleteNotepad(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/notepads/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete notepad');
    }
  }

  Future<void> editNotepad(String id, String newName) async {
    final response = await http.put(
      Uri.parse('$baseUrl/notepads/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': newName}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to edit notepad');
    }
  }

  Future<void> moveNotepad(
    String notepadId,
    String? beforeId,
    String? afterId,
    String companyId,
    int orderVersion,
  ) async {
    final Map<String, dynamic> data = {
      'notepad_id': notepadId,
      'before_id': beforeId,
      'after_id': afterId,
      'company_id': companyId,
      'order_version': orderVersion,
    };

    final response = await http.patch(
      Uri.parse('$baseUrl/notepad-order/reorder'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to move notepad: ${response.body}');
    }
  }
}
