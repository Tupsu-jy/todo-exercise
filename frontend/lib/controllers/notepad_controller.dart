import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/company_provider.dart';
import '../models/notepad.dart';
import '../services/notepad_service.dart';

class NotepadController {
  final BuildContext context;
  final String companyId;
  final NotepadService _notepadService = NotepadService();

  NotepadController(this.context, this.companyId);

  CompanyProvider _getProvider() {
    return Provider.of<CompanyProvider>(context, listen: false);
  }

  Future<void> loadNotepads() async {
    final provider = _getProvider();
    final notepads = await _notepadService.getNotepads(companyId);
    provider.updateNotepads(notepads);
  }

  Future<void> addNotepad(CompanyProvider provider, String name) async {
    // Create optimistic notepad
    final newNotepad = Notepad(
      id: 'optimistic_temp',
      name: name,
      orderIndex: 2147483647,
      companyId: companyId,
      orderVersion: 0,
    );

    // Update UI optimistically
    final notepads = [...provider.notepads, newNotepad];
    provider.updateNotepads(notepads);

    // Make API call
    try {
      final notepad = await _notepadService.addNotepad(name, companyId);
    } catch (e) {
      print(e);
      loadNotepads(); // Revert on error
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to add notepad')));
      }
    }
  }

  void editNotepad(CompanyProvider provider, Notepad notepad, String newName) {
    // Update optimistically
    final notepads =
        provider.notepads
            .map((n) => n.id == notepad.id ? n.copyWith(name: newName) : n)
            .toList();
    provider.updateNotepads(notepads);

    // Make API call
    _notepadService.editNotepad(notepad.id, newName).catchError((e) {
      loadNotepads(); // Revert on error
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to edit notepad')));
      }
    });
  }

  void deleteNotepad(CompanyProvider provider, Notepad notepad) {
    // Remove optimistically
    final notepads = [...provider.notepads];
    notepads.removeWhere((n) => n.id == notepad.id);
    provider.updateNotepads(notepads);

    // Make API call
    _notepadService.deleteNotepad(notepad.id).catchError((e) {
      loadNotepads(); // Revert on error
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to delete notepad')));
      }
    });
  }

  Future<void> reorderNotepad(
    CompanyProvider provider,
    List<Notepad> notepads,
    int oldIndex,
    int newIndex,
  ) async {
    print('oldindex: $oldIndex');
    print('newindex: $newIndex');

    // There is no need to check if newIndex is greater than oldIndex here
    // because that is moved to function call for mobile and for desktop
    // it would brake things

    // Optimistically update the list
    final movedNotepad = notepads.removeAt(oldIndex);
    notepads.insert(newIndex, movedNotepad);
    provider.updateNotepads(notepads);

    // Get IDs for API call
    final String? beforeId = newIndex > 0 ? notepads[newIndex - 1].id : null;
    final String? afterId =
        newIndex < notepads.length - 1 ? notepads[newIndex + 1].id : null;

    try {
      await _notepadService.moveNotepad(
        movedNotepad.id,
        beforeId,
        afterId,
        companyId,
        provider.getCompanyOrderVersion(),
      );
    } catch (e) {
      await loadNotepads(); // Revert on error
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to move notepad')));
      }
    }
  }
}
