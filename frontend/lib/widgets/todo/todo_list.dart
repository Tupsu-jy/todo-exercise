import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/todo_provider.dart';
import '../../models/todo.dart';
import '../../controllers/todo_controller.dart';
import 'todo_item.dart';
import 'todo_dialogs.dart';

class TodoList extends StatefulWidget {
  final String notepadId;

  const TodoList({super.key, required this.notepadId});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _controller = TextEditingController();
  late TodoController controller;

  @override
  void initState() {
    super.initState();
    // Load todos when widget initializes
    Provider.of<TodoProvider>(
      context,
      listen: false,
    ).loadTodos(widget.notepadId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = TodoController(context, widget.notepadId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        final todos = todoProvider.getTodosForNotepad(widget.notepadId);

        return Material(
          child: Stack(
            children: [
              ReorderableListView.builder(
                itemCount: todos.length,
                onReorder:
                    (oldIndex, newIndex) => controller.reorderTodo(
                      todoProvider,
                      todos,
                      oldIndex,
                      newIndex,
                    ),
                itemBuilder: (context, index) {
                  return TodoItem(
                    key: Key(todos[index].id),
                    todo: todos[index],
                    todoProvider: todoProvider,
                    controller: controller,
                    index: index,
                  );
                },
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: FloatingActionButton(
                  onPressed:
                      () => TodoDialogs.showAddDialog(
                        context,
                        todoProvider,
                        controller,
                        _controller,
                      ),
                  backgroundColor: Colors.blue,
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
