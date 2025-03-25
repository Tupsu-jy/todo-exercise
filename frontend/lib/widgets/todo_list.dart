import 'package:flutter/material.dart';
import '../services/todo_service.dart';
import '../models/todo.dart';

class TodoList extends StatefulWidget {
  final String notepadId;

  const TodoList({super.key, required this.notepadId});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> todos = [];
  final TodoService _todoService = TodoService();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getTodos();
  }

  Future<void> _getTodos() async {
    final fetchedTodos = await _todoService.getTodos(widget.notepadId);
    setState(() {
      todos = fetchedTodos;
    });
  }

  Future<void> _addTodo(String message) async {
    await _todoService.addTodo(message, widget.notepadId);
    _getTodos();
  }

  Future<void> _editTodo(String newMessage, String id) async {
    await _todoService.editTodo(id, newMessage);
    _getTodos();
  }

  Future<void> _deleteTodo(String id) async {
    await _todoService.deleteTodo(id);
    _getTodos();
  }

  Future<void> _toggleTodo(String id, bool isDone) async {
    await _todoService.toggleTodo(id, isDone);
    _getTodos();
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
                _addTodo(_controller.text);
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
                _editTodo(editController.text, todo.id);
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
    return Material(
      child: Stack(
        children: [
          ReorderableListView.builder(
            itemCount: todos.length,
            onReorder: (oldIndex, newIndex) async {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final item = todos.removeAt(oldIndex);
                todos.insert(newIndex, item);
              });

              try {
                // Get the IDs of the todos before and after the moved item
                String? beforeId = newIndex > 0 ? todos[newIndex - 1].id : null;
                String? afterId =
                    newIndex < todos.length - 1 ? todos[newIndex + 1].id : null;

                await _todoService.moveTodo(
                  todos[newIndex].id, // moved todo
                  beforeId, // todo before new position
                  afterId, // todo after new position
                  widget.notepadId, // notepad id
                );
              } catch (e) {
                // If the move fails, refresh the list to get the correct order
                _getTodos();
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
                onDismissed: (direction) => _deleteTodo(todo.id),
                child: ListTile(
                  key: Key(todo.id),
                  leading: Checkbox(
                    value: todo.isDone,
                    onChanged: (bool? value) {
                      if (value != null) {
                        _toggleTodo(todo.id, value);
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
                        onPressed: () => _deleteTodo(todo.id),
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
  }
}
