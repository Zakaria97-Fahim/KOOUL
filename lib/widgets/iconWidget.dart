import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final String? imagePath; // Add an imagePath for the asset images
  final double size;
  final Color color;
  final IconData? iconData; // Optional IconData for vector icons

  const IconWidget({
    Key? key,
    this.imagePath, // Optional image path
    this.iconData,  // Optional IconData
    this.size = 30.0,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imagePath != null
        ? Image.asset(  // If imagePath is provided, display the image
            imagePath!,
            width: size,
            height: size,
          )
        : Icon( // Otherwise, display the IconData
            iconData,
            size: size,
            color: color,
          );
  }
}
