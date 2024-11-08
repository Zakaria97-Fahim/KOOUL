import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final VoidCallback onpressed; 
  final IconData? iconData; // IconData for vector icons
  final Color iconColor;
  final double iconSize;
  final String text; 
  final double textSize; 
  final Color textColor;
  final Color backgroundColor; // background Color
  final double paddingH;
  final double paddingV;
  final Color bordercolor;
  final TextDirection direction ;

  const ButtonWithIcon({
    Key? key,
    required this.onpressed,
    this.iconData,  
    this.iconColor = Colors.black,
    this.iconSize = 16,
    this.text = '',
    this.textSize = 14,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.paddingH = 24,
    this.paddingV = 14,
    this.bordercolor = const Color.fromRGBO(203, 203, 220, 1),
    this.direction = TextDirection.rtl,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: direction,
      child: ElevatedButton.icon(
        icon: Icon(iconData, color: iconColor, size: iconSize,), // The rotate icon 
      
        label: Text(text, style: TextStyle(color: textColor, fontSize: textSize),), // The text next to the icon
      
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV), 
          backgroundColor: backgroundColor,
          side: BorderSide(color: bordercolor),
        ),
        onPressed: onpressed,
      )
    ); 
  }
}