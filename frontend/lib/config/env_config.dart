const String _apiUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: 'http://localhost:8000/api',
);

const String _wsUrl = String.fromEnvironment(
  'WS_URL',
  // This is for when BE is not in docker
  defaultValue: 'ws://localhost:8080/app/ob0ildef0rapadlha0hl',
  // This is for when BE is in docker
  //defaultValue: 'ws://localhost:8000/app/ob0ildef0rapadlha0hl',
);

class EnvConfig {
  static String get apiUrl => _apiUrl;
  static String get wsUrl => _wsUrl;
}
