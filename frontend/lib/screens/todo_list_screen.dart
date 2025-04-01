import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/todo/todo_list.dart';
import '../providers/company_provider.dart';

class TodoListScreen extends StatelessWidget {
  final String notepadId;

  const TodoListScreen({super.key, required this.notepadId});

  @override
  Widget build(BuildContext context) {
    final companyProvider = Provider.of<CompanyProvider>(context);
    final notepad = companyProvider.notepads.firstWhere(
      (notepad) => notepad.id == notepadId,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(notepad.name),
      ),
      body: TodoList(notepadId: notepadId),
    );
  }
}
