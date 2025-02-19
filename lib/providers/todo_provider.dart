import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/todo.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];
  bool isLoading = false;

  List<Todo> get todos => _todos;

  Future<void> fetchTodos() async {
    isLoading = true;
    notifyListeners();
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos?_limit=10'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _todos = data.map((json) => Todo.fromJson(json)).toList();
    }
    isLoading = false;
    notifyListeners();
  }

  void addTodo(String title) {
    final newTodo = Todo(id: _todos.length + 1, title: title, completed: false);
    _todos.add(newTodo);
    notifyListeners();
  }

  void updateTodo(int id, bool completed) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] = Todo(id: id, title: _todos[index].title, completed: completed);
      notifyListeners();
    }
  }

  void deleteTodo(int id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}
