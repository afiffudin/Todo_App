import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/notification_service.dart';

class AddTodoScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final ApiService _apiService = ApiService();

  Future<void> _saveTodo(BuildContext context) async {
    await _apiService.addTodo(_controller.text);
    NotificationService.showNotification('Added', 'TODO added successfully');
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add TODO')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _controller, decoration: InputDecoration(labelText: 'Title')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => _saveTodo(context), child: Text('Save'))
          ],
        ),
      ),
    );
  }
}
