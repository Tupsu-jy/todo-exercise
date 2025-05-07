import 'package:frontend/controllers/notepad_controller.dart';
import 'package:frontend/models/notepad.dart';
import 'package:frontend/widgets/list_shared/list_dialogs.dart';
import 'package:frontend/widgets/notepad/todo_list_card.dart';
import 'package:flutter/material.dart';
import 'package:frontend/providers/company_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

// New widget for desktop view
class DesktopNotepadsView extends StatelessWidget {
  final String companyId;

  const DesktopNotepadsView({super.key, required this.companyId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = NotepadController(context, companyId);

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
                child: ReorderableGrid(
                  onReorder:
                      (oldIndex, newIndex) => controller.reorderNotepad(
                        companyProvider,
                        notepads,
                        oldIndex,
                        newIndex,
                      ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: notepads.length,
                  itemBuilder: (context, index) {
                    final notepad = notepads[index];
                    return TodoListCard(
                      index: index,
                      key: ValueKey(notepad.id),
                      notepad: notepad,
                    );
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
