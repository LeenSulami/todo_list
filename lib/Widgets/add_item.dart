import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todos.dart';

// This class represents the newItemDialog dialog.
class newItemDialog extends StatefulWidget {
  const newItemDialog({super.key});

  @override
  State<newItemDialog> createState() => _newItemDialogState();
}

class _newItemDialogState extends State<newItemDialog> {
// The `_formKey` variable is a GlobalKey<FormState> that is used to validate the form fields in the dialog.
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _description = "";

  // The `_InsertTask()` method inserts a new todo item into the database.
  Future<void> _InsertTask() async {
    var todoItems = Provider.of<Todos>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      todoItems.addTodo(_title, _description);
      print(_title);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          const Text(
            'Create a new task',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            thickness: 2,
            color: Colors.purple,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 50,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: const Text('cancel'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              TextButton(
                child: const Text('Insert'),
                onPressed: () {
                  _InsertTask();
                },
              ),
            ],
          )
        ],
      ),
    );
    ;
  }
}
