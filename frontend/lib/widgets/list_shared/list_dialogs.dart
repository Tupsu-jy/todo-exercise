import 'package:flutter/material.dart';

class SharedDialogs {
  static void showAddDialog<T>({
    required BuildContext context,
    required String title,
    required String hintText,
    required TextEditingController textController,
    required Function(String) onAdd,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(hintText: hintText),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                onAdd(textController.text);
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

  static void showEditDialog<T>({
    required BuildContext context,
    required String title,
    required String hintText,
    required String initialText,
    required Function(String) onEdit,
  }) {
    final editController = TextEditingController(text: initialText);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(hintText: hintText),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                onEdit(editController.text);
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
