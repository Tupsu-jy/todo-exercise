import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/company_provider.dart';
import '../models/notepad.dart';
import '../widgets/list_shared/list.dart';
import '../widgets/list_shared/list_dialogs.dart';
import '../controllers/notepad_controller.dart';
import '../screens/todo_list_screen.dart';

class NotepadList extends StatefulWidget {
  const NotepadList({super.key});

  @override
  State<NotepadList> createState() => _NotepadListState();
}

class _NotepadListState extends State<NotepadList> {
  final TextEditingController _controller = TextEditingController();
  late NotepadController controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = NotepadController(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(
      builder: (context, companyProvider, child) {
        final notepads = companyProvider.notepads;

        return ReorderableListWidget<Notepad>(
          items: notepads,
          getTitle: (notepad) => notepad.name,
          getId: (notepad) => notepad.id,
          onReorder:
              (oldIndex, newIndex) => controller.reorderNotepad(
                companyProvider,
                notepads,
                oldIndex,
                newIndex,
              ),
          onDelete:
              (notepad) => controller.deleteNotepad(companyProvider, notepad),
          onEdit:
              (notepad) => SharedDialogs.showEditDialog(
                context: context,
                title: 'Edit notepad',
                hintText: 'Edit notepad name',
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
                title: 'Add a new notepad',
                hintText: 'Enter notepad name',
                textController: _controller,
                onAdd: (text) => controller.addNotepad(companyProvider, text),
              ),
        );
      },
    );
  }
}
