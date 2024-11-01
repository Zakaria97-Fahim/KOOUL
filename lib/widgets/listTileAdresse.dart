import 'package:flutter/material.dart';

class ListTileAdresse extends StatelessWidget {
  final double heightLt;

  final String title;        
  final Color titleColor; 
  final double sizeTitle;         
  final FontWeight fontWeight;

  final String subtitle;     
  final double sizeSubtitle;         
  final Color subtitleColor; 

  final TextAlign textAlign; 
  final TextDirection direction ;

  final Widget iconButtonContainer;

  final VoidCallback ontap; 

  // Constructor: Takes title, subtitle, and textAlign as parameters
  const ListTileAdresse({
    Key? key,
    this.heightLt = 60,
    // Title
    required this.title,
    this.sizeTitle = 30,
    this.titleColor = Colors.black,
    this.fontWeight = FontWeight.normal,
    // Subtitle
    required this.subtitle,
    this.sizeSubtitle = 16,
    this.subtitleColor = Colors.black,
    // Texts Alignment 
    this.textAlign = TextAlign.center, // Default to center alignment
    this.direction = TextDirection.rtl, // Default direction RTL
    // Leading : IconButtonContainer 
    required this.iconButtonContainer,
    // On Tap
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: direction,
      child: ListTile(
        // Title
        title: Text(title,
          style: TextStyle(fontSize: sizeTitle, color: titleColor, fontWeight: fontWeight),
          textAlign: textAlign,
          ),
        // SubTitle  
        subtitle: Text(subtitle,
          style: TextStyle(fontSize: sizeSubtitle, color: subtitleColor),
          textAlign: textAlign,
        ),
        // Leading Icon
        leading: iconButtonContainer,
        onTap: ontap,  
      )
    );
  }
}
