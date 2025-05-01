import 'package:flutter/material.dart';
//import 'package:locked/styles/themes.dart';
import 'package:locked/styles/colors.dart';
import 'package:locked/fonts/font.dart';
import 'front_page.dart';
import 'task_page.dart';
import 'ending_page.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures that the Flutter framework is initialised - important when running background tasks
  await AndroidAlarmManager.initialize(); // Initializes the Android Alarm Manager
  scheduleToHomeAlarm();
  runApp(const MyApp());
}

void scheduleToHomeAlarm() async {
  DateTime now = DateTime.now();
  
  DateTime resetDay = now.add(Duration(days: (8 - now.weekday) % 7)); // Calculate the next Monday
  DateTime resetDayTime = DateTime(resetDay.year, resetDay.month, resetDay.day, 6, 0); // Calculate the time to be 6AM

  //Schedule the alarm
  await AndroidAlarmManager.oneShotAt(
    resetDayTime, // Time to trigger the alarm
    0, //Unique alarm ID
    navigateToHome,
    exact: true,
    wakeup: true,
  );
}

void navigateToHome() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('navigateToHome', true); // Set flag 
  print("Alarm triggered: navigateToHome flag set.");
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

      builder: (context, child) { 
        return FutureBuilder(
          future: _checkNavigationFlag(context), 
          builder: (context, snapshot) {
            return child!;
          },
        );
      }
    );
  }
  Future<void> _checkNavigationFlag(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final shouldNavigateToHome = prefs.getBool('navigateToHome') ?? false;

    if (shouldNavigateToHome) {
      prefs.setBool('navigateToHome', false); 
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    }
  } 
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Mycolors.successColor,
      scaffoldBackgroundColor: Mycolors.background2Color,
      fontFamily: 'DM Sans',
      textTheme: const TextTheme(
        titleLarge: AppTextStyles.heading,
        bodyMedium: AppTextStyles.body,
      ),
    );
  }
}
