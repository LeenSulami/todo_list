import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/model/todo.dart';

import '../providers/todos.dart';

class UpdateTaskDialog extends StatefulWidget {
  const UpdateTaskDialog({Key? key, required this.todoItem}) : super(key: key);

  final Todo todoItem;

  @override
  State<UpdateTaskDialog> createState() => _UpdateTaskDialogState();
}

class _UpdateTaskDialogState extends State<UpdateTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _description = "";

  @override
  void initState() {
    super.initState();
    _title = widget.todoItem.title!;
    _description = widget.todoItem.description!;
  }

  Future<void> _updateTask() async {
    var todoItems = Provider.of<Todos>(context, listen: false);
    var todo = widget.todoItem;
    todo.title = _title;
    todo.description = _description;
    todoItems.updateTodo(todo);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding:
          const EdgeInsets.only(top: 10, right: 15, bottom: 10, left: 15),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      contentPadding: const EdgeInsets.all(20.0),
      content: const Text(
        'Update your Task',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Color.fromARGB(91, 124, 0, 207),
              blurRadius: 2,
            ),
            Shadow(
              color: Colors.black,
              blurRadius: 1,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: 300,
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 50,
                    initialValue: _title,
                    decoration: InputDecoration(
                      label: const Text("Task Name: "),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onSaved: (value) {
                      _title = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Task name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLength: 120,
                    initialValue: _description,
                    decoration: InputDecoration(
                      label: const Text("Description: "),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onSaved: (value) {
                      _description = value!;
                    },
                  ),
                ],
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _updateTask();
                }
              },
            ),
          ],
        )
      ],
    );
  }
}
