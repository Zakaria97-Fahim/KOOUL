import 'package:flutter/material.dart';
import 'themes/theme.dart';
import 'welcomeScreen.dart';
import 'loginRegisterScreen.dart';
import 'registration.dart';
import 'addressdetails.dart';
import 'addresses.dart';
import 'mapWidget.dart';
import 'home.dart';
import 'storeProducts.dart';

/*
 *-import 'themes/theme.dart'; 
    These settings will apply a consistent look (lightTheme) across the entire app.
 *-import 'RTLText.dart';  
    (Assumed purpose) Importing RTLText for handling right-to-left text formatting, 
 *-import 'welcomeScreen.dart';
    This will be used as a part of the app's navigation (defined in the routes).
 *-import 'LoginRegisterScreen.dart';  
    It will be one of the navigable routes in the app (via the "login" route). 
*/


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.lightTheme, // This line will apply a consistent look (lightTheme)
      home: const LoadingPage(),   // the initial screen that will be displayed when the app starts.
      routes: {
        "intro": (context) => const WelcomeScreen(),
        "login": (context) => const LoginRegister(),
        "registration": (context) => const Registration(),
        "address": (context) => const AddressDetails(),
        "mapPage": (context) => IntegrateMap(),
        "addresses": (context) => Addresses(),
        "home": (context) => Home(),
        "storeProducts": (context) => StoreProducts(),
      },
      /* Routes:
        * provides route management for navigation between screens.
        * Defines available routes in the app. These routes are key-value pairs,
        * where the key is the route name and the value is the corresponding screen.
        * "intro" navigates to the WelcomeScreen, and "login" to the LoginRegister screen. The same for the Others.        
      */
    );
  }
}

// Loading Page
class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  /* initState() :
   * This method is called when the stateful widget is first created. 
   * - A delay of 2 seconds is introduced using Future.delayed.
   * - After the delay, Navigator.pushReplacement() is called to navigate to a new route 
      by replacing the current one.
   * - _createRoute() is a custom function used to define the route transition.
   * - The parent's initState() is called at the end to ensure proper initialization.
  */
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, _createRoute());
    });
    super.initState();
  }
   
  /* - Scaffold is the base structure for the page, with the primaryColor of the app theme as the background color.
   * - The body contains a centered image widget that displays 'Logomark.png' from the assets, 
   *   and BoxFit.fill ensures the image covers the available space in its container.
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.lightTheme.primaryColor,
      body: Center(
        child: Image.asset('assets/images/Logomark.png', fit: BoxFit.fill),
      ),
    );
  }
  
  /* createRoute() :
   * - Defines a custom route transition using PageRouteBuilder.
   * - transitionDuration is set to 1500 milliseconds (1.5 seconds), controlling the duration of the animation.
   * - pageBuilder() returns the target page, in this case, WelcomeScreen(), and it builds the screen during the transition.
   * - transitionsBuilder() handles the animation:
   *    - Offset(0.0, 1.0) means the animation starts from the bottom of the screen.
   *    - Offset(0.0, 0.0) means it ends at the top (normal position).
   *    - Curves.easeInOut provides a smooth transition effect.
   *    - Tween() interpolates the movement from start to end using the defined curve.
   *    - SlideTransition animates the child's position based on the offsetAnimation, making the new screen slide in from the bottom.
  */
  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 1500),
      pageBuilder: (context, animation, secondaryAnimation) => const WelcomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // Start from bottom
        const end = Offset.zero;         // End at original position
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }  
}
