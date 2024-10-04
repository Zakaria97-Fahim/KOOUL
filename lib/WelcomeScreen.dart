import 'package:flutter/material.dart';
import 'themes/theme.dart';


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
        Image.asset("assets/images/BackgroundAnimation.png"), // the Background Image
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround, 
          children: [
            /* Row widget:
              * - Aligns its children horizontally (icons on one side, text on the other).
              * - mainAxisAlignment.spaceBetween puts space between the left (icons) and right (text) parts.
              * - crossAxisAlignment.end aligns the icons at the bottom.
            */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                /* Icons column:
                  * - Contains several IconButtons stacked vertically.
                  * - Each button has a different icon (logomark, hotdog, etc.).
                    * - Each button displays an image and is clickable.
                    * - Currently, they have empty onPressed handlers.
                */
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
                /* RotatedBox widget:
                    * - Rotates the Text widget by -90 degrees 
                    * Text widget:
                      * - Displays the text "KoouL." in a large, bold font.
                      * - The font size is 85.0, using the custom Quicksand-Bold font.
                */
                RotatedBox(
                    quarterTurns: -1,
                    child: Text('KoouL.', 
                      style: TextStyle(
                        fontFamily: 'Quicksand-Bold',
                        fontSize: 85.0, 
                        color: AppThemes.lightTheme.colorScheme.surface),
                    ),
                ),
              ],
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
                     *- Uses a rounded rectangular shape with a radius of 50.0.
                     *- The button has a custom background color.
            */
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
      ]
      )        
    );
  }
}
