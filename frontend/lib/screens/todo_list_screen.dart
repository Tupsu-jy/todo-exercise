import 'package:flutter/material.dart';
import '../widgets/todo_list.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoList(); // Just the content, no Scaffold or AppBar needed
  }
}
