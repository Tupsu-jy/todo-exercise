import 'package:flutter/material.dart';
import 'about_screen.dart';
import 'notepads_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.folder), text: 'Notepads'),
            Tab(icon: Icon(Icons.info), text: 'About'),
          ],
        ),
        body: TabBarView(children: [NotepadsScreen(), AboutScreen()]),
      ),
    );
  }
}
