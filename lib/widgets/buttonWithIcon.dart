import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final VoidCallback onpressed; 
  final IconData? iconData; // IconData for vector icons
  final Color iconColor;
  final String text; // Add an Button Text 
  final Color textColor;
  final Color btnColor; // background Color
  final double paddingH;
  final double paddingV;
  final Color bordercolor;

  const ButtonWithIcon({
    Key? key,
    required this.onpressed,
    this.iconData,  
    this.iconColor = Colors.black,
    this.text = '', 
    this.textColor = Colors.black,
    this.btnColor = Colors.white,
    this.paddingH = 24,
    this.paddingV = 14,
    this.bordercolor = const Color.fromRGBO(203, 203, 220, 1)
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(

        icon: Icon(iconData, color: iconColor,), // The rotate icon 
      
        label: Text(text, style: TextStyle(color: textColor),), // The text next to the icon
      
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV), 
          backgroundColor: btnColor,
          side: BorderSide(color: bordercolor),
        ),
        onPressed: onpressed,
    );
  }
}