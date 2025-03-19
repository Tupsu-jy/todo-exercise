import 'package:flutter/material.dart';
import '../services/todo_service.dart';
import '../models/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

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
    final fetchedTodos = await _todoService.getTodos();
    setState(() {
      todos = fetchedTodos;
    });
  }

  Future<void> _addTodo(String message) async {
    await _todoService.addTodo(message);
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
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final item = todos.removeAt(oldIndex);
                todos.insert(newIndex, item);
                // You might want to add a service method to update the order in backend
                // _todoService.updateOrder(todos);
              });
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
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
