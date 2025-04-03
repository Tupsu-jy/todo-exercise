import 'package:flutter/material.dart';
import '../models/notepad.dart';
import '../services/company_service.dart';
import '../services/notepad_service.dart';
import '../services/cv_service.dart';

class CompanyProvider extends ChangeNotifier {
  final NotepadService _notepadService = NotepadService();
  String? companySlug;
  String? companyId;
  String? cvId;
  String? coverLetterId;
  int notepadOrderVersion = 0;
  List<Notepad> notepads = [];
  bool isLoading = true;
  Map<int, Map<String, dynamic>> cv = {};
  Map<String, dynamic> coverLetter = {};

  Future<void> initializeWithSlug(String slug) async {
    companySlug = slug;
    await fetchCompanyData();
    await Future.wait([fetchNotepads(), fetchCv(), fetchCoverLetter()]);
  }

  Future<void> fetchCompanyData() async {
    final company = await CompanyService().getCompany(companySlug!);
    companyId = company.id;
    coverLetterId = company.cover_letter_id;
    cvId = company.cv_id;
    notepadOrderVersion = company.order_version;
    notifyListeners();
  }

  Future<void> fetchNotepads() async {
    final notepads = await NotepadService().getNotepads(companyId!);
    this.notepads = notepads;
    notifyListeners();
  }

  Future<void> fetchCv() async {
    cv = await CvService().getCv(cvId!);
    notifyListeners();
  }

  Future<void> fetchCoverLetter() async {
    coverLetter = await CvService().getCoverLetter(coverLetterId!);
    notifyListeners();
  }

  int getCompanyOrderVersion() {
    return notepadOrderVersion;
  }

  /*
  void incrementCompanyOrderVersion() {
    notepadOrderVersion++;
    notifyListeners();
  }
*/
  // Gets the order version of a notepad's todos
  int getNotepadOrderVersion(String notepadId) {
    final notepad = notepads.firstWhere((notepad) => notepad.id == notepadId);
    return notepad.orderVersion;
  }

  // Increments the order version of a notepad's todos
  void incrementOrderVersion(String notepadId) {
    try {
      print('Attempting to increment order version for notepad: $notepadId');
      print('Current notepads: ${notepads.map((n) => n.id).toList()}');

      final notepad = notepads.firstWhere(
        (notepad) => notepad.id == notepadId,
        orElse: () {
          print('Notepad not found with ID: $notepadId');
          return Notepad(
            id: notepadId,
            name: '',
            companyId: companyId!,
            orderIndex: 0,
            orderVersion: 0,
          );
        },
      );

      if (notepad == null) {
        print('Warning: Could not increment order version - notepad not found');
        return;
      }

      print(
        'Found notepad, incrementing order version from: ${notepad.orderVersion}',
      );
      notepad.orderVersion++;
      print('New order version: ${notepad.orderVersion}');
      notifyListeners();
    } catch (e, stackTrace) {
      print('Error in incrementOrderVersion: $e');
      print('Stack trace: $stackTrace');
    }
  }

  Future<void> addNotepad(String name) async {
    try {
      final notepad = await _notepadService.addNotepad(name, companyId!);
      notepads.removeWhere((notepad) => notepad.id == 'optimistic_temp');
      notepads.add(notepad);
      notifyListeners();
    } catch (e) {
      await fetchNotepads();
      rethrow;
    }
  }

  Future<void> deleteNotepad(String id) async {
    try {
      await _notepadService.deleteNotepad(id);
    } catch (e) {
      await fetchNotepads();
      rethrow;
    }
  }

  Future<void> editNotepad(String id, String newName) async {
    try {
      await _notepadService.editNotepad(id, newName);
    } catch (e) {
      await fetchNotepads();
      rethrow;
    }
  }

  // TODO: this is so pointless
  Future<void> moveNotepad(
    String notepadId,
    String? beforeId,
    String? afterId,
    String companyId,
    int orderVersion,
  ) async {
    try {
      await _notepadService.moveNotepad(
        notepadId,
        beforeId,
        afterId,
        companyId,
        orderVersion,
      );
    } catch (e) {
      await fetchNotepads();
      rethrow;
    }
  }

  // WebSocket handlers
  void handleNotepadReordered(String notepadId, int newOrder) {
    for (var i = 0; i < notepads.length; i++) {
      if (notepads[i].id == notepadId) {
        notepads[i] = notepads[i].copyWith(orderIndex: newOrder);
        notepads.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
        notepadOrderVersion++;
        notifyListeners();
        return;
      }
    }
  }

  void handleNotepadCreated(Map<String, dynamic> notepadData, int orderIndex) {
    final notepad = Notepad.fromJson({
      ...notepadData,
      'order_index': orderIndex,
    });
    notepads.add(notepad);
    notepads.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
    notifyListeners();
  }

  void handleNotepadDeleted(String notepadId) {
    final beforeLength = notepads.length;
    notepads.removeWhere((notepad) => notepad.id == notepadId);
    if (notepads.length != beforeLength) {
      notifyListeners();
    }
  }

  void handleNotepadUpdated(Map<String, dynamic> notepadData) {
    final notepadId = notepadData['id'];
    for (var i = 0; i < notepads.length; i++) {
      if (notepads[i].id == notepadId) {
        notepads[i] = Notepad.fromJson({
          ...notepadData,
          'order_index': notepads[i].orderIndex, // Preserve existing order
        });
        notepadOrderVersion++;
        notifyListeners();
        break;
      }
    }
  }

  void updateNotepads(List<Notepad> newNotepads) {
    notepads = newNotepads;
    notifyListeners();
  }
}
