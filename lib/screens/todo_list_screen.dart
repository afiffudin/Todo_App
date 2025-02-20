import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../models/todo.dart';
import '../widgets/todo_item.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TodoProvider>(context, listen: false).fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO List'),
        backgroundColor: Colors.blueAccent,
      ),
      body: todoProvider.todos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: todoProvider.todos.length,
              itemBuilder: (context, index) {
                final todo = todoProvider.todos[index];
                return TodoItem(
                  todo: todo,
                  onEdit: () => _showEditTodoDialog(context, todo),
                  onDelete: () => todoProvider.deleteTodo(todo.id),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context),
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Menambah TODO APP'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                Provider.of<TodoProvider>(context, listen: false)
                    .addTodo(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Tambahkan'),
          ),
        ],
      ),
    );
  }

  void _showEditTodoDialog(BuildContext context, Todo todo) {
    final TextEditingController controller =
        TextEditingController(text: todo.title);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ubah TODO'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                Provider.of<TodoProvider>(context, listen: false)
                    .updateTodoTitle(todo.id, controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
