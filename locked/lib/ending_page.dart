import 'package:flutter/material.dart';
import 'package:locked/styles/colors.dart'; // Import your custom colors
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
              'lib/images/second_icon.png', // Path to your image
              width: 300, // Adjust the width of the image
              height: 300, // Adjust the height of the image
              fit: BoxFit.contain, // Adjust how the image fits
            ),
            const SizedBox(
              height: 24,
            ), // Add spacing between the image and the heading
            // Heading Text
            Text(
              'Godt gået!',
              style: AppTextStyles.heading, // Use custom font for heading
            ),
            const SizedBox(
              height: 16,
            ), // Add spacing between the heading and body text
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 700,
              ), // Match the width of other elements
              child: const Divider(
                color: Mycolors.dividerColor,
                thickness: 3,
                height: 30,
              ),
            ), // Body Text
            Text(
              'Du har gennemført opgaven. Flot arbejde!',
              style: AppTextStyles.body, // Use custom font for body text
              textAlign: TextAlign.center, // Center-align the text
            ),
            const SizedBox(
              height: 32, // Add more space between the body text and the button
            ),
            const SizedBox(
              height: 32, // Add more space between the divider and the button
            ),
            // Styled Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Mycolors.buttonColor, // Use the custom button color
                foregroundColor: Colors.white, // Text color
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 30,
                ), // Adjust padding for a larger button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                textStyle: const TextStyle(
                  fontSize: 25, // Use the font size from the button font
                  fontWeight: FontWeight.bold, // Use bold text
                  fontFamily: 'DM Sans', // Use the custom font family
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
