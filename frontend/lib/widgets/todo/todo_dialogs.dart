import 'package:flutter/material.dart';
import '../../providers/todo_provider.dart';
import '../../models/todo.dart';
import '../../controllers/todo_controller.dart';

class TodoDialogs {
  static void showAddDialog(
    BuildContext context,
    TodoProvider todoProvider,
    TodoController controller,
    TextEditingController textController,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a new todo item'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(hintText: "Enter todo here"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                controller.addTodo(todoProvider, textController.text);
                Navigator.of(context).pop();
                textController.clear();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showEditDialog(
    BuildContext context,
    TodoProvider todoProvider,
    TodoController controller,
    Todo todo,
  ) {
    final editController = TextEditingController(text: todo.description);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit todo item'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(hintText: "Edit todo here"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                controller.editTodo(todoProvider, todo, editController.text);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
