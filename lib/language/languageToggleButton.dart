import 'package:flutter/material.dart';

class LanguageToggleButton extends StatelessWidget {
  final String currentLanguage; // Tracks the current language
  final VoidCallback onToggle;  // Callback when the button is toggled

  const LanguageToggleButton({
    Key? key,
    required this.currentLanguage, // 'EN' or 'AR'
    required this.onToggle,        // Function to switch languages
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onToggle, // Trigger the toggle function when pressed
      child: Text(currentLanguage), // Text of the button
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40), // Raduis 40
        side: BorderSide(color: Colors.grey), // Border Color
      ),
    
    );
  }
}
