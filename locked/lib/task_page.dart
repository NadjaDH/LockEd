import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.title});

  final String title;

  @override
  State<TaskPage> createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Hello World!')));
  }
}