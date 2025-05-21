import 'package:flutter/material.dart';
import 'package:locked/bluetooth.dart';
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
  await requestPermissions(); // Request permissions before scanning/connecting

  final BluetoothConnection bluetoothConnection =
      BluetoothConnection(); // Initialize BluetoothConnection
  await bluetoothConnection.initializeBluetooth(); // Initialize Bluetooth connection

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

///Main app widget
///Handles route generation and passes the Bluetooth connection to all pages.
class MyApp extends StatelessWidget {
  //Shared Bluetooth connection handler used throughout the app.
  final BluetoothConnection bluetoothConnection;

  const MyApp({super.key, required this.bluetoothConnection});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LockEd',
      theme: AppTheme.lightTheme,
      initialRoute: '/home',
      onGenerateRoute: (settings) {
        final args = settings.arguments as Map<String, dynamic>? ?? {'themeIndex': 0};

        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(
              builder: (_) => FrontPage(
                bluetoothConnection: bluetoothConnection,
                themeIndex: args['themeIndex'],
              ),
            );
          case '/tasks':
            return MaterialPageRoute(
              builder: (_) => TaskPage(
                title: 'Taskpage of LockEd',
                bluetoothConnection: bluetoothConnection,
                themeIndex: args['themeIndex'],
              ),
            );
          case '/ending':
            return MaterialPageRoute(
              builder: (_) => EndingPage(
                title: 'Endingpage of LockEd',
                bluetoothConnection: bluetoothConnection,
                themeIndex: args['themeIndex'],
              ),
            );
          default:
            return null;
        }
      },
    );
  }
}

///App-wide theming used across the LockEd UI.
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
