import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:provider/provider.dart';
import 'providers/company_provider.dart';
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
    ChangeNotifierProvider(
      create: (context) => CompanyProvider()..initializeWithSlug(companySlug),
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
      if (data['data'] == null ||
          data['data'].isEmpty ||
          data['event'] == null ||
          data['event'].isEmpty) {
        return;
      }
      final eventData = jsonDecode(data['data']);

      final provider = Provider.of<CompanyProvider>(context, listen: false);

      switch (data['event']) {
        case 'todo.reordered':
          provider.handleWebSocketUpdate({
            'event': data['event'],
            ...eventData,
          });
          break;

        case 'todo.created':
          provider.handleTodoCreated(
            eventData['todo'],
            eventData['orderIndex'],
          );
          break;

        case 'todo.deleted':
          provider.handleTodoDeleted(eventData['todoId']);
          break;

        case 'todo.updated':
          provider.handleTodoUpdated(eventData['todo']);
          break;

        case 'notepad.reordered':
          provider.handleNotepadReordered(
            eventData['notepadId'],
            eventData['newOrder'],
          );
          break;

        case 'notepad.created':
          provider.handleNotepadCreated(
            eventData['notepad'],
            eventData['newOrder'],
          );
          break;

        case 'notepad.deleted':
          provider.handleNotepadDeleted(eventData['notepadId']);
          break;

        case 'notepad.updated':
          provider.handleNotepadUpdated(eventData['notepad']);
          break;
      }
    });

    channel.sink.add(
      '{"event": "pusher:subscribe", "data": {"channel": "todos"}}',
    );
    channel.sink.add(
      '{"event": "pusher:subscribe", "data": {"channel": "notepads"}}',
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
