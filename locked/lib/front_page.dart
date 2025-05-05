import 'package:flutter/material.dart';
import 'package:locked/data/tasks.dart';
import 'package:locked/styles/colors.dart';
import 'package:locked/fonts/font.dart';
import 'package:locked/bluetooth.dart';

class FrontPage extends StatefulWidget {
  final String title;
  final BluetoothConnection bluetoothConnection;
  final int themeIndex; // Add themeIndex parameter

  const FrontPage({
    super.key,
    required this.title,
    required this.bluetoothConnection,
    required this.themeIndex,
  });

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70.0, left: 32.0, right: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/images/first_icon.png',
                  width: 325,
                  height: 325,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                Text(
                  taskCollections[widget.themeIndex].theme, // Display theme
                  style: AppTextStyles.heading,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 600,
                      child: const Divider(
                        color: Color(0xFFA5D6A7),
                        thickness: 3,
                        height: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Her kan du skrive en introduktion til ugens tema.',
                  style: AppTextStyles.body,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0, right: 100.0),
              child: ElevatedButton(
                onPressed: () async {
                  await widget.bluetoothConnection.sendCommand("1");
                  Navigator.pushNamed(
                    context,
                    '/tasks',
                    arguments: {
                      'themeIndex': widget.themeIndex,
                    }, // Pass themeIndex
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Mycolors.buttonColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shadowColor: Colors.black.withOpacity(1),
                  elevation: 10,
                ),
                child: Text('Start', style: AppTextStyles.button),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
