const String _apiUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: 'http://localhost:8000/api',
);

class EnvConfig {
  static String get apiUrl => _apiUrl;
}
