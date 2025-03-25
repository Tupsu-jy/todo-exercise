import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../models/todo.dart';

class TodoList extends StatefulWidget {
  final String notepadId;

  const TodoList({super.key, required this.notepadId});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load todos when widget initializes
    Provider.of<TodoProvider>(
      context,
      listen: false,
    ).loadTodos(widget.notepadId);
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a new todo item'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Enter todo here"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                Provider.of<TodoProvider>(
                  context,
                  listen: false,
                ).addTodo(_controller.text, widget.notepadId);
                Navigator.of(context).pop();
                _controller.clear();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, Todo todo) {
    final editController = TextEditingController(text: todo.description);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit todo item'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(hintText: "Edit todo here"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                Provider.of<TodoProvider>(
                  context,
                  listen: false,
                ).editTodo(todo.id, editController.text, widget.notepadId);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
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
                onReorder: (oldIndex, newIndex) async {
                  if (newIndex > oldIndex) newIndex--;

                  // Get IDs for API call
                  final String? beforeId =
                      newIndex > 0 ? todos[newIndex - 1].id : null;
                  final String? afterId =
                      newIndex < todos.length - 1 ? todos[newIndex].id : null;

                  // Optimistically update the list
                  final movedTodo = todos.removeAt(oldIndex);
                  todos.insert(newIndex, movedTodo);
                  todoProvider.updateTodosForNotepad(widget.notepadId, todos);

                  try {
                    // Make the API call
                    await todoProvider.moveTodo(
                      movedTodo.id,
                      beforeId,
                      afterId,
                      widget.notepadId,
                    );
                  } catch (e) {
                    // If the API call fails, reload the list to get the correct order
                    await todoProvider.loadTodos(widget.notepadId);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to move todo')),
                      );
                    }
                  }
                },
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Dismissible(
                    key: Key(todo.id),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed:
                        (direction) =>
                            todoProvider.deleteTodo(todo.id, widget.notepadId),
                    child: ListTile(
                      key: Key(todo.id),
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (bool? value) {
                          if (value != null) {
                            todoProvider.toggleTodo(
                              todo.id,
                              value,
                              widget.notepadId,
                            );
                          }
                        },
                      ),
                      title: Text(
                        todo.description,
                        style: TextStyle(
                          decoration:
                              todo.isDone ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _showEditDialog(context, todo),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed:
                                () => todoProvider.deleteTodo(
                                  todo.id,
                                  widget.notepadId,
                                ),
                          ),
                          ReorderableDragStartListener(
                            index: index,
                            child: const Icon(Icons.drag_handle),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: FloatingActionButton(
                  onPressed: () => _showAddDialog(context),
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
