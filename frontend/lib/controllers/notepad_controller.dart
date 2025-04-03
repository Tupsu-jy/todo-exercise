import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/company_provider.dart';
import '../models/notepad.dart';

class NotepadController {
  final BuildContext context;
  final String companyId;

  NotepadController(this.context, this.companyId);

  CompanyProvider _getCompanyProvider() {
    return Provider.of<CompanyProvider>(context, listen: false);
  }

  void addNotepad(CompanyProvider companyProvider, String name) {
    // Create optimistic notepad
    final newNotepad = Notepad(
      id: 'optimistic_temp',
      name: name,
      orderIndex: 2147483647, // Using maximum integer value
    );

    // Update UI optimistically
    final notepads = [...companyProvider.notepads, newNotepad];
    companyProvider.updateNotepads(notepads);

    // Make API call
    companyProvider.addNotepad(name);
  }

  void editNotepad(
    CompanyProvider companyProvider,
    Notepad notepad,
    String newName,
  ) {
    // Update optimistically
    final notepads =
        companyProvider.notepads
            .map((n) => n.id == notepad.id ? n.copyWith(name: newName) : n)
            .toList();
    companyProvider.updateNotepads(notepads);

    // Make API call
    companyProvider.editNotepad(notepad.id, newName);
  }

  void deleteNotepad(CompanyProvider companyProvider, Notepad notepad) {
    // Remove optimistically
    final notepads = [...companyProvider.notepads];
    notepads.removeWhere((n) => n.id == notepad.id);
    companyProvider.updateNotepads(notepads);

    // Make API call
    companyProvider.deleteNotepad(notepad.id);
  }

  Future<void> reorderNotepad(
    CompanyProvider companyProvider,
    List<Notepad> notepads,
    int oldIndex,
    int newIndex,
  ) async {
    if (newIndex > oldIndex) newIndex--;

    // Get IDs for API call
    final String? beforeId = newIndex > 0 ? notepads[newIndex - 1].id : null;
    final String? afterId =
        newIndex < notepads.length - 1 ? notepads[newIndex].id : null;

    // Get the version from CompanyProvider
    final orderVersion = _getCompanyProvider().getNotepadOrderVersion(
      companyId,
    );

    // Optimistically update the list
    final movedNotepad = notepads.removeAt(oldIndex);
    notepads.insert(newIndex, movedNotepad);
    companyProvider.updateNotepads(notepads);

    try {
      await companyProvider.moveNotepad(
        movedNotepad.id,
        beforeId,
        afterId,
        companyId,
        orderVersion,
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to move notepad')));
      }
    }
  }
}
