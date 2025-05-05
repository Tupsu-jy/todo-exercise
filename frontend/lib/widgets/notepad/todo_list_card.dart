import 'package:flutter/material.dart';
import 'package:frontend/controllers/notepad_controller.dart';
import 'package:frontend/models/notepad.dart';
import 'package:frontend/providers/company_provider.dart';
import 'package:frontend/screens/todo_list_screen.dart';
import 'package:frontend/widgets/list_shared/list_dialogs.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/widgets/todo_list.dart';

// Card widget to display each todo list in the grid
class TodoListCard extends StatelessWidget {
  final Notepad notepad;

  const TodoListCard({super.key, required this.notepad});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final companyProvider = Provider.of<CompanyProvider>(
      context,
      listen: false,
    );
    final controller = NotepadController(context, notepad.companyId);

    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and actions
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    notepad.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Action buttons
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      tooltip: l10n.editNotepad,
                      onPressed: () {
                        SharedDialogs.showEditDialog(
                          context: context,
                          title: l10n.editNotepad,
                          hintText: l10n.editNotepadName,
                          initialText: notepad.name,
                          onEdit:
                              (text) => controller.editNotepad(
                                companyProvider,
                                notepad,
                                text,
                              ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      tooltip: l10n.deleteNotepad,
                      onPressed: () {
                        controller.deleteNotepad(companyProvider, notepad);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          // Todo list for this notepad
          Expanded(child: TodoList(notepadId: notepad.id)),
        ],
      ),
    );
  }
}
