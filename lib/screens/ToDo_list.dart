import 'package:flutter/material.dart';
import 'package:todo_list/Widgets/add_item.dart';

import '../Widgets/todo_item.dart';

// This class represents the ToDoList screen.
class ToDoList extends StatefulWidget {
// The constant `routeName` is the route name for the ToDoList screen.
  static const routeName = '/ToDoList';
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo List"),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Create a new task"),
        icon: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (ctx) => const newItemDialog(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)));
        },
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30, bottom: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text(
              "Get things done 🚀",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(206, 0, 0, 0)),
            ),
          ),
          TodoItem(),
        ],
      ),
    );
  }
}
