import 'package:flutter/material.dart';
import 'package:locked/styles/colors.dart';

class AppTextStyles {
  static const heading = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 255, 255, 255),
  );

  static const body = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 30,
    fontWeight: FontWeight.normal,
    color: Color.fromARGB(255, 255, 255, 255),
  );

  static const button = TextStyle(
    fontSize: 20, // Adjust size for the button text
    fontWeight: FontWeight.bold,
    fontFamily: 'DM Sans', // Replace with your custom font family name
  );
}
