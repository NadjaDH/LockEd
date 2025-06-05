import 'package:flutter/material.dart';
import 'package:locked/styles/colors.dart';
import 'package:locked/fonts/font.dart';
import 'package:locked/bluetooth.dart';

/// A page shown at the end of a task to congratulate the user and guide them back to the home screen
class EndingPage extends StatefulWidget {
  final String title;
  final BluetoothConnection bluetoothConnection;
  final int themeIndex;

  const EndingPage({
    super.key,
    required this.title,
    required this.bluetoothConnection,
    required this.themeIndex,
  });

  @override
  State<EndingPage> createState() => EndingPageState();
}

class EndingPageState extends State<EndingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            // Centered Image
            Image.asset(
              'lib/images/second_icon.png',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 24,
            ),
            // Heading Text
            Text(
              'Godt gået!',
              style: AppTextStyles.heading,
            ),
            const SizedBox(
              height: 16,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 700,
              ),
              child: const Divider(
                color: Mycolors.dividerColor,
                thickness: 3,
                height: 30,
              ),
            ),
            // Body Text
            Text(
              'Du har gennemført opgaven. Flot arbejde!',
              style: AppTextStyles.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 32, // Add more space between the body text and the button
            ),
            const SizedBox(
              height: 32, // Add more space between the divider and the button
            ),
            
            // Button to go back to the home screen
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/home',
                  arguments: {
                    'themeIndex': widget.themeIndex + 1,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:Mycolors.buttonColor, 
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold, 
                  fontFamily: 'DM Sans',
                ),
              ),
              child: const Text('Tilbage til forsiden'),
            ),
          ],
        ),
      ),
    );
  }
}
