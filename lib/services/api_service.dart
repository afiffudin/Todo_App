import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  // Fetch Todos
  Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((todo) => Todo.fromJson(todo)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  // Add Todo
  Future<void> addTodo(String title) async {
    await http.post(Uri.parse(baseUrl),
        body: json.encode({'title': title, 'completed': false}),
        headers: {'Content-Type': 'application/json'});
  }

  // Edit Todo
  Future<void> updateTodo(int id, String title) async {
    await http.put(Uri.parse('$baseUrl/$id'),
        body: json.encode({'title': title}),
        headers: {'Content-Type': 'application/json'});
  }

  // Delete Todo
  Future<void> deleteTodo(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}
