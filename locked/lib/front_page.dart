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
            padding: const EdgeInsets.only(
              top: 70.0,
              left: 32.0,
              right: 32.0,
            ), // Move elements higher
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Align elements to the top
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center content horizontally
              children: [
                // Image above the heading
                Image.asset(
                  'lib/images/first_icon.png', // Path to your image
                  width: 325, // Adjust the width of the image
                  height: 325, // Adjust the height of the image
                  fit: BoxFit.contain, // Adjust how the image fits
                ),
                const SizedBox(
                  height: 20,
                ), // Add spacing between the image and the heading
                // Heading Text
                Text(
                  'Ugens Tema',
                  style: AppTextStyles.heading, // Use custom font for heading
                  textAlign: TextAlign.center, // Center-align the text
                ),
                const SizedBox(
                  height: 10,
                ), // Add spacing between the heading and the divider
                // Divider (shorter, spans only the width of the body text)
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the divider
                  children: [
                    SizedBox(
                      width: 600, // Set the width of the divider
                      child: const Divider(
                        color: Color(
                          0xFFA5D6A7,
                        ), // Use the custom divider color
                        thickness: 3, // Set the thickness of the divider
                        height: 20, // Add spacing above and below the divider
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ), // Add spacing between the divider and the body text
                // Body Text
                Text(
                  'Her kan du skrive en introduktion til ugens tema.',
                  style: AppTextStyles.body, // Use custom font for body text
                  textAlign: TextAlign.center, // Center-align the body text
                ),
              ],
            ),
          ),

          // Start Button at the Bottom Right
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 32.0,
                right: 100.0,
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
                  shadowColor: Colors.black.withOpacity(1), // Shadow color
                  elevation: 10, // Elevation to create the shadow
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
