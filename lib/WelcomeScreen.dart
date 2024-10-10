import 'package:flutter/material.dart';
import 'themes/theme.dart'; 
import 'widgets/backgroundPatternWidget.dart'; // Import the BackgroundPatternWidget
import 'widgets/iconWidget.dart'; // Import the iconWidget
import 'widgets/verticalTextWidget.dart'; // Import the verticalTextWidget 
import 'widgets/customButton.dart'; // Import ButtonWidget



class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen>{ 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppThemes.lightTheme.primaryColor,
      /* Stack widget:
        * - Layers 2 widgets (Image and Column) on top of each other.
        * - Used to place the background image and the content (like icons and buttons) over it.
        * Background image:
          * - Displays the background animation image in the Stack.
        * Column widget:
          * - Aligns its child widgets vertically.
          * - mainAxisAlignment.spaceAround ensures the space between widgets and borders is evenly distributed.
      */
      body: Stack(
        children: [  
          BackgroundPatternWidget(
            patternType: 'BackgroundAnimation.png', 
            opacity: 1, 
            backgroundColor: AppThemes.lightTheme.primaryColor,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround, 
            children: [
              /* Container used to have horizontal padding
              * Row widget:
                * - Aligns its children horizontally (icons on one side, text on the other).
                * - mainAxisAlignment.spaceBetween puts space between the left (icons) and right (text) parts.
                * - crossAxisAlignment.end aligns the icons at the bottom.
              */
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /* Icons column:
                      * - Contains several IconButtons stacked vertically.
                      * - Each has a different icon (logomark, hotdog, etc.).
                        * - Each icon displays an image and is clickable.
                        * - Currently, they have empty onPressed handlers.
                    */
                    const Column(
                      children: [
                        IconWidget(imagePath: 'assets/images/Logomark1.png', ),
                        SizedBox(height: 16), // Spacing between icons
                        IconWidget(imagePath: 'assets/images/hotdog1.png', ),
                        SizedBox(height: 16),
                        IconWidget(imagePath: 'assets/images/burger-lettuce1.png', ),
                        SizedBox(height: 16),
                        IconWidget(imagePath: 'assets/images/ice-cream1.png', ),
                        SizedBox(height: 16),
                        IconWidget(imagePath: 'assets/images/salad1.png', ),
                        SizedBox(height: 16),
                        IconWidget(imagePath: 'assets/images/pizza-slice1.png',),
                      ],
                    ),

                    /* RotatedBox widget:
                        * - Rotates the Text widget by -90 degrees 
                        * - Text widget:
                          * - Displays the text "KoouL." in a large, bold font.
                          * - The font size is 85.0, using the custom Quicksand-Bold font.
                    */
                    VerticalTextWidget(
                      text: 'KoouL.', 
                      fontSize: 70.0, 
                      color: AppThemes.lightTheme.colorScheme.surface,
                    )
                  ],
                ),
              ),
              SizedBox(height: 100),
              /*
                * SizedBox widget:
                  * - Adds vertical spacing of 100 between the Row and the next column.
                * Buttons Column :
                    *- Contains two MaterialButton widgets stacked vertically.
                    *- Aligns the buttons with equal spacing.
                * First button: Login with phone number
                      *- Text is in Arabic, displayed on the button.
                      *- onPressed handler:
                          - When pressed, navigates to the "login" route.
                * Second button: Login with Google
                      * - Text is in Arabic, displayed on the button.                              
                * Buttons styling:
                      *- Uses a rounded rectangular shape with a radius of 40.0.
                      *- The button has a custom background color.
              */
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // login with phone number
                  CustomButton(
                    label: "دخول برقم الهاتف", 
                    onPressed: (){
                      Navigator.of(context).pushNamed("login");
                    }, 
                    backColor: Color.fromARGB(1,51,51,77),
                    textColor: AppThemes.lightTheme.scaffoldBackgroundColor,
                  ),
                  SizedBox(height: 10,),
                  // login with google account
                  CustomButton(
                    label: "Google دخول بحساب", 
                    onPressed: (){
                      Navigator.of(context).pushNamed("login");
                    }, 
                    backColor: AppThemes.lightTheme.scaffoldBackgroundColor,
                  ),  
                ],
              )
            ],
          ),
        ]
      )        
    );
  }
}
