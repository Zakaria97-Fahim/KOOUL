import 'package:flutter/material.dart';
import 'themes/theme.dart';  
import 'language/RTLText.dart';  
import 'language/languageToggleButton.dart';
import 'widgets/customButton.dart';
import 'widgets/iconWidget.dart';
import 'widgets/headerWidget.dart';
import 'widgets/customTextField.dart';

class AddressDetails extends StatefulWidget {
  const AddressDetails({super.key});
  @override
  _AddressDetailsState createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {

  @override
  Widget build(BuildContext context) {

    /* Custom class RTLPage ensures (RTL or LTR) layout for Arabic or English text
     * RTLPage() is used to support Right-to-Left (RTL) languages, like Arabic.
    */

    return RTLPage(   
      child: Scaffold(
        // Padding to ensure 15px of space around all sides of the content      
        body: Padding( 
          padding: const EdgeInsets.all(15.0),  
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,  // Distributes space evenly between widgets and the borders
            crossAxisAlignment: CrossAxisAlignment.start,  // Aligns all widgets to start from the layout border
            children: [
              // Row for Head Title and Icon Back Button
              Row(
                children: [
                   // ComeBack Icon
                  IconButton(
                    onPressed: (){Navigator.pop(context);}, 
                    icon: const IconWidget(iconData: Icons.arrow_back_sharp)
                  ),
                  // Language Switch Button
                  const Text("تفاصيل العنوان", style: TextStyle(fontSize: 28),)
                ],
              ),
                           
              // location Icon + City and neighborhood + modify Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // location Icon + City and neighborhood
                  Row(
                    children: [
                      // Location Icon
                      Container(
                        width: 60, // Circle width
                        height: 60, // Circle height
                        decoration: BoxDecoration(
                          color: Colors.white, // Circle background color
                          shape: BoxShape.circle, // Makes the container circular
                          border: Border.all(color: Colors.grey, width: 1), // Thin grey border
                        ),
                        child: const Icon(
                          Icons.location_on_outlined,
                          color: Colors.black, // Icon color
                          size: 30, // Icon size
                        ),
                      ),
                      const SizedBox(width: 10,),
                      // City & Neighborhood
                      const HeaderWidget(
                        title: 'Casablanca', 
                        subtitle: 'Grand Casablanca',
                        textAlign: TextAlign.start,
                        sizeTitle: 14,
                        sizeSubtitle: 12,
                        subtitleColor: Colors.grey,
                      )
                    ],
                  ),
                  // Modify Button
                  ElevatedButton.icon(
                    onPressed: () {
                      print("Button Pressed");
                    },
                    icon: Icon(Icons.autorenew, color: Colors.black,), // The rotate icon you want to display
                    label: Text('تغيير', style: TextStyle(color: Colors.black),), // The text next to the icon
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), 
                      backgroundColor: const Color.fromARGB(1,234, 234, 241),
                    ),
                  )
                ],
              ),

              // Door number input field
              const CustomTextField(
                labelText: 'رقم لباب',
                hintText: 'رقم لباب',
                icon: Icons.door_back_door,
              ),
              // Architecture number input field
              const CustomTextField(
                labelText: 'رقم العمارة',
                hintText: 'رقم العمارة',
                icon: Icons.apartment,
              ),
              // More Details input field
              const CustomTextField(
                labelText: 'تفاصيل اضافية',
                hintText: 'تفاصيل اضافية',
                icon: Icons.info_outline,
              ),
              
              // Spacer to add 100px vertical space
              const SizedBox(height: 100.0),

              // Entry button
              CustomButton(
                label:"دخول", 
                onPressed: (){},
                backColor: AppThemes.lightTheme.primaryColor, // Red Color
                textColor: AppThemes.lightTheme.scaffoldBackgroundColor, // White Color
              ),
            ]   
          ),
        )
      )
    );
  }
}
