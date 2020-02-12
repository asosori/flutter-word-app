import 'package:flutter/material.dart';
import './screen/WordCreateScreen.dart';
import './screen/WordListScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'word App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFe7e3f5),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WordCreateScreen(),
        '/list': (context) => WordListScreen(),
        //'/edit': (context) => WordEditScreen()
      },
    );
  }
}