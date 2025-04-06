import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/company_provider.dart';
import '../models/todo.dart';
import '../controllers/todo_controller.dart';
import 'list_shared/list.dart';
import 'list_shared/list_dialogs.dart';

class TodoList extends StatefulWidget {
  final String notepadId;

  const TodoList({super.key, required this.notepadId});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _controller = TextEditingController();
  late TodoController controller;

  @override
  void initState() {
    super.initState();
    controller = TodoController(context, widget.notepadId);
    controller.loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(
      builder: (context, companyProvider, child) {
        final todos = companyProvider.getTodosForNotepad(widget.notepadId);

        return ReorderableListWidget<Todo>(
          items: todos,
          getTitle: (todo) => todo.description,
          getId: (todo) => 'todo-${todo.id}',
          onReorder:
              (oldIndex, newIndex) => controller.reorderTodo(
                companyProvider,
                todos,
                oldIndex,
                newIndex,
              ),
          onDelete: (todo) => controller.deleteTodo(companyProvider, todo),
          onEdit:
              (todo) => SharedDialogs.showEditDialog(
                context: context,
                title: 'Edit todo',
                hintText: 'Edit todo description',
                initialText: todo.description,
                onEdit:
                    (text) => controller.editTodo(companyProvider, todo, text),
              ),
          buildLeading:
              (todo) => Checkbox(
                value: todo.isDone,
                onChanged:
                    (value) => controller.toggleTodo(
                      companyProvider,
                      todo,
                      value ?? false,
                    ),
              ),
          onAdd:
              () => SharedDialogs.showAddDialog(
                context: context,
                title: 'Add a new todo',
                hintText: 'Enter todo description',
                textController: _controller,
                onAdd: (text) => controller.addTodo(companyProvider, text),
              ),
        );
      },
    );
  }
}
