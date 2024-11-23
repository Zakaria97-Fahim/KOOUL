import 'package:flutter/material.dart';
import 'package:project_name/home.dart';
import 'package:project_name/product.dart';
import 'package:project_name/widgets/iconButton.dart';
import 'package:project_name/widgets/iconContainer.dart';
import 'package:project_name/widgets/iconWidget.dart';
import 'package:project_name/widgets/customButton.dart';

import 'language/RTLText.dart';

class StoreProducts extends StatefulWidget {  
  @override
  _StoreProductsState createState() => _StoreProductsState();
}

class _StoreProductsState extends State<StoreProducts> {
  String backImage = '' ;
  String logo = '';  
  String foodN = '';
  String address = '';
  TextEditingController searchText = TextEditingController();
  
  List<String> menuFrame = ['القائمة', 'القائمة', 'القائمة', 'القائمة', 'القائمة'];
  int selectedIndex = 0; // No selection initially

  // List of Food Card Info 
  List<Map<String,String>> infos = [
    { 
      'image': 'assets/images/stapleFood/card1.jpg',
      'name': 'Menu Hamburger', 
      'info': 'Une viande de bœuf grillée à la flamme, du ketchup, de la moutarde et des cornichons. Un classique.', 
      'price': '28.00 DH'
    },
  ];  

  @override
  void didChangeDependencies() { 
    // Override the didChangeDependencies() method to perform tasks when widget's dependencies change (or on first load).
    super.didChangeDependencies(); 
    // Call the parent class's didChangeDependencies() to ensure proper behavior of inherited dependencies.
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    // Retrieve the arguments (here, the address) passed to this screen through the route's settings.
    setState(() { 
      backImage = args['backImage'];
      logo = args['logo']; 
      foodN = args['foodN'];
      address = args['address'];
    });     
  }

  @override
  Widget build(BuildContext context) {    
    return RTLPage(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Image and Logo
              _navBar(backImage, logo, context, address),
              SizedBox(height: 40,),
              // Card content : Food Name and user Address
              _cardTitle(foodN, address),
              SizedBox(height: 20,),
              // Times 
              _timeRow(),
              SizedBox(height: 20,),
              // Gift and Rates 
              _giftANDrates(),
              SizedBox(height: 20,),
              // Search Bar
              Container( 
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: _searchBar(searchText),
              ),
              // List of Menu
              _menu(),  
              // menu Card
              SizedBox(
                height: 600, // Adjust height as needed
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      child: _foodCard(infos[0]['image']!, infos[0]['name']!,infos[0]['info']! ,infos[0]['price']!),
                      onTap: () {}
                    );  
                  },
                ),
              )
            ]
          )
        ),
        // Buy Button
        floatingActionButton: CustomButton(
          backColor: Color.fromRGBO(255, 66, 66, 1),
          textColor: Color.fromRGBO(255, 255, 255, 1),
          label: 'اطلب 2 ب 52.00 DH', 
          // In your CustomButton's onPressed method
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true, // Allows control over height
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)), // Rounded top corners
              ),
              builder: (context) {
                return  Container(
                  height: 665, 
                  width: double.infinity,
                  child: ProductSheet(
                    name: infos[0]['name']!,
                    info: infos[0]['info']!,
                    price: infos[0]['price']!,
                  ),     
                );
              },
            );
          },
        )
      )
    );
  }

  // List of Menus
  Widget _menu(){
    return SizedBox(
      height: 54, // Slightly taller to accommodate the red line
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: menuFrame.length,
        itemBuilder: (context, i) {
          bool isSelected = selectedIndex == i; // Check if this item is selected
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = i; // Update the selected index
              });
            },
            child: Column(
              children: [
                // text 'menu'
                Container(
                  width: 63, height: 44,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.center,
                  child: Text(
                    menuFrame[i],
                    style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500,
                      color: isSelected
                          ? Colors.red // Red color if selected
                          : Color.fromRGBO(114, 114, 161, 1), // Default color if not selected
                    ),
                  ),
                ),
                // Display the red line if this item is selected
                if (isSelected)
                  Container( width: 63, height: 2, color: Colors.red,),    
              ],
            ),
          );
        },
      ),
    );
  }
}  
// Image Food and Logo
Widget _navBar(String backImage, String logo, context, String address){
  return Stack(
    clipBehavior: Clip.none,
    children: [
      // Image
      Image.asset(backImage, width: double.infinity, height: 188, fit: BoxFit.cover,),
      // Arrow Back '->'
      Positioned(
        top: 40, right:10,
        child: IconContainer(
          iconButtonWidget: IconButtonWidget(
            iconWidget: IconWidget(iconData: Icons.arrow_back, size: 25), 
            onpressed: (){Navigator.pushReplacementNamed(context, 'home', arguments: address);}),
        )
      ),
      Positioned(
        bottom: -32, right: 0, left: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            Container( 
              width: 64, height: 64,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 5),
                borderRadius: BorderRadius.circular(50)
              ),
              child: Image.asset(logo, width: 64, height: 64, fit: BoxFit.contain), 
            )
          ]
        )  
      )
    ],
  );
} 
// Food Name and user Address
Widget _cardTitle(String foodN, String address){
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Food Name
      Text(foodN, style: TextStyle(color: Color.fromRGBO(51, 51, 77, 1), fontWeight: FontWeight.w600, fontSize: 16),),
      // Client review
      Text('I’m loving it', style: TextStyle(color: Color.fromRGBO(114, 114, 161, 1), fontWeight: FontWeight.w500, fontSize: 12),),
      SizedBox(height: 10,),
      // User Address
      Directionality(
        textDirection: TextDirection.ltr, 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconWidget(iconData: Icons.location_on, color:Color.fromRGBO(114, 114, 161, 1),),
            SizedBox(width: 10),
            Text(address, style: TextStyle(color: Color.fromRGBO(114, 114, 161, 1), fontWeight: FontWeight.w500, fontSize: 12),),
          ],
        ),  
      )
    ],
  );
} 
// Row of Times
Widget _timeRow(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Distance
      iconTextContainer2(
        Icons.signpost_outlined, // iconData
        '600 m', // text
      ),
      SizedBox(width: 10,),
      // Time
      iconTextContainer2(
        Icons.access_time, // iconData
        '11:00 - 22:00', // text
      ),
      SizedBox(width: 10,),
      // Delivery time
      iconTextContainer2(
        Icons.moped, // iconData
        "30 min", // text
      ),
    ],
  );
}

// Container with Icon and Text, with direction option. Used at _timeRow()
Widget iconTextContainer2(IconData icon, String text, {TextDirection direction = TextDirection.ltr} ) {
  Color backgroundColor = Colors.white; // backgroundColor;
  Color color = Color.fromRGBO(51, 51, 77, 1); // content Color
  
  return Directionality(
    textDirection: direction, 
    child: GestureDetector(
      onTap: () {},
      child: Container(
        height: 24,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(width: 1, color: Color.fromRGBO(234, 234, 241, 1))
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Fit content width
          children: [
            IconWidget(iconData: icon, color: color, size: 16),
            SizedBox(width: 4), // Space between icon and text
            Text(
              text,
              style: TextStyle( fontSize: 11, color: color, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    )
  );  
}      
// Row of Gift and Rates
Widget _giftANDrates(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Rates
      iconTextContainer1(
        Color.fromRGBO(255, 181, 0, 1),
        Icons.star, // iconData
        '4.5', // text
      ),
      SizedBox(width: 10,),
      // Gift
      iconTextContainer1(
        Color.fromRGBO(29, 177, 142, 1),
        Icons.card_giftcard, // iconData
        'توصيل مجاني', // text
      ),
    ],
  );
}
// Search bar
Widget _searchBar(searchText){
  Color backgroundColor = Color.fromRGBO(234, 234, 241, 1);
  return TextField(
    controller: searchText,
    decoration: InputDecoration(
      filled: true,
      fillColor: backgroundColor,
      hintText: 'البحث',
      hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
      prefixIcon: const Icon(Icons.search),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide(color: backgroundColor),
      ),
    ),
    onChanged: (val) {},
  );
}

// List of Food Info Card 
Widget _foodCard(String img, String name, String info, String price) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),  // Card Radius
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Food Image with rounded corners
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            img,
            width: 72,
            height: 72,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 10), // Space between image and text column
        // Food Info
        foodInfo(name, info, price)
      ],
    ),
  );
}
Widget foodInfo(String name, String info, String price){
  return  Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name
        Text(
          name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(51, 51, 77, 1),
          ),
        ),
        // Info (will wrap to next line if necessary)
        Text(
          info,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(114, 114, 161, 1),
          ),
        ),
        SizedBox(height: 10), // Space between Text and Pric
        // Price
        Text(
          price,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(51, 51, 77, 1),
          ),
        ),
      ],
    ),
  );
}