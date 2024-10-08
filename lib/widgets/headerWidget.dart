import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;        // Title text
  final String subtitle;     // Subtitle text
  final TextAlign textAlign; // Text alignment

  // Constructor: Takes title, subtitle, and textAlign as parameters
  const HeaderWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    this.textAlign = TextAlign.center, // Default to center alignment
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start, // Align based on the textAlign parameter
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 30, // Customize font size for the title
            fontWeight: FontWeight.bold,
            color: Colors.black, // Customize color for title text
          ),
          textAlign: textAlign,
        ),
        SizedBox(height: 8), // Space between title and subtitle
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 16, // Customize font size for the subtitle
            color: Colors.black, // Customize color for subtitle text
          ),
          textAlign: textAlign,
        ),
      ],
    );
  }
}
