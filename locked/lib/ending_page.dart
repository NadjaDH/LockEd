import 'package:flutter/material.dart';
import 'package:locked/styles/colors.dart';
import 'package:locked/fonts/font.dart'; // Import your font styles

class EndingPage extends StatefulWidget {
  const EndingPage({super.key, required this.title});

  final String title;

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
              MainAxisAlignment.center, // Center content vertically
          children: [
            // Centered Image
            Image.asset(
              'lib/images/first_icon.png', // Path to your image
              width: 200, // Adjust the width of the image
              height: 200, // Adjust the height of the image
              fit: BoxFit.contain, // Adjust how the image fits
            ),
            const SizedBox(
              height: 24,
            ), // Add spacing between the image and the heading
            // Heading Text
            Text(
              'Godt gået',
              style: AppTextStyles.heading, // Use custom font for heading
            ),
            const SizedBox(
              height: 16,
            ), // Add spacing between the heading and body text
            // Body Text
            Text(
              'Du har gennemført opgaven. Flot arbejde!',
              style: AppTextStyles.body, // Use custom font for body text
              textAlign: TextAlign.center, // Center-align the text
            ),
          ],
        ),
      ),
    );
  }
}
