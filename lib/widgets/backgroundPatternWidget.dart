
import 'package:flutter/material.dart';

class BackgroundPatternWidget extends StatelessWidget {
  final String patternType;           // Determines the type of background pattern (e.g., food-themed)
  final double opacity;               // Opacity of the pattern
  final Color backgroundColor;        // Background color of the widget

  const BackgroundPatternWidget({
    Key? key,
    required this.patternType,             // Required to set the pattern
    this.opacity = 0.5,                    // Default opacity if not provided
    this.backgroundColor = Colors.white, // Default background color if not provided
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,              // Apply background color
      ),
      child: Opacity(
        opacity: opacity,                    // Apply opacity to the background pattern
        child: Image.asset(
          'assets/images/$patternType',  // Load the background pattern from assets
          fit: BoxFit.cover,                 // Cover the entire container
          width: double.infinity,            // Ensure it spans the entire width
          height: double.infinity,           // Ensure it spans the entire height
        ),
      ),
    );
  }
}
