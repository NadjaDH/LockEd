import 'package:flutter/material.dart';
import 'package:locked/styles/colors.dart';
import 'package:locked/fonts/font.dart'; // Import your font styles

class FrontPage extends StatefulWidget {
  const FrontPage({super.key, required this.title});

  final String title;

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
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center content vertically
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // LEFT SIDE: Title and Body Text
                    Expanded(
                      flex: 2, // Allocate more space for the text
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                            ), // Adjust left padding
                            child: Text(
                              'Ugens Tema',
                              style:
                                  AppTextStyles
                                      .heading, // Use custom font for heading
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                            ), // Adjust left padding
                            child: Text(
                              'Her kan du skrive en introduktion til ugens tema.',
                              style:
                                  AppTextStyles
                                      .body, // Use custom font for body text
                            ),
                          ),
                        ],
                      ),
                    ),
                    // RIGHT SIDE: Image
                    Flexible(
                      flex: 1, // Allocate space for the image
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                        ), // Add spacing between text and image
                        child: Image.asset(
                          'lib/images/first_icon.png', // Path to your image in the styles folder
                          width: 300, // Set the width of the image
                          height: 300, // Set the height of the image
                          fit: BoxFit.contain, // Adjust how the image fits
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 32.0,
                right: 32.0,
              ), // Add space from the edge
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/tasks',
                  ); // Navigate to TaskPage
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Mycolors.buttonColor, // Use color from colors.dart
                  foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: Text(
                  'Start',
                  style:
                      AppTextStyles.button, // Use custom font for button text
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
