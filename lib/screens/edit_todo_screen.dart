import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/api_service.dart';
import '../services/notification_service.dart';

class EditTodoScreen extends StatefulWidget {
  final Todo todo;

  const EditTodoScreen({Key? key, required this.todo}) : super(key: key);

  @override
  _EditTodoScreenState createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final TextEditingController _controller = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.todo.title;
  }

  Future<void> _updateTodo(BuildContext context) async {
    await _apiService.updateTodo(widget.todo.id, _controller.text);
    NotificationService.showNotification('Updated', 'TODO updated successfully');
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit TODO')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _controller, decoration: InputDecoration(labelText: 'Title')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => _updateTodo(context), child: Text('Update'))
          ],
        ),
      ),
    );
  }
}
