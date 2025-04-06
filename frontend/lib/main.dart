import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:provider/provider.dart';
import 'providers/company_provider.dart';
import 'config/env_config.dart';
import 'dart:convert';
import 'services/websocket_handler.dart';

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

  final provider = CompanyProvider();
  final wsHandler = WebSocketHandler(provider);

  runApp(
    ChangeNotifierProvider(
      create: (context) => provider..initializeWithSlug(companySlug),
      child: MyApp(wsHandler: wsHandler),
    ),
  );
}

class MyApp extends StatefulWidget {
  final WebSocketHandler wsHandler;

  const MyApp({super.key, required this.wsHandler});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    widget.wsHandler.dispose();
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
