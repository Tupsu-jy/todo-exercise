import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/company_provider.dart';
import '../../models/notepad.dart';
import '../list_shared/list.dart';
import '../list_shared/list_dialogs.dart';
import '../../controllers/notepad_controller.dart';
import '../../screens/todo_list_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotepadList extends StatefulWidget {
  final String companyId;

  const NotepadList({super.key, required this.companyId});

  @override
  State<NotepadList> createState() => _NotepadListState();
}

class _NotepadListState extends State<NotepadList> {
  final TextEditingController _controller = TextEditingController();
  late NotepadController controller;
  late AppLocalizations l10n;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = NotepadController(context, widget.companyId);
    l10n = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(
      builder: (context, companyProvider, child) {
        final notepads = companyProvider.notepads;

        return ReorderableListWidget<Notepad>(
          items: notepads,
          getTitle: (notepad) => notepad.name,
          getId: (notepad) => 'notepad-${notepad.id}',
          onReorder: (oldIndex, newIndex) {
            if (newIndex > oldIndex) {
              newIndex--;
            }
            controller.reorderNotepad(
              companyProvider,
              notepads,
              oldIndex,
              newIndex,
            );
          },
          onDelete:
              (notepad) => controller.deleteNotepad(companyProvider, notepad),
          onEdit:
              (notepad) => SharedDialogs.showEditDialog(
                context: context,
                title: l10n.editNotepad,
                hintText: l10n.editNotepadName,
                initialText: notepad.name,
                onEdit:
                    (text) =>
                        controller.editNotepad(companyProvider, notepad, text),
              ),
          onTap:
              (notepad) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoListScreen(notepadId: notepad.id),
                ),
              ),
          onAdd:
              () => SharedDialogs.showAddDialog(
                context: context,
                title: l10n.addNewNotepad,
                hintText: l10n.enterNotepadName,
                textController: _controller,
                onAdd: (text) => controller.addNotepad(companyProvider, text),
              ),
        );
      },
    );
  }
}
