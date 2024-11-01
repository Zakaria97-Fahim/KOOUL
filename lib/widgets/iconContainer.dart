import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  
  final double width;
  final double height;          
  final Color backgroundColor;  
  final Color borderColor;       
  final double borderThin;      

  final Widget iconButtonWidget;

  // Constructor: Container, IconButton
  const IconContainer({
    Key? key,
    // Container
    this.width = 48,
    this.height= 48,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.grey,
    this.borderThin = 1.0,
    // IconButton
    required this.iconButtonWidget,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Circle width
      height: height, // Circle height
      decoration: BoxDecoration(
        color: backgroundColor, // background color
        shape: BoxShape.circle, // Makes the container circular
        border: Border.all(color: borderColor, width: borderThin), // Thin grey border
      ),
      child: iconButtonWidget,
    );
  }
}
