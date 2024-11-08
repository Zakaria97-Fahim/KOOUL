import 'package:flutter/material.dart';
import 'package:project_name/home.dart';
import 'package:project_name/widgets/customButton.dart';
import 'package:project_name/widgets/iconButton.dart';
import 'package:project_name/widgets/iconContainer.dart';
import 'package:project_name/widgets/iconWidget.dart';

class ProductSheet extends StatefulWidget {
  final String name, info, price ;

  ProductSheet({
    Key? key,
    this.name = 'name',
    this.info = 'info',
    this.price = 'price',
  }) : super(key: key);

  @override
  _ProductSheetState createState() => _ProductSheetState();
}

class _ProductSheetState extends State<ProductSheet> {
  
  int nbr = 2;  // Food Number

  void handleCheckboxChange(int index, bool? newValue, List<Map<String,dynamic>> choices) {
    setState(() {
      choices[index]['isChecked${index+1}'] = newValue ?? false;
    });
  }
  

  List<Map<String,dynamic>> supportTile =[
    {'image': 'assets/images/support/support.png',  'text':'Coca Cola PET 25cl',      'isChecked1': true},
    {'image': 'assets/images/support/support2.png', 'text':'Coca Cola Zéro PET 25cl', 'isChecked2': false},
  ];
  List<Map<String,dynamic>> drinks =[
    {'image': 'assets/images/drinks/coca.png',   'text':'Coca Cola PET 25cl',      'isChecked1': true},
    {'image': 'assets/images/drinks/coca2.png',  'text':'Coca Cola Zéro PET 25cl', 'isChecked2': false},
    {'image': 'assets/images/drinks/sprite.png', 'text':'Sprite PET 25cl',         'isChecked3': false},
  ];
  List<Map<String,dynamic>> customizeBurger =[
    {'image': 'assets/images/toppings/mustard.png', 'text':'بدون خردل',        'isChecked1': false},
    {'image': 'assets/images/toppings/ketchup.png', 'text':'بدون كاتشب',       'isChecked2': false},
    {'image': 'assets/images/toppings/onion.png',   'text':'بدون بصل',         'isChecked3': false},
    {'image': 'assets/images/toppings/pickles.png', 'text':'بدون خيار مخلل',   'isChecked4': false},
    {'image': 'assets/images/toppings/meat.png',    'text':'بدون لحم',         'isChecked5': false},
  ];
  List<Map<String,dynamic>> toppings =[
    {'image': 'assets/images/toppings/mustard.png', 'text':'خردل إضافي',        'isChecked1': false},
    {'image': 'assets/images/toppings/ketchup.png', 'text':'كاتشب إضافي',       'isChecked2': false},
    {'image': 'assets/images/toppings/onion.png',   'text':'بصل إضافي',         'isChecked3': false},
    {'image': 'assets/images/toppings/pickles.png', 'text':'خيار مخلل إضافي',   'isChecked4': false},
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
     padding: const EdgeInsets.only(left: 12, right: 12),
     child: Column(
      children: [
        // Close Icon
        Padding(
          padding: const EdgeInsets.only(top: 24, right: 24,),
          // Closes the bottom sheet
          child: IconButtonWidget(
            iconWidget: IconWidget(iconData: Icons.close, size: 30), 
            onpressed: (){ Navigator.of(context).pop(); }
          )
        ),
        // Food Image with rounded corners
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset('assets/images/stapleFood/card1.jpg' , width: double.infinity, height: 230, fit: BoxFit.cover),
        ),
        // Food Name and Info
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child:  _foodInfo(widget.name, widget.info, widget.price)
        ),
        // Add Food Number
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // icon '-'
            _icons(Icons.remove, (){setState(() { (nbr > 1)? nbr-= 1 : nbr =1 ;});} ), // Decrease 1 until nbr = 1
            SizedBox(width: 20,),
            Text('$nbr', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),), // Nomber
            SizedBox(width: 20,),
            // icon '+'
            _icons(Icons.add, (){setState(() {(nbr < 100)? nbr+= 1 : nbr = 100;});} ), // Increment 1 until nbr = 100
          ],
        ),
        SizedBox(height: 20),
        // Support
        _choicesCard(
          true,  // add widget 'مطلوب'
          'دعم',
          108,
          false, // this card is not 'hamburger toppings'
          supportTile,         
          handleCheckboxChange,
          true, // allow scroll option at the Card
        ),       
        SizedBox(height: 20),
        // Choose Your Drink
        _choicesCard(
          true, // add widget 'مطلوب'
          'اختر مشروبك',
          204,
          false, // this card is not 'hamburger toppings'
          drinks,         
          handleCheckboxChange,
          true, // allow scroll option at the Card
        ),
        SizedBox(height: 20),
        // Customize Burger
        _choicesCard(
          false, // don't add widget 'مطلوب'
          'تخصيص برغر',
          324,
          false, // this card is not 'hamburger toppings'
          customizeBurger,         
          handleCheckboxChange,
          false, // stop scroll option at the Card
        ),  
        SizedBox(height: 20),
        // Select hamburger toppings
        _choicesCard(
          false, // don't add widget 'مطلوب'
          'حدد إضافات للهامبرغر',
          264,
          true, // this card is 'hamburger toppings'
          toppings, 
          handleCheckboxChange,
          false, // stop scroll option at the Card
        ),
        SizedBox(height: 20),
        // Buy Button
        CustomButton(
          backColor: Color.fromRGBO(255, 66, 66, 1),
          textColor: Color.fromRGBO(255, 255, 255, 1),
          label: 'اطلب $nbr ب 52.00 DH', 
          onPressed: () {},
        ),
        SizedBox(height: 20),
      ],
     )
    );
  }
}  

// Icon '+' and '-' decoration
Widget  _icons(IconData icon, VoidCallback onPressed){
  return IconContainer(
    iconButtonWidget: IconButtonWidget(
      iconWidget: IconWidget(iconData: icon, size: 24, color: Color.fromRGBO(29, 177, 142, 1),),
      onpressed: onPressed,
    ),
    borderThin: 0,
    backgroundColor: Color.fromRGBO(229, 251, 246, 1),
    borderColor: Color.fromRGBO(229, 251, 246, 1),
  );
}

// Food Name, Info and Price
Widget _foodInfo(String name, String info, String price){
  return  Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name
        Text( name, style: TextStyle( fontSize: 22, fontWeight: FontWeight.w700, color: Color.fromRGBO(51, 51, 77, 1),)),
        // Info
        Text( info, style: TextStyle( fontSize: 11, fontWeight: FontWeight.w600, color: Color.fromRGBO(114, 114, 161, 1),)),
        SizedBox(height: 10),
        // Price
        Text( price, style: TextStyle( fontSize: 22, fontWeight: FontWeight.w600, color: Color.fromRGBO(51, 51, 77, 1),)),
      ],
    ),
  );
}

// Support
Widget _choicesCard(
  bool isNeed, 
  String title,
  double height, 
  bool isToppings,
  List<Map<String,dynamic>> choices, 
  Function(int index, bool? value, List<Map<String, dynamic>> choices) handleCheckboxChange,
  bool isScrollable
){
  return Container(
    child: Column(
      children: [
        // Title
        _title(isNeed, title), 
        // choices List
        Container(
          height: height,
          child: ListView.builder(
            itemCount: choices.length,
            itemBuilder: (context, i) {
              return _checkBoxListTile(
                isToppings,
                choices[i]['text']!, 
                choices[i]['image']!, 
                choices[i]['isChecked${i+1}'] as bool,
                (newValue) => handleCheckboxChange(
                  i, 
                  newValue, 
                  choices
                ),
              );
            },
            physics: isScrollable ? ScrollPhysics() : NeverScrollableScrollPhysics(),        
          )
        )        
      ],
    ),
  );
}
// Support Title, used at _choicesCard()
Widget _title(bool isNeed, String title){
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(right: 12, top: 0, left: 12, bottom: 0),
    child: Directionality(textDirection: TextDirection.rtl,
      child: Row(
        children: [
          // title
          Text(title, style: TextStyle( fontSize: 16, fontWeight: FontWeight.w700, color: Color.fromRGBO(51, 51, 77, 1),),),
          SizedBox(width: 10),
          if (isNeed)
            textContainer(
              'مطلوب', // Text 
              c: Color.fromRGBO(255, 181, 0, 1),  // backgroundColor
            )   
        ],
      ),
    ), 
  );  
}
// CheckBoc ListTile used at _supprtCard()
Widget _checkBoxListTile(bool isToppings, String text, String image, bool isChecked, Function(bool?) onChanged){
  return CheckboxListTile(
    contentPadding: EdgeInsets.zero, // Removes default padding
    title: _checkBoxTitle(isToppings, text, image),
    value: isChecked,
    onChanged: onChanged,
    controlAffinity: ListTileControlAffinity.leading,
    // Custom circular checkbox with conditional styling
    checkboxShape: CircleBorder(
      side: BorderSide(
        color: isChecked ? Color.fromRGBO(255, 181, 0, 1) : Color.fromRGBO(203, 203, 220, 1), // Gold if checked, grey if unchecked
        width: 1,
      ),
    ),
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return Color.fromRGBO(255, 181, 0, 1); // Gold background when checked
      }
      return Colors.white; // White background when unchecked
    }),
    checkColor: Colors.white, // White check sign
  );
}
// title of CheckBoxListTile, used at _checkBoxListTile()
Widget _checkBoxTitle(bool isToppings, String text, String image){
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if(isToppings)
          toppingsPrice(), // add text "+ 2 DH" in the Title 
        SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color.fromRGBO(114, 114, 161, 1)),),
        SizedBox(width: 10),
        _imageContainer(image)
      ],
    )
  );
}
// Image Style used at _checkBoxTitle()
Widget _imageContainer(String image){
  return Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      border: Border.all(width: 1, color: Color.fromRGBO(234, 234, 241, 1)),
      borderRadius: BorderRadius.circular(24)
    ),
    child: Image.asset(image, width: 48, height: 48)
  );  
}        
// '+2 DH' used at _checkBoxTitle()
Widget toppingsPrice(){
    return const Text('+ 2.00 DH', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color.fromRGBO(255, 66, 66, 1)));
}
