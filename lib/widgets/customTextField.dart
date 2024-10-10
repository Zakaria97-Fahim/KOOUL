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
      controller: text,          // to Get the Content of TextField
      decoration: InputDecoration(

        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),  // grey Color
        labelStyle: TextStyle(color: Colors.black), // black Color

        prefixIcon: icon != null ? Icon(icon,color: Colors.grey) : null,  // Display icon if provided
        suffixIcon: suffixIcon != null ? suffixIcon : null,  // Display icon if provided

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),  // Rounded corners for the field
          borderSide: BorderSide(color: Colors.black), // Border color when focused
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),  // Rounded corners for the field
          borderSide: BorderSide(color: Colors.grey), // Border color when enabled
        ),
       
      ),

      
    );
  }
}
