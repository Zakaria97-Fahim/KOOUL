import 'package:flutter/material.dart';

/// A custom widget to display text vertically by rotating it.
/// The text, font size, color, and alignment can be customized via parameters.

class VerticalTextWidget extends StatelessWidget {

  final String text;
  
  final double fontSize;
  
  final Color color;
  
  final TextAlign alignment;

  // Constructor to initialize the properties with the passed values or defaults
  const VerticalTextWidget({
    Key? key,
    required this.text,                 // Requires text input when using the widget
    this.fontSize = 20.0,               // Defaults to 20.0 if no fontSize is provided
    this.color = Colors.white,        // Defaults to black if no color is provided
    this.alignment = TextAlign.center,  // Defaults to center alignment if none is provided
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Rotates the text vertically using RotatedBox, by rotating 90 degrees counter-clockwise (-1 quarter turn)
    return RotatedBox(
      quarterTurns: -1, // Rotates the text 90 degrees counterclockwise
      child: Text(
        text,            
        textAlign: alignment, 
        style: TextStyle(
          fontSize: fontSize,  
          color: color,        
          fontFamily: 'Quicksand-Bold', // Optional: sets a custom font for the text
        ),
      ),
    );
  }
}
