import 'package:flutter/material.dart';
import 'package:project_name/RTLText.dart';  // Importing custom RTL text handling class
import 'themes/theme.dart';  // Importing the app's theme

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginRegister> {

  // Variable to toggle password visibility
  bool _obscureText = true;
  
  // Not yet used
  // Text editing controller to capture the input in the password field
  // final _passwordController = TextEditingController();
  
  // Not yet used
  // Focus node to manage focus on the password field
  // var _focusNode = FocusNode(); 

  @override
  Widget build(BuildContext context) {
    return RTLPage(  // Custom class RTLPage ensures right-to-left (RTL) layout for Arabic text
      
      child: Scaffold(       
        /* AppBar section: 
            - created to avoid using arrow Back Icon.
            - Arrow Back Icon will created Automatically because of Navigator.of().psuNamed()   
        */
        appBar: AppBar(
          toolbarHeight: 80.0,  // Sets the height of the AppBar
          actions: [
            Padding( 
              padding: const EdgeInsets.only(left: 10.0), // Adding padding to the left of the button
              child: MaterialButton(                      // Button to switch the language to Arabic
                onPressed: (){},                          // Empty onPressed handler for now
                child: Text("العربية"),                  // Button text in Arabic
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 0.5),
                  borderRadius: BorderRadius.circular(30)  
                ),
              ),
            ),  
          ]
        ),

        // Body section
        body: Padding( 
          padding: const EdgeInsets.all(15.0),  // Padding to ensure 15px of space around all sides of the content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,  // Distributes space evenly between widgets and the borders
            crossAxisAlignment: CrossAxisAlignment.start,  // Aligns all widgets to start from the right in RTL layout
            children: [
              // Header text
              Text("تسجيل أو دخول", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900)),  // Bold Arabic text
              Text("دير النية و كتب نمرتك هنا"),  // Instructional text in Arabic

              // Phone number input field
              TextField( 
                decoration: InputDecoration(
                  hintText: "رقم الهاتف",  
                  hintStyle: TextStyle(color: Colors.grey),  
                  labelText: "رقم الهاتف",  
                  labelStyle: TextStyle(color: Colors.black),
                  contentPadding: EdgeInsets.only(left: 30.0),  // Adds padding to the left to shift the labelText
                  prefixIcon: Icon(Icons.phone_android_outlined),  
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(40))  // Rounded borders with a radius of 40
                ),
              ),

              // Password input field
              TextField(
                // controller: _passwordController,  // Controller to capture the password input
                // focusNode: _focusNode,  // Focus node to manage focus
                obscureText: _obscureText,  // Toggles password visibility
                decoration: InputDecoration(
                  hintText: "كلمة المرور",  
                  hintStyle: TextStyle(color: Colors.grey), 
                  labelText: "كلمة المرور",  
                  labelStyle: TextStyle(color: Colors.black),  
                  contentPadding: EdgeInsets.only(left: 30.0),  // Adds padding to the left of the labelText
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.black),  
                  suffixIcon: IconButton(  
                    // Eye icon to toggle password visibility
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,  // Shows visibility icon based on _obscureText
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;  // Toggles the password visibility
                      });
                    },
                  ),
                ),
              ),

              // Forgot password row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,  // Centers the icon and text in the row
                children: [
                  IconButton(
                    onPressed: (){},  // Placeholder for the forgot password action
                    icon: Image.asset("assets/images/question.png")  // Icon image for the forgot password button
                  ),
                  Text("نسيت كلمة المرور"),  // Text in Arabic meaning "Forgot Password"
                ],
              ),

              // Spacer to add 100px vertical space
              SizedBox(height: 100.0),

              // Register button
              MaterialButton(
                onPressed: (){},  
                child: Text("تسجيل"),  
                color: const Color.fromARGB(1, 234, 234, 241),  // Button background color
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),  // Rounded button with 40px radius
                minWidth: 360.0,  // Minimum width of the button
                height: 60.0,  // Height of the button
              ),

              // Login button
              MaterialButton(
                onPressed: (){}, 
                child: Text("دخول"),  
                color: AppThemes.lightTheme.primaryColor,  // Button background color from the app theme
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),  
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
