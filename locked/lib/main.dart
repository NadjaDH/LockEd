import 'package:flutter/material.dart';
import 'package:locked/bluetooth.dart'; // Import the BluetoothConnection class
import 'package:locked/styles/colors.dart';
import 'package:locked/fonts/font.dart';
import 'front_page.dart';
import 'task_page.dart';
import 'ending_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterBluePlus.turnOn(); // Ensure Bluetooth is turned on

  await requestPermissions(); // <-- Request permissions before scanning/connecting

  final BluetoothConnection bluetoothConnection =
      BluetoothConnection(); // Initialize BluetoothConnection
  await bluetoothConnection.initializeBluetooth(); // Start scanning for devices

  runApp(MyApp(bluetoothConnection: bluetoothConnection));
}

Future<void> requestPermissions() async {
  await [
    Permission.bluetooth,
    Permission.bluetoothConnect,
    Permission.bluetoothScan,
    Permission.locationWhenInUse,
  ].request();
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
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final args =
              settings.arguments as Map<String, dynamic>? ?? {'themeIndex': 0};
          return MaterialPageRoute(
            builder:
                (context) => FrontPage(
                  title: 'LockEd',
                  bluetoothConnection: bluetoothConnection,
                  themeIndex: args['themeIndex'],
                ),
          );
        } else if (settings.name == '/tasks') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder:
                (context) => TaskPage(
                  title: 'Taskpage of LockEd',
                  bluetoothConnection: bluetoothConnection,
                  themeIndex: args['themeIndex'],
                ),
          );
        } else if (settings.name == '/ending') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder:
                (context) => EndingPage(
                  title: 'Endingpage of LockEd',
                  bluetoothConnection: bluetoothConnection,
                  themeIndex: args['themeIndex'],
                ),
          );
        }
        return null;
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
