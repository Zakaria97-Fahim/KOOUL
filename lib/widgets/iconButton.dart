import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final Widget iconWidget;
  final VoidCallback onpressed;

  // Constructor: Takes title, subtitle, and textAlign as parameters
  const IconButtonWidget({
    Key? key,
    required this.iconWidget,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(     
      icon: iconWidget,
      onPressed: onpressed,
    );
  }
}
