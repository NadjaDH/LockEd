import 'package:flutter/material.dart';

class EndingPage extends StatefulWidget {
  const EndingPage({super.key, required this.title});

  final String title;

  @override
  State<EndingPage> createState() => EndingPageState();
}

class EndingPageState extends State<EndingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Hello World!')));
  }
}
