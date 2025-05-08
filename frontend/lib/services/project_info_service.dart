import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/env_config.dart';

class ProjectInfoService {
  final String baseUrl = EnvConfig.apiUrl;

  Future<Map<String, String>> getProjectInfo() async {
    final response = await http.get(Uri.parse('$baseUrl/project-info'));

    return Map<String, String>.from(json.decode(response.body));
  }
}
