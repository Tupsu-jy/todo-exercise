import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:provider/provider.dart';
import 'providers/company_provider.dart';
import 'providers/todo_provider.dart';
import 'config/env_config.dart';
import 'dart:convert';

void main() {
  String companySlug;
  try {
    final Uri uri = Uri.base;
    companySlug =
        uri.pathSegments.isNotEmpty
            ? uri.pathSegments.last
            : throw Exception('No company slug found in URL');
  } catch (e) {
    print('Error parsing URL: $e');
    companySlug = 'default';
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (context) => CompanyProvider()..initializeWithSlug(companySlug),
        ),
        ChangeNotifierProvider(create: (context) => TodoProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String baseUrl = EnvConfig.apiUrl;
  late final WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    channel = WebSocketChannel.connect(Uri.parse(EnvConfig.wsUrl));

    channel.stream.listen((message) {
      print('message: $message');
      final data = jsonDecode(message);
      final eventData = jsonDecode(data['data']);
      if (data['event'] == 'todo.reordered') {
        Provider.of<TodoProvider>(
          context,
          listen: false,
        ).handleWebSocketUpdate({'event': data['event'], ...eventData});
      }
    });

    channel.sink.add(
      '{"event": "pusher:subscribe", "data": {"channel": "todos"}}',
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(titleLarge: TextStyle(fontSize: 28.0)),
      ),
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
