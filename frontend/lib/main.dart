import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('ws://your-laravel-url:6001/app/YOUR_KEY'),
  );

  @override
  void initState() {
    super.initState();
    channel.stream.listen((message) {
      print("Received: $message"); // Handle incoming todo updates
    });

    // Subscribe to the todos channel
    channel.sink.add('{"event": "subscribe", "channel": "todos"}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainScreen());
  }
}
