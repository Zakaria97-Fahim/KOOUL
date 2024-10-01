import 'package:flutter/material.dart';
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
      home: WelcomeScreen(), 
       // Your Intro page goes here
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen>{ 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppThemes.lightTheme.primaryColor,
      body: Stack(
        children: [  
        Image.asset("assets/images/BackgroundAnimation.png"), //Background Image
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Icons
                Column(
                  children: [
                    IconButton(
                      icon:Image.asset('assets/images/Logomark1.png'),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon:Image.asset('assets/images/hotdog1.png'),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon:Image.asset('assets/images/burger-lettuce1.png'),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon:Image.asset('assets/images/ice-cream1.png'),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon:Image.asset('assets/images/salad1.png'),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon:Image.asset('assets/images/pizza-slice1.png'),
                      onPressed: () {},
                    ),
                  ],
                ),
                RotatedBox(
                    quarterTurns: -1,
                    child: Text('KoouL.', 
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 85.0, 
                        color: AppThemes.lightTheme.colorScheme.surface),
                    ),
                ),
              ],
            ),
            SizedBox(height: 100),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  child: Text("دخول برقم الهاتف"),
                  onPressed:(){
                    Navigator.of(context).pushNamed("login");
                  }, 
                  color: Color.fromARGB(1,51,51,77),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                  minWidth: 360.0,
                  height: 60.0,
                ),
                SizedBox(height: 10,),
                MaterialButton(
                  child: Text("Google دخول بحساب"),   
                  onPressed:(){},
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                  minWidth: 360.0,
                  height: 60.0,
                )
              ],
            )
          ],
        ),
      ])        
    );
  }
}
