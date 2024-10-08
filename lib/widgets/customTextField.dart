import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;  // The label above the text field
  final String hintText;   // The hint text inside the text field
  final IconData? icon;    // An optional icon
  final bool obscureText;  // Whether the text should be obscured (e.g., for passwords)
  final IconButton? suffixIcon; // An optional siffix Icon Button
  final TextEditingController? text; // 

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.icon,
    this.suffixIcon,
    this.obscureText = false,  // Default is false (not obscured)
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,  // Hide text if true
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: icon != null ? Icon(icon) : null,  // Display icon if provided
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),  // Rounded corners for the field
        ),
        // other elements added
        hintStyle: TextStyle(color: Colors.grey),  // grey Color
        labelStyle: TextStyle(color: Colors.black), // black Color
        suffixIcon: suffixIcon != null ? suffixIcon : null,  // Display icon if provided
      ),
      controller: text,
    );
  }
}
