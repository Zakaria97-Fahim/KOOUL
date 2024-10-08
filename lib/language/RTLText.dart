import 'package:flutter/material.dart';

class RTLPage extends StatelessWidget {
  final Widget child;
  final bool isArabic;
  // Constructor to accept a child widget that represents the Arabic page content
  const RTLPage({
    Key? key, 
    required this.child,
    this.isArabic = true,
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr, // Set RTL direction
      child: child, // The page content passed in
    );
  }
}
