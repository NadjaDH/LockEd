import 'package:flutter/material.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key, required this.title});

  final String title;

  @override
  State<FrontPage> createState() => FrontPageState();
}

class FrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Hello World!')));
  }
}
