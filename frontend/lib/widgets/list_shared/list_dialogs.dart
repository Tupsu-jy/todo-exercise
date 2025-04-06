import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SharedDialogs {
  static void showAddDialog<T>({
    required BuildContext context,
    required String title,
    required String hintText,
    required TextEditingController textController,
    required Function(String) onAdd,
  }) {
    final l10n = AppLocalizations.of(context)!;

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
              child: Text(l10n.add),
              onPressed: () {
                onAdd(textController.text);
                Navigator.of(context).pop();
                textController.clear();
              },
            ),
            TextButton(
              child: Text(l10n.cancel),
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
    final l10n = AppLocalizations.of(context)!;
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
              child: Text(l10n.save),
              onPressed: () {
                onEdit(editController.text);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(l10n.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
