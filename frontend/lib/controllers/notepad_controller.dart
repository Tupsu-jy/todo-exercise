import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/company_provider.dart';
import '../models/notepad.dart';

class NotepadController {
  final BuildContext context;

  NotepadController(this.context);

  CompanyProvider _getCompanyProvider() {
    return Provider.of<CompanyProvider>(context, listen: false);
  }

  void addNotepad(CompanyProvider companyProvider, String name) {
    // TODO: Implement optimistic update and API call
    // Similar to TodoController but for notepads
  }

  void editNotepad(
    CompanyProvider companyProvider,
    Notepad notepad,
    String newName,
  ) {
    // TODO: Implement optimistic update and API call
    // Similar to TodoController.editTodo
  }

  void deleteNotepad(CompanyProvider companyProvider, Notepad notepad) {
    // TODO: Implement optimistic update and API call
    // Similar to TodoController.deleteTodo
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
    //final orderVersion = _getCompanyProvider().getOrderVersion(companyId);

    // TODO: Implement optimistic update and API call
    // Similar to TodoController.reorderTodo
    try {
      // await companyProvider.moveNotepad(...)
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to move notepad')));
      }
    }
  }
}
