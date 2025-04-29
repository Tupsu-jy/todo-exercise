import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/env_config.dart';

class CvService {
  final String baseUrl = EnvConfig.apiUrl;

  Future<Map<int, Map<String, dynamic>>> getCv(String cvId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/cv').replace(queryParameters: {'cv_id': cvId}),
    );

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((key, value) {
      return MapEntry(int.parse(key), value);
    });
  }

  Future<Map<String, dynamic>> getCoverLetter(String coverLetterId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/cover-letters/$coverLetterId'),
    );

    return json.decode(response.body);
  }
}
