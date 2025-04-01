import 'package:flutter/material.dart';
import '../../models/todo.dart';
import '../../providers/todo_provider.dart';
import '../../controllers/todo_controller.dart';
import 'todo_dialogs.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final TodoProvider todoProvider;
  final TodoController controller;
  final int index;

  const TodoItem({
    Key? key,
    required this.todo,
    required this.todoProvider,
    required this.controller,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) => controller.deleteTodo(todoProvider, todo),
      child: ListTile(
        key: Key(todo.id),
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (bool? value) {
            if (value != null) {
              controller.toggleTodo(todoProvider, todo, value);
            }
          },
        ),
        title: Text(
          todo.description,
          style: TextStyle(
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed:
                  () => TodoDialogs.showEditDialog(
                    context,
                    todoProvider,
                    controller,
                    todo,
                  ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => controller.deleteTodo(todoProvider, todo),
            ),
            ReorderableDragStartListener(
              index: index,
              child: const Icon(Icons.drag_handle),
            ),
          ],
        ),
      ),
    );
  }
}
