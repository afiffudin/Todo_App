import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/todo.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<void> fetchTodos() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos?_limit=10'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _todos = data.map((json) => Todo.fromJson(json)).toList();
      notifyListeners();
    }
  }

  void addTodo(String title) {
    final newTodo = Todo(id: _todos.length + 1, title: title, completed: false);
    _todos.add(newTodo);
    notifyListeners();
    _showToast("TODO APP Berhasil Ditambahkan Gess!");
  }

  void updateTodoTitle(int id, String newTitle) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] = Todo(id: id, title: newTitle, completed: _todos[index].completed);
      notifyListeners();
      _showToast("TODO APP Berhasil di ubah!!");
    }
  }

  void deleteTodo(int id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
    _showToast("TODO APP Berhasil di delete !");
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }
}
