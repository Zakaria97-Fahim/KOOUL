import 'package:flutter/material.dart';
import 'welcomeScreen.dart';
import 'themes/theme.dart';
import 'LoginRegisterScreen.dart';
import 'RTLText.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.lightTheme,
      home: const Loading(),
      routes: {
        "intro": (context) => const WelcomeScreen(),
        "login": (context) => const LoginRegister(),
      },
    );
  }
}

class Loading extends StatefulWidget {
  const Loading({super.key});
  @override
  _LoadingState createState() => _LoadingState();
}
class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    // Set the timer to navigate to the Intro page after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, _createRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return RTLPage(child:Scaffold(
      backgroundColor: AppThemes.lightTheme.primaryColor,
      body: Center(
        child: Image.asset('assets/images/Logomark.png', fit: BoxFit.fill),
      ),
    ));
  }

  // Custom route to handle bottom-to-top slide animation
  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 1500), // Adjust the duration here
      pageBuilder: (context, animation, secondaryAnimation) => const WelcomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // Start from bottom
        const end = Offset(0.0, 0.0);   // End at top
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
