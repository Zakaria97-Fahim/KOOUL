
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonStyle? buttonStyle; // Make buttonStyle nullable
  final Color backColor;
  final Color textColor;
  final double width;
  final double height;
  final double raduis;
  // Constructor: Takes label, onPressed, and buttonStyle as parameters
  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.buttonStyle,
    this.backColor = Colors.red,
    this.textColor = const Color.fromARGB(255, 0, 0, 0),
    this.width = 360,
    this.height = 60, 
    this.raduis = 40
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Create a default ButtonStyle using the provided colors
    final ButtonStyle defaultStyle = ElevatedButton.styleFrom(
      backgroundColor: backColor,  // Button background color
      foregroundColor: textColor,   // Text color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(raduis), // Rounded corners
      ),
      fixedSize: Size(width,height),
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle ?? defaultStyle, // Use the provided style or fallback to default style
      child: Text(label),
    );
  }
}
