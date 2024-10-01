import 'package:flutter/material.dart';
import 'package:project_name/RTLText.dart';
import 'themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.lightTheme,
      home: const LoginRegister(),
    );
  }
}

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginRegister> {


  // var to hide the password Text
  bool _obscureText = true;
  
  // var to check if the Pass TF is empty
  final _passwordController = TextEditingController();
  
  // focus on Passwrod TF when it is empty
  var _focusNode = FocusNode(); 

  @override
  Widget build(BuildContext context) {
    return RTLPage( // class RTL for Arabic text
      child:Scaffold(       
        
        appBar: AppBar(
          toolbarHeight: 80.0, // Height of AppBar
          actions: [
            Padding( 
              padding: const EdgeInsets.only(left: 10.0), 
              child: MaterialButton(   // Arabic Button
                onPressed: (){},
                child: Text("العربية"),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 0.5), // Black thin border
                  borderRadius: BorderRadius.circular(30)
                ),
              ),
            ),  
          ]
        ),

        body: Padding(                        // to have 15px space from all sides of the body
          padding: const EdgeInsets.all(15.0), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start, // start the widget from RTL
            children: [
              Text("تسجيل أو دخول", style: TextStyle(fontSize: 30.0, fontWeight:FontWeight.w900),),
              Text("دير النية و كتب نمرتك هنا"),
              // Phone Text
              TextField( 
                decoration: InputDecoration(
                  hintText: "رقم الهاتف",
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText:"رقم الهاتف",
                  labelStyle: TextStyle(color: Colors.black),
                  contentPadding: EdgeInsets.only(left: 30.0), // move Textlabel 30px from R to L
                  prefixIcon: Icon(Icons.phone_android_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(40))
                ),
              ),
              // Password Text
              TextField(
                controller: _passwordController, // get the content of the text
                focusNode: _focusNode,           // focus on Passwrod TF when it is empty
                obscureText: _obscureText,       // hide the password Text
                onChanged: (text) {},// ?
                decoration: InputDecoration(
                  hintText: "كلمة المرور",
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText:"كلمة المرور",
                  labelStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  contentPadding: EdgeInsets.only(left: 30.0), // move Textlabel 30px from R to L
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){}, icon: Image.asset("assets/images/question.png")),
                  Text("نسيت كلمة المرور"),
                ],
              ),
              SizedBox(height: 100.0,),
              MaterialButton(onPressed: (){},
                child: Text("تسجيل"),
                color: const Color.fromARGB(1, 234, 234, 241),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                minWidth: 360.0,
                height: 60.0,
              ),
              MaterialButton(onPressed: (){},
                child: Text("دخول"),
                color: AppThemes.lightTheme.primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                minWidth: 360.0,
                height: 60.0,
              ),
            ],
          ),
        )
      )
    );
  }
}    
