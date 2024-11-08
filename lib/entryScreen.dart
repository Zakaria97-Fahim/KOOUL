import 'package:flutter/material.dart';
import 'package:project_name/language/RTLText.dart';
import 'package:project_name/widgets/customButton.dart';

class EntryScreen extends StatefulWidget {
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  Widget build(BuildContext context) {
    return RTLPage(   
      child: Scaffold(
        body: Center(
         child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/images/Haha.png', width: 128, height: 128,),
            SizedBox(height: 20),
            Text('تسجل و تكونيكطا', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Color.fromRGBO(51, 51, 77, 1))),
            SizedBox(height: 20),
            Text('دير النيا و كتب نمرتك هنا', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromRGBO(51, 51, 77, 1))),
            SizedBox(height: 180),
            // Buy Button
            CustomButton(
              backColor: Color.fromRGBO(255, 66, 66, 1),
              textColor: Color.fromRGBO(255, 255, 255, 1),
              label: 'دخول', 
              onPressed: () {Navigator.of(context).pushNamed("address");},
            ),
            SizedBox(height: 30),
          ],
        ),
      )
      ) 
    );
  }
}    