import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:todo_list/model/todo.dart';
import 'package:http/http.dart' as http;

class Todos with ChangeNotifier {
  List<Todo> _items = [];

// This method fetches all of the todos from the Firebase database.
  void fetchTodos() async {
    final url =
        Uri.parse('https://todo-b246d-default-rtdb.firebaseio.com/todos.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Todo> loadedTodos = [];
      extractedData.forEach((todoId, todoDate) {
        loadedTodos.add(Todo(
          id: todoId,
          title: todoDate['title'],
          description: todoDate['description'],
          isDone: todoDate['isDone'],
        ));
      });

      _items = loadedTodos;
      notifyListeners();
    } catch (error) {
      print("error ......!!!!!");
      print(error);
      throw (error);
    }
  }

  List<Todo> get items => [..._items];

// This method adds a new todo to the Firebase database.
// The `title` parameter is the title of the todo.
// The `description` parameter is the description of the tod
  Future<void> addTodo(String title, String description) async {
    var id = Random().nextInt(10000).toString();

    final url =
        Uri.parse('https://todo-b246d-default-rtdb.firebaseio.com/todos.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': title,
          'description': description,
          'isDone': false,
        }),
      );
      // var todo = Todo(title: title, description: description);
      // _items.add(todo);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Todo findById(String id) {
    return _items.firstWhere((task) => task.id == id);
  }

// This method deletes a todo from the Firebase database.
//
// The `todo` parameter is the todo that you want to delete.
  void deleteTodo(Todo todo) async {
    final url = Uri.parse(
        'https://todo-b246d-default-rtdb.firebaseio.com/todos/${todo.id}.json');
    try {
      await http.delete(url);
      _items.remove(todo);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

// This method updates a todo in the Firebase database.
//
// The `todo` parameter is the todo that you want to update.
  Future<void> updateTodo(Todo todo) async {
    final url = Uri.parse(
        'https://todo-b246d-default-rtdb.firebaseio.com/todos/${todo.id}.json');
    final response = await http.patch(url,
        body: json.encode({
          'title': todo.title,
          'description': todo.description,
          'isDone': todo.isDone,
        }));

    if (response.statusCode == 200) {
      print('Todo updated successfully');
    } else {
      print('Error updating todo');
    }

    notifyListeners();
  }
}
