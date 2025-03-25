import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/notepad.dart';
import '../config/env_config.dart';

class NotepadService {
  final String baseUrl = EnvConfig.apiUrl;
  final String companyIdTemp =
      '0195bd90-4b5f-72e6-baa2-18b5343dc7e7'; // Temporary hardcoded value

  Future<List<Notepad>> getNotepads(String companyId) async {
    final response = await http.get(Uri.parse('$baseUrl/notepads/$companyId'));
    final List jsonResponse = json.decode(response.body);
    return jsonResponse.map((notepad) => Notepad.fromJson(notepad)).toList();
  }

  Future<void> addNotepad(String companyId, String notepadName) async {
    final response = await http.post(
      Uri.parse('$baseUrl/notepads/$companyId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': notepadName}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create notepad');
    }
  }
}
