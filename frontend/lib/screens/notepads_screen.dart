import 'package:flutter/material.dart';
import '../widgets/notepad_list.dart';
import '../providers/company_provider.dart';
import 'package:provider/provider.dart';
import '../models/notepad.dart';
import '../widgets/todo_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/list_shared/list_dialogs.dart';
import '../controllers/notepad_controller.dart';

class NotepadsScreen extends StatelessWidget {
  const NotepadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if we're on a desktop-sized screen (wider than 600dp)
    final bool isDesktop = MediaQuery.of(context).size.width > 600;

    return Consumer<CompanyProvider>(
      builder: (context, companyProvider, child) {
        // Show loading indicator while companyId is null
        if (companyProvider.companyId == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // Desktop view - show all todo lists in a grid
        if (isDesktop) {
          return DesktopNotepadsView(companyId: companyProvider.companyId!);
        }

        // Mobile view - show list of notepads
        return NotepadList(companyId: companyProvider.companyId!);
      },
    );
  }
}

// New widget for desktop view
class DesktopNotepadsView extends StatelessWidget {
  final String companyId;

  const DesktopNotepadsView({super.key, required this.companyId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Consumer<CompanyProvider>(
      builder: (context, companyProvider, child) {
        final List<Notepad> notepads = companyProvider.notepads;

        if (notepads.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("qweqwe"),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Reuse the add functionality from NotepadController
                    final controller = NotepadController(context, companyId);
                    final TextEditingController textController =
                        TextEditingController();

                    SharedDialogs.showAddDialog(
                      context: context,
                      title: l10n.addNewNotepad,
                      hintText: l10n.enterNotepadName,
                      textController: textController,
                      onAdd:
                          (text) =>
                              controller.addNotepad(companyProvider, text),
                    );
                  },
                  child: Text(l10n.addNewNotepad),
                ),
              ],
            ),
          );
        }

        // Calculate the number of columns based on width
        final double width = MediaQuery.of(context).size.width;
        final int crossAxisCount = (width / 400).floor().clamp(1, 4);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.notepads,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: Text(l10n.addNewNotepad),
                    onPressed: () {
                      // Reuse the add functionality from NotepadController
                      final controller = NotepadController(context, companyId);
                      final TextEditingController textController =
                          TextEditingController();

                      SharedDialogs.showAddDialog(
                        context: context,
                        title: l10n.addNewNotepad,
                        hintText: l10n.enterNotepadName,
                        textController: textController,
                        onAdd:
                            (text) =>
                                controller.addNotepad(companyProvider, text),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: notepads.length,
                  itemBuilder: (context, index) {
                    final notepad = notepads[index];
                    return TodoListCard(notepad: notepad);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

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
