import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/model/todo.dart';
import 'package:todo_list/providers/todos.dart';
import 'package:todo_list/screens/ToDo_list.dart';
import 'package:todo_list/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Todos(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        // This defines the route table for the app.
        // The route table maps the route names to their corresponding screen widgets.
        // When the app navigates to a particular route, it looks up the corresponding
        // widget in the route table and displays it on the screen.
        routes: {
          // Register the SplashScreen widget to the route table with the route name
          SplashScreen.routeName: (context) => SplashScreen(),
          ToDoList.routeName: (context) => ToDoList(),
        },
        home: const SplashScreen(),
      ),
    );
  }
}
