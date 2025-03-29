import 'package:flutter/material.dart';
import '../models/notepad.dart';
import '../services/company_service.dart';
import '../services/notepad_service.dart';
import '../services/cv_service.dart';

class CompanyProvider extends ChangeNotifier {
  String? companySlug;
  String? companyId;
  String? cvId;
  String? coverLetterId;
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

  int getOrderVersion(String notepadId) {
    final notepad = notepads.firstWhere((notepad) => notepad.id == notepadId);
    return notepad.orderVersion;
  }
}
