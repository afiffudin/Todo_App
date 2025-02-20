import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/api_service.dart';
import '../services/notification_service.dart';
import 'add_todo_screen.dart';
import 'edit_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    NotificationService.init();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    _todos = await _apiService.fetchTodos();
    setState(() {});
  }

  Future<void> _deleteTodo(int id) async {
    await _apiService.deleteTodo(id);
    NotificationService.showNotification('Deleted', 'TODO deleted successfully');
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TODO App')),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return ListTile(
            title: Text(todo.title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTodoScreen(todo: todo),
                    ),
                  ).then((value) => _loadTodos()),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteTodo(todo.id),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTodoScreen()),
        ).then((value) => _loadTodos()),
        child: Icon(Icons.add),
      ),
    );
  }
}
