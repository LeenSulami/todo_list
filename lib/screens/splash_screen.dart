import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/screens/ToDo_list.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/plashSscreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

// This creates a timer that waits for 3 seconds before executing the
// function passed as the second argument.
// The function navigates to the ToDoList screen using the named route.
// We use the Navigator.pushNamed method to navigate to the screen.
// The context parameter is required to access the navigator.
    Timer(const Duration(seconds: 3),
        () => {Navigator.pushNamed(context, ToDoList.routeName)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("images/splash-logo.png", height: 250),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 16),
              child: const CircularProgressIndicator(
                backgroundColor: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
