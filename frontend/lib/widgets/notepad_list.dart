import 'package:flutter/material.dart';
//import '../services/notepad_service.dart';
import '../models/notepad.dart';
import '../screens/todo_list_screen.dart';
import '../providers/company_provider.dart';
import 'package:provider/provider.dart';

class NotepadList extends StatefulWidget {
  const NotepadList({super.key});

  @override
  _NotepadListState createState() => _NotepadListState();
}

class _NotepadListState extends State<NotepadList> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getNotepads();
  }

  Future<void> _getNotepads() async {
    // TODO: Implement notepad service
    setState(() {
      // Update notepads
    });
  }

  void _showEditDialog(BuildContext context, Notepad notepad) {
    final editController = TextEditingController(text: notepad.name);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit notepad'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(hintText: "Edit notepad name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                // TODO: Implement edit notepad
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

  Future<void> _deleteNotepad(String id) async {
    // TODO: Implement delete notepad
    await Future.delayed(Duration.zero); // Placeholder for async
    _getNotepads(); // Refresh list after deletion
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add new notepad'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: "Enter notepad name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                // TODO: Implement add notepad
                Navigator.of(context).pop();
                _controller.clear();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                _controller.clear();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(
      builder: (context, company, child) {
        // TODO: Implement loading state. This is buggy but nice idea
        // if (company.isLoading) {
        //   return CircularProgressIndicator();
        // }

        return Material(
          child: Stack(
            children: [
              ListView.builder(
                itemCount: company.notepads.length,
                itemBuilder: (context, index) {
                  final notepad = company.notepads[index];
                  return ListTile(
                    title: Text(notepad.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showEditDialog(context, notepad),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteNotepad(notepad.id),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  TodoListScreen(notepadId: notepad.id),
                        ),
                      );
                    },
                  );
                },
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: FloatingActionButton(
                  onPressed: () => _showAddDialog(context),
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
