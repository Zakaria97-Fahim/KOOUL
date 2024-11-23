import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final String? imagePath; // Add an imagePath for the asset images
  final IconData? iconData; // Optional IconData for vector icons
  final double size;
  final double sizeW;
  final double sizeH;
  final Color color;

  const IconWidget({
    super.key,
    this.imagePath, // Optional image path
    this.iconData,  // Optional IconData
    this.size = 16.0,
    this.sizeW = 16.0,
    this.sizeH = 16.0,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return imagePath != null
    // If imagePath is provided, display the image
      ? Image.asset(  imagePath!,width: sizeW, height: sizeH)
    // Otherwise, display the IconData  
      : Icon(iconData, size: size, color: color);
  }
}
