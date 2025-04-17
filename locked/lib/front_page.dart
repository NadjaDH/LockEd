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
                    // LEFT SIDE: Box with Title and Body Text
                    Expanded(
                      flex: 1, // Allocate more space for the text
                      child: Align(
                        alignment:
                            Alignment.centerRight, // Align the box to the right
                        child: Container(
                          padding: const EdgeInsets.all(
                            16.0,
                          ), // Inner padding for the box
                          decoration: BoxDecoration(
                            color:
                                Colors.transparent, // Make the box transparent
                            border: Border.all(
                              color: Colors.black.withOpacity(
                                0.4,
                              ), // Border color with transparency
                              width: 1.0, // Reduced border width
                            ),
                            borderRadius: BorderRadius.circular(
                              12,
                            ), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  0.3,
                                ), // Shadow color
                                blurRadius: 8, // Blur radius for the shadow
                                offset: const Offset(
                                  0,
                                  4,
                                ), // Offset for the shadow
                              ),
                            ],
                          ),
                          constraints: const BoxConstraints(
                            minHeight:
                                300, // Set the minimum height for the box
                          ),
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center, // Center content vertically
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .center, // Center content horizontally
                            children: [
                              Text(
                                'Ugens Tema',
                                style:
                                    AppTextStyles
                                        .heading, // Use custom font for heading
                                textAlign:
                                    TextAlign.center, // Center-align the text
                              ),
                              const SizedBox(
                                height: 40,
                              ), // Add more space between the heading and body text
                              Text(
                                'Her kan du skrive en introduktion til ugens tema.',
                                style:
                                    AppTextStyles
                                        .body, // Use custom font for body text
                                textAlign:
                                    TextAlign
                                        .center, // Center-align the body text
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // RIGHT SIDE: Image
                    Flexible(
                      flex: 1, // Allocate space for the image
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 150.0,
                        ), // Add spacing between text and image
                        child: Image.asset(
                          'lib/images/first_icon.png', // Path to your image in the styles folder
                          width: 450, // Set the width of the image
                          height: 450, // Set the height of the image
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
