import 'package:flutter/material.dart';
import 'package:project_name/widgets/buttonWithIcon.dart';
import 'package:project_name/widgets/iconButton.dart';
import 'package:project_name/widgets/iconContainer.dart';
import 'package:project_name/widgets/listTileAdresse.dart';
import 'themes/theme.dart';  
import 'language/RTLText.dart';  
import 'widgets/customButton.dart';
import 'widgets/iconWidget.dart';
import 'widgets/customTextField.dart';

class AddressDetails extends StatefulWidget {
  const AddressDetails({super.key});
  @override
  _AddressDetailsState createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  // the number of customer
  final TextEditingController _doorNbr = TextEditingController();
  // the Building number
  final TextEditingController _buildNbr = TextEditingController();
  // the full Adress 
  final TextEditingController _fullAdress = TextEditingController();

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
          // Column Where All Widgets Exists   
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,  // Distributes space evenly between widgets and the borders
            crossAxisAlignment: CrossAxisAlignment.start,  // Aligns all widgets to start from the layout border
            children: [
              // Row for Head Title and Icon Back Button
              Row(
                children: [
                   // ComeBack Icon '->'
                  IconButton(
                    onPressed: (){Navigator.pop(context);}, 
                    icon: const IconWidget(iconData: Icons.arrow_back_sharp, size: 30,)
                  ),
                  SizedBox(width: 20),
                  // Title
                  const Text("تفاصيل العنوان", style: TextStyle(fontSize: 28),)
                ],
              ),
                           
              // location Icon + City and Neighborhood + modify Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // location Icon + City and neighborhood
                  Expanded(
                    child: ListTileAdresse(
                      // Title
                      title: 'Casablanca', 
                      sizeTitle: 14,
                      fontWeight: FontWeight.bold,
                      // SubTitle
                      subtitle: 'Grand Casablanca',
                      sizeSubtitle: 12,
                      subtitleColor: Colors.grey,

                      textAlign: TextAlign.start,
                      // Leading
                      iconButtonContainer: IconContainer(
                        width: 48,
                        height: 48,
                        iconButtonWidget: IconButtonWidget(
                          iconWidget: const IconWidget(iconData: Icons.location_on_outlined,),
                          onpressed: () { Navigator.of(context).pushNamed('mapPage', arguments: "Address"); },
                        )
                      ),
                      ontap: () { Navigator.of(context).pushNamed('mapPage', arguments: "Address"); },
                    ),
                  ),  
                  // Modify Button
                  ButtonWithIcon(
                    iconData: Icons.autorenew,
                    text: 'تغيير',
                    backgroundColor: Color.fromARGB(1,234, 234, 241),
                    paddingH: 24,
                    paddingV: 12,
                    onpressed: () {
                      print("Button Pressed");                      
                    },
                  )
                ],
              ),
              // Door number input field
              CustomTextField(
                labelText: 'رقم لباب',
                hintText: 'رقم لباب',
                icon: Icons.door_back_door,
                text: _doorNbr,
              ),
                // Building number input field
              CustomTextField(
                labelText: 'رقم العمارة',
                hintText: 'رقم العمارة',
                icon: Icons.apartment,
                text: _buildNbr,
              ),
              // More Details input field
              CustomTextField(
                labelText: 'تفاصيل اضافية',
                hintText: 'تفاصيل اضافية',
                icon: Icons.info_outline,
                text: _fullAdress,
              ),
              // Spacer to add 100px vertical space
              const SizedBox(height: 100.0),
              // Entry button
              CustomButton(
                label:"دخول", 
                onPressed: (){
                  // open the mapWidget and Pass the address and building number as arguments
                  Navigator.of(context)
                    .pushNamed('mapPage',  arguments: '${_fullAdress.text} ${_buildNbr.text} ${_fullAdress.text}');
                },
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
