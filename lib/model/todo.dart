import 'dart:math';

import 'package:flutter/foundation.dart';

class Todo {
  String? id;
  String? title;
  String? description;
  bool? isDone;

// This constructor creates a new todo item.
  //
  // The `id` parameter is the ID of the todo. If it is not provided,
  // a random ID will be generated.
  //
  // The `title` parameter is the title of the todo.
  //
  // The `description` parameter is the description of the todo.
  //
  // The `isDone` parameter is whether or not the todo is done.
  Todo({
    String? id,
    required this.title,
    required this.description,
    bool? this.isDone,
  }) : id = id ?? generateId();

  static String generateId() {
    // Generate a random 4-digit string
    final randomNumber = Random().nextInt(10000);
    final paddedNumber = randomNumber.toString().padLeft(4, '0');
    return paddedNumber;
  }
}
