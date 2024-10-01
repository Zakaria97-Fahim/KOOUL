import 'package:flutter/material.dart';

// Define Macdonaldz Theme colors
class AppThemes {
  static final lightTheme = ThemeData(
    
    fontFamily: 'Quicksand',  // FontFamily is set globally

    brightness: Brightness.light,
    primaryColor: Colors.red,              // Red as primary color
    scaffoldBackgroundColor: Colors.white, // Background for Scaffold

    colorScheme: const ColorScheme.light(
      primary: Colors.red,              // Primary color (Red)
      secondary: Colors.yellow,         // Secondary/Accent color (Yellow)
      surface: Colors.white,            // Surface color (White for light theme)
    ),
    
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.black,           // Black title text (equivalent to headline1)
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.black,           // Black body text normal (equivalent to bodyText1)
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,           // Black body text bold (equivalent to bodyText2)
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(
        color: Colors.black,           // Button text in black (equivalent to button)
        fontSize: 16,
        fontWeight: FontWeight.bold,   // Bold button text
      ),
      bodySmall: TextStyle(
        color: Colors.grey,            // Hint text grey (equivalent to subtitle1)
        fontSize: 14,
      ),
    ),
    
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.red,         // Red background for buttons
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static final darkTheme = ThemeData(
    fontFamily: 'Quicksand',  // FontFamily set for dark theme as well
    
    brightness: Brightness.dark,
    primaryColor: Colors.red,
    scaffoldBackgroundColor: Colors.black, // Background for Scaffold
    
    colorScheme: const ColorScheme.dark(
      primary: Colors.red,              // Primary color in dark mode
      secondary: Colors.yellow,         // Secondary/Accent color in dark mode
      surface: Colors.black,            // Surface color (Black for dark theme)
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.white,           // White title text in dark mode
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,           // White body text normal in dark mode
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,           // White body text bold in dark mode
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(
        color: Colors.white,           // Button text in white
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        color: Colors.grey,            // Grey hint text
        fontSize: 14,
      ),
    ),

    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.red,         // Red button background in dark mode
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
