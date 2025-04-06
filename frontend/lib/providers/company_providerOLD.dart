import 'package:flutter/material.dart';
import '../models/notepad.dart';
import '../models/todo.dart';
import '../services/company_service.dart';
import '../services/notepad_service.dart';
import '../services/cv_service.dart';
import '../services/todo_service.dart';

class CompanyProvider extends ChangeNotifier {
  final NotepadService _notepadService = NotepadService();
  final TodoService _todoService = TodoService();
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
  /*
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
      'order_version': 0,
      'order_index': orderIndex,
    });

    // Check if a notepad with this ID already exists
    final notepadExists = notepads.any((n) => n.id == notepad.id);

    if (!notepadExists) {
      notepads.removeWhere((notepad) => notepad.id == 'optimistic_temp');
      notepads.add(notepad);
      notepads.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
      notifyListeners();
    }
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
        notifyListeners();
        break;
      }
    }
  }
*/

  void updateNotepads(List<Notepad> newNotepads) {
    notepads = newNotepads;
    notifyListeners();
  }

  // Todo functions
  List<Todo> getTodosForNotepad(String notepadId) {
    return todosByNotepad[notepadId] ?? [];
  }

  // TODO: why are all these even here?
  Future<void> loadTodos(String notepadId) async {
    todosByNotepad[notepadId] = await _todoService.getTodos(notepadId);
    notifyListeners();
  }

  Future<void> addTodo(String message, String notepadId) async {
    try {
      final todo = await _todoService.addTodo(message, notepadId);
      todosByNotepad[notepadId]!.removeWhere(
        (todo) => todo.id == 'optimistic_temp',
      );
      todosByNotepad[notepadId]!.add(todo);
      notifyListeners();
    } catch (e) {
      await loadTodos(notepadId);
      rethrow;
    }
  }

  Future<void> deleteTodo(String id, String notepadId) async {
    try {
      await _todoService.deleteTodo(id);
    } catch (e) {
      await loadTodos(notepadId);
      rethrow;
    }
  }

  Future<void> editTodo(String id, String newMessage, String notepadId) async {
    try {
      await _todoService.editTodo(id, newMessage);
    } catch (e) {
      await loadTodos(notepadId);
      rethrow;
    }
  }

  Future<void> toggleTodo(String id, bool isDone, String notepadId) async {
    try {
      await _todoService.toggleTodo(id, isDone);
    } catch (e) {
      await loadTodos(notepadId);
      rethrow;
    }
  }

  Future<void> moveTodo(
    String todoId,
    String? beforeId,
    String? afterId,
    String notepadId,
    int orderVersion,
  ) async {
    try {
      await _todoService.moveTodo(
        todoId,
        beforeId,
        afterId,
        notepadId,
        orderVersion,
      );
      incrementOrderVersion(notepadId);
    } catch (e) {
      await loadTodos(notepadId);
      rethrow;
    }
  }

  /*
  // For when updates are received from the server via WebSocket
  void handleWebSocketUpdate(Map<String, dynamic> data) {
    if (data['event'] == 'todo.reordered') {
      final String todoId = data['todoId'];
      final int newOrder = data['newOrder'];

      todosByNotepad.forEach((notepadId, todos) {
        for (var i = 0; i < todos.length; i++) {
          if (todos[i].id == todoId) {
            todos[i] = Todo(
              id: todos[i].id,
              description: todos[i].description,
              isDone: todos[i].isDone,
              orderIndex: newOrder,
            );
            todos.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
            updateTodosForNotepad(notepadId, todos);
            return;
          }
        }
      });
    }
  }
  // Add these three new handlers:
  void handleTodoCreated(Map<String, dynamic> todoData, int orderIndex) {
    final todo = Todo(
      id: todoData['id'],
      description: todoData['description'],
      isDone: todoData['is_completed'] ?? false,
      orderIndex: orderIndex,
    );

    final notepadId = todoData['notepad_id'];
    if (todosByNotepad.containsKey(notepadId)) {
      todosByNotepad[notepadId]!.removeWhere(
        (todo) => todo.id == 'optimistic_temp',
      );
      todosByNotepad[notepadId]!.add(todo);
      todosByNotepad[notepadId]!.sort(
        (a, b) => a.orderIndex.compareTo(b.orderIndex),
      );
      notifyListeners();
    }
  }

  void handleTodoDeleted(String todoId) {
    todosByNotepad.forEach((notepadId, todos) {
      final beforeLength = todos.length;
      todos.removeWhere((todo) => todo.id == todoId);

      // Only notify if we actually removed something
      if (todos.length != beforeLength) {
        updateTodosForNotepad(notepadId, todos);
      }
    });
  }

  void handleTodoUpdated(Map<String, dynamic> todoData) {
    final todoId = todoData['id'];
    final notepadId = todoData['notepad_id'];

    if (todosByNotepad.containsKey(notepadId)) {
      final todos = todosByNotepad[notepadId]!;
      for (var i = 0; i < todos.length; i++) {
        if (todos[i].id == todoId) {
          todos[i] = Todo(
            id: todoId,
            description: todoData['description'],
            isDone: todoData['is_completed'] ?? todos[i].isDone,
            orderIndex: todos[i].orderIndex, // Preserve existing order
          );
          updateTodosForNotepad(notepadId, todos);
          break;
        }
      }
    }
  }
  */

  void updateTodosForNotepad(String notepadId, List<Todo> todos) {
    todosByNotepad[notepadId] = todos;
    notifyListeners();
  }
}
