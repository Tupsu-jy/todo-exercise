import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../providers/company_provider.dart';
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

  // Helper method to get CompanyProvider
  CompanyProvider _getCompanyProvider() {
    return Provider.of<CompanyProvider>(context, listen: false);
  }

  void _showAddDialog(BuildContext context, TodoProvider todoProvider) {
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
                _addTodo(todoProvider, _controller.text);
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

  void _addTodo(TodoProvider todoProvider, String description) {
    // Create optimistic todo
    final newTodo = Todo(
      id: 'optimistic_temp',
      description: description,
      isDone: false,
      orderIndex: 2147483647, // Using maximum integer value
    );

    // Update UI optimistically
    final todos = [
      ...todoProvider.getTodosForNotepad(widget.notepadId),
      newTodo,
    ];
    todoProvider.updateTodosForNotepad(widget.notepadId, todos);

    // Make API call
    todoProvider.addTodo(description, widget.notepadId);
  }

  void _showEditDialog(
    BuildContext context,
    TodoProvider todoProvider,
    Todo todo,
  ) {
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
                _editTodo(todoProvider, todo, editController.text);
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

  void _editTodo(TodoProvider todoProvider, Todo todo, String newDescription) {
    // Update optimistically
    final todos =
        todoProvider
            .getTodosForNotepad(widget.notepadId)
            .map(
              (t) =>
                  t.id == todo.id ? t.copyWith(description: newDescription) : t,
            )
            .toList();
    todoProvider.updateTodosForNotepad(widget.notepadId, todos);

    // Make API call
    todoProvider.editTodo(todo.id, newDescription, widget.notepadId);
  }

  void _deleteTodo(TodoProvider todoProvider, Todo todo) {
    // Remove optimistically
    final todos = [...todoProvider.getTodosForNotepad(widget.notepadId)];
    todos.removeWhere((t) => t.id == todo.id);
    todoProvider.updateTodosForNotepad(widget.notepadId, todos);

    // Make API call
    todoProvider.deleteTodo(todo.id, widget.notepadId);
  }

  void _toggleTodo(TodoProvider todoProvider, Todo todo, bool newValue) {
    // Update optimistically
    final todos =
        todoProvider
            .getTodosForNotepad(widget.notepadId)
            .map((t) => t.id == todo.id ? t.copyWith(isDone: newValue) : t)
            .toList();
    todoProvider.updateTodosForNotepad(widget.notepadId, todos);

    // Make API call
    todoProvider.toggleTodo(todo.id, newValue, widget.notepadId);
  }

  void _reorderTodo(
    TodoProvider todoProvider,
    List<Todo> todos,
    int oldIndex,
    int newIndex,
  ) async {
    if (newIndex > oldIndex) newIndex--;

    // Get IDs for API call
    final String? beforeId = newIndex > 0 ? todos[newIndex - 1].id : null;
    final String? afterId =
        newIndex < todos.length - 1 ? todos[newIndex].id : null;

    // Get the version from CompanyProvider
    final orderVersion = _getCompanyProvider().getOrderVersion(
      widget.notepadId,
    );

    // Optimistically update the list
    final movedTodo = todos.removeAt(oldIndex);
    todos.insert(newIndex, movedTodo);
    todoProvider.updateTodosForNotepad(widget.notepadId, todos);

    try {
      await todoProvider.moveTodo(
        movedTodo.id,
        beforeId,
        afterId,
        widget.notepadId,
        orderVersion,
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to move todo')));
      }
    }
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
                    (oldIndex, newIndex) =>
                        _reorderTodo(todoProvider, todos, oldIndex, newIndex),
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Dismissible(
                    key: Key(todo.id),
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 8.0,
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 24),
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) => _deleteTodo(todoProvider, todo),
                    child: ListTile(
                      key: Key(todo.id),
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (bool? value) {
                          if (value != null) {
                            _toggleTodo(todoProvider, todo, value);
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
                            onPressed:
                                () => _showEditDialog(
                                  context,
                                  todoProvider,
                                  todo,
                                ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteTodo(todoProvider, todo),
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
                  onPressed: () => _showAddDialog(context, todoProvider),
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
