import 'package:flutter/material.dart';
//import 'package:locked/styles/themes.dart';
import 'package:locked/styles/colors.dart';
import 'package:locked/fonts/font.dart';
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
      theme: AppTheme.lightTheme,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const FrontPage(title: 'LockEd'),
        '/tasks': (context) => const TaskPage(title: 'Taskpage of LockEd'),
        '/ending': (context) => const EndingPage(title: 'Endingpage of LockEd'),
      },
    );
  }
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Mycolors.successColor,
      scaffoldBackgroundColor: Mycolors.backgroundColor,
      fontFamily: 'DM Sans',
      textTheme: const TextTheme(
        titleLarge: AppTextStyles.heading,
        bodyMedium: AppTextStyles.body,
      ),
    );
  }
}
