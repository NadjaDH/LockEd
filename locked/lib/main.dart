import 'package:flutter/material.dart';
import 'front_page.dart';
import 'task_page.dart';
import 'ending_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LockEd',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/tasks',
      routes: {
        '/home': (context) => const FrontPage(title: 'Frontpage of LockEd'),
        '/tasks': (context) => const TaskPage(title: 'Taskpage of LockEd'),
        '/ending': (context) => const EndingPage(title: 'Endingpage of LockEd'),
      },
    );
  }
}
