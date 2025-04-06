import 'package:flutter/material.dart';
import '../models/notepad.dart';
import '../models/todo.dart';
import '../services/company_service.dart';
import '../services/notepad_service.dart';
import '../services/cv_service.dart';

class CompanyProvider extends ChangeNotifier {
  // State
  String? companySlug;
  String? companyId;
  String? cvId;
  String? coverLetterId;
  int notepadOrderVersion = 0;
  List<Notepad> notepads = [];
  Map<String, List<Todo>> todosByNotepad = {};
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

  // Getters
  List<Todo> getTodosForNotepad(String notepadId) {
    return todosByNotepad[notepadId] ?? [];
  }

  int getCompanyOrderVersion() {
    return notepadOrderVersion;
  }

  int getNotepadOrderVersion(String notepadId) {
    final notepad = notepads.firstWhere((notepad) => notepad.id == notepadId);
    return notepad.orderVersion;
  }

  // State update methods
  void updateCompanyData({
    required String id,
    required String? coverLetterId,
    required String? cvId,
    required int orderVersion,
  }) {
    companyId = id;
    this.coverLetterId = coverLetterId;
    this.cvId = cvId;
    notepadOrderVersion = orderVersion;
    notifyListeners();
  }

  void updateNotepads(List<Notepad> newNotepads) {
    notepads = newNotepads;
    notifyListeners();
  }

  void updateTodosForNotepad(String notepadId, List<Todo> todos) {
    todosByNotepad[notepadId] = todos;
    notifyListeners();
  }

  void updateCv(Map<int, Map<String, dynamic>> newCv) {
    cv = newCv;
    notifyListeners();
  }

  void updateCoverLetter(Map<String, dynamic> newCoverLetter) {
    coverLetter = newCoverLetter;
    notifyListeners();
  }

  void setCompanySlug(String slug) {
    companySlug = slug;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
