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
  double price = 52.00 * 0.5; // 1 Food Price 
  late double originPrice; // 1 Food Price with out sold 
  late double totalPrice = 52.00 ; // 2 Food Price
  double priceHT = 0.00 ; // hamburger toppings

  @override
  void initState() {
    super.initState();
    // Extract the numeric part from widget.price and convert it to double
    originPrice = double.parse(widget.price.split(' ')[0]); 
  }  

  void handleCheckboxChange(int index, bool? isChecked, List<Map<String,dynamic>> choices, title) {
    setState(() {
      choices[index]['isChecked${index+1}'] = isChecked ?? false;
      if (title ==  'حدد إضافات للهامبرغر'){
        isChecked == true ? priceHT += 2 * nbr : priceHT -= 2 * nbr ;
      } 
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
          padding: const EdgeInsets.only(top: 24, right: 24, left: 330),
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

        // Paragraph : Food Name and Info
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child:  foodInfo(widget.name, widget.info, widget.price)
        ),
       
        // Add Food Number
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // icon '-'
            _icons(Icons.remove, (){setState(() { 
                (nbr > 1)? nbr -= 1 : nbr =1 ; 
                // Recalculate `priceHT` based on the updated `nbr`
                priceHT = toppings
                  .where((topping) => topping['isChecked${toppings.indexOf(topping) + 1}'] as bool)
                  .length *
                  2 * nbr.toDouble();
                totalPrice = nbr * price;
              });
            }), // Decrease 1 until nbr = 1

            SizedBox(width: 20,),
            Text('$nbr', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),), // Number
            SizedBox(width: 20,),

            // icon '+'
            _icons(Icons.add, (){setState(() {
                (nbr < 100)? nbr += 1 : nbr = 100;
                // Recalculate `priceHT` based on the updated `nbr`
                priceHT = toppings
                  .where((topping) => topping['isChecked${toppings.indexOf(topping) + 1}'] as bool)
                  .length *
                  2 * nbr.toDouble();
                totalPrice = nbr * price;
              });
            }), // Increment 1 until nbr = 100
          ],
        ),
        SizedBox(height: 20),
      
        // Support
        choicesCard(
          108,         // Card Height 
          title(       // Card Title
            true,  // add widget 'مطلوب'
            'دعم', // Title Text 
          ),
          ListView.builder(  // List of Support Food
            itemCount: supportTile.length, 
            itemBuilder: (context, i) {
              return checkBoxListTile(
                checkBoxTitle(
                  false,                    // this card is not 'hamburger toppings'
                  supportTile[i]['text']!,  // food name 
                  supportTile[i]['image']!, // food image
                ), 
                supportTile[i]['isChecked${i+1}'] as bool, // is client chose this support food
                (isChecked) => handleCheckboxChange(
                  i,            // Element (support Food)
                  isChecked,    // is the Element (support Food) chosen 
                  supportTile,  // list of Supports
                  'دعم',        // title Card
                ),
              );
            },
            // scroll option at the Card
            physics: ScrollPhysics()     
          )
        ),       
        SizedBox(height: 20),
              
        // Choose Your Drink
        choicesCard(
          204,     // Card Height 
          title(   // Card Title
            true,           // add widget 'مطلوب'
            'اختر مشروبك', // Title Text 
          ),
          ListView.builder(   // List of Support Food
            itemCount: drinks.length, 
            itemBuilder: (context, i) {
              return checkBoxListTile(
                checkBoxTitle(
                  false,               // this card is not 'hamburger toppings'
                  drinks[i]['text']!,  // food name 
                  drinks[i]['image']!, // food image
                ), 
                drinks[i]['isChecked${i+1}'] as bool, // is client chose this support food
                (isChecked) => handleCheckboxChange(
                  i,               // Element (support Food)
                  isChecked,       // is the Element (support Food) chosen 
                  drinks,          // list of Supports
                  'اختر مشروبك',  // title Card
                ),
              );
            },
            // scroll option at the Card
            physics: ScrollPhysics()
          )
        ),       
        SizedBox(height: 20),
        
        // Customize Burger
        choicesCard(
          324,     // Card Height 
          title(   // Card Title
            false,          // add widget 'مطلوب'
            'تخصيص برغر',  // Title Text 
          ),
          ListView.builder(  // List of Support Food
            itemCount: customizeBurger.length, 
            itemBuilder: (context, i) {
              return checkBoxListTile(
                checkBoxTitle(
                  false,                        // this card is not 'hamburger toppings'
                  customizeBurger[i]['text']!,  // food name 
                  customizeBurger[i]['image']!, // food image
                ), 
                customizeBurger[i]['isChecked${i+1}'] as bool, // is client chose this support food
                (isChecked) => handleCheckboxChange(
                  i,                // Element (support Food)
                  isChecked,        // is the Element (support Food) chosen 
                  customizeBurger,  // list of Supports
                  'تخصيص برغر',    // title Card
                ),
              );
            },
            // scroll option at the Card
            physics: ScrollPhysics(),    
          )
        ),       
        SizedBox(height: 20),
        
        // Select hamburger toppings
        choicesCard(
          264,     // Card Height 
          title(   // Card Title
            false,                    // add widget 'مطلوب'
            'حدد إضافات للهامبرغر', // Title Text 
          ),
          ListView.builder(  // List of Support Food
            itemCount: toppings.length, 
            itemBuilder: (context, i) {
              return checkBoxListTile(
                checkBoxTitle(
                  true,                    // this card is 'hamburger toppings'
                  toppings[i]['text']!,    // food name 
                  toppings[i]['image']!,   // food image
                ), 
                toppings[i]['isChecked${i+1}'] as bool, // is client chose this support food
                (isChecked) => handleCheckboxChange(
                  i,                        // Element (support Food)
                  isChecked,                // is the Element (support Food) chosen 
                  toppings,                 // list of Supports
                  'حدد إضافات للهامبرغر', // title Card
                ),
              );
            },
            // scroll option at the Card
            physics: NeverScrollableScrollPhysics(),       
          )
        ),       
        SizedBox(height: 20),

        // Buy Button
        CustomButton(
          backColor: Color.fromRGBO(255, 66, 66, 1),
          textColor: Color.fromRGBO(255, 255, 255, 1),
          label: 'اطلب $nbr ب ${nbr > 1 ? totalPrice + priceHT : originPrice + priceHT } DH', 
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
Widget foodInfo(String name, String info, String price){
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
Widget choicesCard( double height, Widget title, Widget listView ){
  return Container(
    child: Column(
      children: [
        // Title
        title,
        // choices List
        Container(
          height: height,
          child: listView
        )        
      ],
    ),
  );
}
// Support Title, used at _choicesCard()
Widget title(bool isNeed, String title){
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(right: 12, top: 0, left: 12, bottom: 0),
    child: Directionality(textDirection: TextDirection.rtl,
      child: Row(
        children: [
          // title
          Text(
            title, 
            style: TextStyle( fontSize: 16, fontWeight: FontWeight.w700, color: Color.fromRGBO(51, 51, 77, 1),),
          ),
          SizedBox(width: 10),
          // if the Card "دعم" or "اختر مشروبك" add  textContainer()
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
Widget checkBoxListTile(Widget checkBoxTitle ,bool isChecked, Function(bool?) onChanged){
  return CheckboxListTile(
    contentPadding: EdgeInsets.zero, // Removes default padding
    title: checkBoxTitle, 
    value: isChecked,
    onChanged: onChanged, 
    controlAffinity: ListTileControlAffinity.leading,
    checkboxShape: CircleBorder(   // border style
      side: BorderSide( 
        color: isChecked ? Color.fromRGBO(255, 181, 0, 1) : Color.fromRGBO(203, 203, 220, 1), // Gold if checked, grey if unchecked
        width: 1,
      ),
    ),
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {   // background color 
      if (states.contains(MaterialState.selected)) {
        return Color.fromRGBO(255, 181, 0, 1); // Gold background when checked
      }
      return Colors.white; // White background when unchecked
    }),
    checkColor: Colors.white, // White check sign
  );
}

// title of CheckBox, used at _checkBoxListTile()
Widget checkBoxTitle(bool isToppings, String text, String image){
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if(isToppings) // if the Card is 'حدد إضافات للهامبرغر',
          toppingsPrice(), // add text "+ 2 DH" in the Title 
          
        SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color.fromRGBO(114, 114, 161, 1)),),
        SizedBox(width: 10),
        imageContainer(image) // additional Food Image
      ],
    )
  );
}

// Image Style used at _checkBoxTitle()
Widget imageContainer(String image){
  return Container(
    width: 48, height: 48,
    decoration: BoxDecoration(
      border: Border.all(width: 1, color: Color.fromRGBO(234, 234, 241, 1)),
      borderRadius: BorderRadius.circular(24)
    ),
    child: Image.asset(image, width: 48, height: 48)
  );  
} 

// '+2 DH' used at _checkBoxTitle()
Widget toppingsPrice(){
  return const Text(
    '+ 2.00 DH', 
    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color.fromRGBO(255, 66, 66, 1))
  );
}
