import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/company.dart';
import '../config/env_config.dart';

class CompanyService {
  final String baseUrl = EnvConfig.apiUrl;

  Future<Company> getCompany(String companySlug) async {
    final response = await http.get(
      Uri.parse('$baseUrl/companies/$companySlug'),
    );
    // Api returns a object
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return Company.fromJson(jsonResponse);
  }
}
