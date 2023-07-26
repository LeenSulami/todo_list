import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Widgets/update_item.dart';
import '../model/todo.dart';
import '../providers/todos.dart';

// This class represents a todo item in the ToDoList app.
class TodoItem extends StatefulWidget {
  const TodoItem({super.key});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    var todo = Provider.of<Todos>(context);
    var todoItems = todo.items;
    todo.fetchTodos();

    @override
    void initState() async {
      super.initState();
    }

    @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      Provider.of<Todos>(context, listen: false).fetchTodos();
    }

    return Column(children: [
      ListView.builder(
        padding: const EdgeInsets.all(30.0),
        shrinkWrap: true,
        itemCount: todoItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ListTile(
              title: Text(todoItems[index].title ?? ""),
              onTap: () {
                setState(() {
                  if (todoItems[index].isDone != null) {
                    todoItems[index].isDone = !todoItems[index].isDone!;
                    Provider.of<Todos>(context, listen: false)
                        .updateTodo(todoItems[index]);
                  }
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              leading: todoItems[index].isDone!
                  ? const Icon(Icons.check_box)
                  : const Icon(Icons.check_box_outline_blank),
              subtitle: Text(todoItems[index].description ?? ""),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => UpdateTaskDialog(
                                todoItem: todoItems[index],
                              ));
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                      onPressed: () {
                        Provider.of<Todos>(context, listen: false)
                            .deleteTodo(todoItems[index]);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ],
              ),
              tileColor: const Color.fromARGB(48, 158, 158, 158),
            ),
          );
        },
      ),
    ]);
  }
}
