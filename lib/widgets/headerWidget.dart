import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;        // Title text
  final String subtitle;     // Subtitle text
  final TextAlign textAlign; // Text alignment
  final double sizeTitle;         // font size
  final double sizeSubtitle;         // font size
  final Color titleColor;    // Color 
  final Color subtitleColor; // Color 
  final TextDirection direction ; // Text direction RTL

  // Constructor: Takes title, subtitle, and textAlign as parameters
  const HeaderWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    this.textAlign = TextAlign.center, // Default to center alignment
    this.sizeTitle = 30,
    this.sizeSubtitle = 16,
    this.titleColor = Colors.black,
    this.subtitleColor = Colors.black,
    this.direction = TextDirection.rtl // Default direction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: direction,
      child: Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start, // Align based on the textAlign parameter
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: sizeTitle, // Customize font size for the title
            fontWeight: FontWeight.bold,
            color: titleColor, // Customize color for title text
          ),
          textAlign: textAlign,
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: sizeSubtitle, // Customize font size for the subtitle
            color: subtitleColor, // Customize color for subtitle text
          ),
          textAlign: textAlign,
        ),
      ],
      ),
    );
    
    
  }
}
