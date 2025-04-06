import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../providers/company_provider.dart';
import '../config/env_config.dart';
import '../models/todo.dart';
import '../models/notepad.dart';

class WebSocketHandler {
  final CompanyProvider provider;
  late final WebSocketChannel channel;

  WebSocketHandler(this.provider) {
    channel = WebSocketChannel.connect(Uri.parse(EnvConfig.wsUrl));
    _initializeWebSocket();
  }

  void _initializeWebSocket() {
    channel.stream.listen((message) {
      print('message: $message');
      final data = jsonDecode(message);
      if (data['data'] == null ||
          data['data'].isEmpty ||
          data['event'] == null ||
          data['event'].isEmpty) {
        return;
      }
      final eventData = jsonDecode(data['data']);

      switch (data['event']) {
        case 'todo.reordered':
          handleWebSocketUpdate({'event': data['event'], ...eventData});
          break;

        case 'todo.created':
          handleTodoCreated(eventData['todo'], eventData['order_index']);
          break;

        case 'todo.deleted':
          handleTodoDeleted(eventData['todoId']);
          break;

        case 'todo.updated':
          handleTodoUpdated(eventData['todo']);
          break;

        case 'notepad.reordered':
          handleNotepadReordered(
            eventData['notepadId'],
            eventData['order_index'],
          );
          break;

        case 'notepad.created':
          handleNotepadCreated(eventData['notepad'], eventData['order_index']);
          break;

        case 'notepad.deleted':
          handleNotepadDeleted(eventData['notepadId']);
          break;

        case 'notepad.updated':
          handleNotepadUpdated(eventData['notepad']);
          break;
      }
    });

    channel.sink.add(
      '{"event": "pusher:subscribe", "data": {"channel": "todos"}}',
    );
    channel.sink.add(
      '{"event": "pusher:subscribe", "data": {"channel": "notepads"}}',
    );
  }

  void dispose() {
    channel.sink.close();
  }

  // Moving all the handlers from CompanyProvider
  void handleWebSocketUpdate(Map<String, dynamic> data) {
    if (data['event'] == 'todo.reordered') {
      final String todoId = data['todoId'];
      final int newOrder = data['order_index'];

      provider.todosByNotepad.forEach((notepadId, todos) {
        for (var i = 0; i < todos.length; i++) {
          if (todos[i].id == todoId) {
            todos[i] = Todo(
              id: todos[i].id,
              description: todos[i].description,
              isDone: todos[i].isDone,
              orderIndex: newOrder,
            );
            todos.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
            provider.updateTodosForNotepad(notepadId, todos);
            return;
          }
        }
      });
    }
  }

  void handleTodoCreated(Map<String, dynamic> todoData, int orderIndex) {
    final todo = Todo(
      id: todoData['id'],
      description: todoData['description'],
      isDone: todoData['is_completed'] ?? false,
      orderIndex: orderIndex,
    );

    final notepadId = todoData['notepad_id'];
    if (provider.todosByNotepad.containsKey(notepadId)) {
      provider.todosByNotepad[notepadId]!.removeWhere(
        (todo) => todo.id == 'optimistic_temp',
      );
      provider.todosByNotepad[notepadId]!.add(todo);
      provider.todosByNotepad[notepadId]!.sort(
        (a, b) => a.orderIndex.compareTo(b.orderIndex),
      );
      provider.notifyListeners();
    }
  }

  void handleTodoDeleted(String todoId) {
    provider.todosByNotepad.forEach((notepadId, todos) {
      final beforeLength = todos.length;
      todos.removeWhere((todo) => todo.id == todoId);

      if (todos.length != beforeLength) {
        provider.updateTodosForNotepad(notepadId, todos);
      }
    });
  }

  void handleTodoUpdated(Map<String, dynamic> todoData) {
    final todoId = todoData['id'];
    final notepadId = todoData['notepad_id'];

    if (provider.todosByNotepad.containsKey(notepadId)) {
      final todos = provider.todosByNotepad[notepadId]!;
      for (var i = 0; i < todos.length; i++) {
        if (todos[i].id == todoId) {
          todos[i] = Todo(
            id: todoId,
            description: todoData['description'],
            isDone: todoData['is_completed'] ?? todos[i].isDone,
            orderIndex: todos[i].orderIndex,
          );
          provider.updateTodosForNotepad(notepadId, todos);
          break;
        }
      }
    }
  }

  void handleNotepadReordered(String notepadId, int newOrder) {
    for (var i = 0; i < provider.notepads.length; i++) {
      if (provider.notepads[i].id == notepadId) {
        provider.notepads[i] = provider.notepads[i].copyWith(
          orderIndex: newOrder,
        );
        provider.notepads.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
        provider.notepadOrderVersion++;
        provider.notifyListeners();
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

    final notepadExists = provider.notepads.any((n) => n.id == notepad.id);

    if (!notepadExists) {
      provider.notepads.removeWhere(
        (notepad) => notepad.id == 'optimistic_temp',
      );
      provider.notepads.add(notepad);
      provider.notepads.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
      provider.notifyListeners();
    }
  }

  void handleNotepadDeleted(String notepadId) {
    final beforeLength = provider.notepads.length;
    provider.notepads.removeWhere((notepad) => notepad.id == notepadId);
    if (provider.notepads.length != beforeLength) {
      provider.notifyListeners();
    }
  }

  void handleNotepadUpdated(Map<String, dynamic> notepadData) {
    final notepadId = notepadData['id'];
    for (var i = 0; i < provider.notepads.length; i++) {
      if (provider.notepads[i].id == notepadId) {
        provider.notepads[i] = Notepad.fromJson({
          ...notepadData,
          'order_index': provider.notepads[i].orderIndex,
        });
        provider.notifyListeners();
        break;
      }
    }
  }
}
