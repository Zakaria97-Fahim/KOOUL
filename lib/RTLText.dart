import 'package:flutter/material.dart';

class RTLPage extends StatelessWidget {
  final Widget child;

  // Constructor to accept a child widget that represents the Arabic page content
  const RTLPage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set RTL direction
      child: child, // The page content passed in
    );
  }
}
