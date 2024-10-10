import 'package:flutter/material.dart';
import 'themes/theme.dart';  
import 'language/RTLText.dart';  
import 'language/languageToggleButton.dart';
import 'widgets/customButton.dart';
import 'widgets/iconWidget.dart';
import 'widgets/headerWidget.dart';
import 'widgets/customTextField.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginRegister> {

  // If Arabic the chosen language 
  bool isArabic = true;

  // Hide Password at TextField
  bool _obscureText= true ;
  
  // get the Textfield content
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to validate the phone number
  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }
  // Function to validate the password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Function triggered when Link "Forgot Password" is clicked
  void _onForgotPassword() {
    // You can navigate to a "Forgot Password" page or show a dialog (optional) here
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Forgot Password'),
          content: Text('You will be redirected to reset your password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();  // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function triggered when the login button is pressed
  void _onLogin() {
    // Get the phone number and password without leading/trailing spaces
    var phoneNumber = _phoneController.text.trim();
    var password = _passwordController.text.trim();
    
    // Validate the phone number and password
    var phoneValidationResult = _validatePhoneNumber(phoneNumber);
    var passwordValidationResult = _validatePassword(password);
    
    // Check if both validations passed
    if (phoneValidationResult == null && passwordValidationResult == null) {
      // If all inputs are valid, proceed with login
      print("Login successful");
      // Add additional login logic here (e.g., API call)
    } else {
      // Handle validation errors
      if (phoneValidationResult != null) {
        print(phoneValidationResult); // Print or display the phone validation error
      }
      if (passwordValidationResult != null) {
        print(passwordValidationResult); // Print or display the password validation error
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    /* Custom class RTLPage ensures (RTL or LTR) layout for Arabic or English text
     * RTLPage() is used to support Right-to-Left (RTL) languages, like Arabic.
     * It ensures that the layout are adjusted properly for languages that are written from right to left. This is important for providing a user-friendly experience for Arabic-speaking users or any other users who use RTL languages.
     * When click on button Language, the entire layout will automatically mirror, aligning the UI elements to the right, which is the standard for RTL language interfaces.
    */

    return RTLPage(   
      isArabic: isArabic,        
      child: Scaffold(
        // Padding to ensure 15px of space around all sides of the content      
        body: Padding( 
          padding: const EdgeInsets.all(15.0),  
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,  // Distributes space evenly between widgets and the borders
            crossAxisAlignment: CrossAxisAlignment.start,  // Aligns all widgets to start from the layout border
            children: [
              // Row for Language Switch Button and Icon Back Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   // ComeBack Icon
                  IconButton(
                    onPressed: (){Navigator.pop(context);}, 
                    icon: IconWidget(iconData: Icons.arrow_back_sharp)
                  ),
                  // Language Switch Button
                  LanguageToggleButton(
                    currentLanguage: isArabic ? 'العربية' : 'English', 
                    onToggle: () {
                      setState(() {
                        isArabic = !isArabic ;                    
                      });
                    },
                  ),
                ],
              ),
             
              // Header (Title and Subtitle)
              HeaderWidget(
                title: isArabic ? 'تسجيل أو دخول' :'Register or Login',
                subtitle: isArabic ?'دير النية و كتب نمرتك هنا' :'Have faith and enter your Number here',
                textAlign: TextAlign.start,
              ),

              // Phone number input field
              CustomTextField(
                labelText: isArabic ? 'رقم الهاتف' : 'Phone Number',
                hintText: isArabic ? 'رقم الهاتف' : 'Phone Number',
                icon: Icons.phone_android_outlined,
                text: _phoneController,
              ),

              // Password input field
              CustomTextField(
                labelText: isArabic ? 'كلمة المرور' : 'Password',
                hintText: isArabic ? 'كلمة المرور' : 'Password',
                icon: Icons.lock_outline,
                suffixIcon: IconButton(  
                    icon: Icon(                    // Eye icon to toggle password visibility
                      _obscureText ? Icons.visibility_off : Icons.visibility,  // Shows visibility icon based on _obscureText
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;  // Toggles the password visibility
                      });
                    },
                  ),
                obscureText: _obscureText,
                text: _passwordController,  
              ), 

              // Forgot Password Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,  // Centers the icon and text in the row
                children: [

                  // Icon question mark 
                  IconButton(
                    onPressed: (){},  // Placeholder for the forgot password action
                    icon: Image.asset("assets/images/question.png")  // Icon image for the forgot password button
                  ),
                  // Link for the forgot Password
                  GestureDetector(
                    onTap: () {
                      _onForgotPassword();
                    },
                    child: Text(isArabic ? "نسيت كلمة المرور" : "I Forgot the Password"),
                  )  
                ],
              ),

              // Spacer to add 100px vertical space
              SizedBox(height: 100.0),

              // Register & Login Buttons 
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Register button
                  CustomButton(
                    label: isArabic ? "تسجيل" : "Register", 
                    onPressed: (){
                      Navigator.of(context).pushNamed("registration");
                    }, 
                    backColor: Color.fromARGB(1, 234, 234, 241), 
                  ),
                  SizedBox(height: 10,), // space between the buttons
                  // Login button
                  CustomButton(
                    label: isArabic ? "دخول" : "Login", 
                    onPressed: _onLogin,
                    backColor: AppThemes.lightTheme.primaryColor, // red Color
                    textColor: AppThemes.lightTheme.scaffoldBackgroundColor, // white Color
                  ),  
                ],
              ) 
            ],
          ),
        )
      )
    );
  }
}
