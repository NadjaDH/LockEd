import 'package:flutter/material.dart';
import 'package:locked/bluetooth.dart'; // Import the BluetoothConnection class
import 'package:locked/styles/colors.dart';
import 'package:locked/fonts/font.dart';
import 'front_page.dart';
import 'task_page.dart';
import 'ending_page.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterBluePlus.turnOn(); // Ensure Bluetooth is turned on

  final BluetoothConnection bluetoothConnection =
      BluetoothConnection(); // Initialize BluetoothConnection
  await bluetoothConnection.initializeBluetooth(); // Start scanning for devices

  runApp(MyApp(bluetoothConnection: bluetoothConnection));
}

class MyApp extends StatelessWidget {
  final BluetoothConnection bluetoothConnection;

  const MyApp({super.key, required this.bluetoothConnection});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LockEd',
      theme: AppTheme.lightTheme,
      initialRoute: '/home',
      routes: {
        '/home':
            (context) => FrontPage(
              title: 'LockEd',
              bluetoothConnection: bluetoothConnection,
            ),
        '/tasks': (context) => TaskPage(title: 'Taskpage of LockEd'),
        '/ending': (context) => const EndingPage(title: 'Endingpage of LockEd'),
      },
    );
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
