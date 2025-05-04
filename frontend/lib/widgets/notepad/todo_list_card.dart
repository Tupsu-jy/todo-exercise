import 'package:flutter/material.dart';
import 'package:frontend/models/notepad.dart';
import 'package:frontend/widgets/todo_list.dart';

// Card widget to display each todo list in the grid
class TodoListCard extends StatelessWidget {
  final Notepad notepad;

  const TodoListCard({super.key, required this.notepad});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notepad title
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                notepad.name,
                style: Theme.of(context).textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Divider(),
            // Todo list for this notepad
            Expanded(child: TodoList(notepadId: notepad.id)),
          ],
        ),
      ),
    );
  }
}
