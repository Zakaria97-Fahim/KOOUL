import 'package:flutter/material.dart';
import 'package:project_name/widgets/iconButton.dart';
import 'package:project_name/widgets/iconContainer.dart';
import 'package:project_name/widgets/iconWidget.dart';
import 'language/RTLText.dart';

class Home extends StatefulWidget {  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  String? selectedSite ;

  // get the Delivery Addresses
  String? deliveryAddress;
  String? idMarker;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Safely retrieve arguments
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null) {
      setState(() {
        if (args is Map<String, String>) {
          // Handle the case when arguments are a Map
          deliveryAddress = args['address'];
          idMarker = args['id'];
        } else if (args is String) {
          // Handle the case when a single String is passed
          deliveryAddress = args;
        }
      });
    }
  }

  // used for search TextField
  TextEditingController searchText = TextEditingController();

  // user local address 
  // String address = 'App 21, Imm 265, Bd Zerktouni...';
  
  // List of names and images Food 
  final List<Map<String, String>> items = [
    {"image": "assets/images/artBoard/Artboard1.png", "text": "لوريم"},
    {"image": "assets/images/artBoard/Artboard2.png", "text": "لوريم"},
    {"image": "assets/images/artBoard/Artboard3.png", "text": "لوريم"},
    {"image": "assets/images/artBoard/Artboard4.png", "text": "لوريم"},
    {"image": "assets/images/artBoard/Artboard5.png", "text": "لوريم"},
    {"image": "assets/images/artBoard/Artboard6.png", "text": "لوريم"},
    {"image": "assets/images/artBoard/Artboard7.png", "text": "لوريم"},
  ];

  // List of Card Images
  final List<String> cards = [
    "assets/images/stapleFood/card1.jpg",
    "assets/images/stapleFood/card2.png",
    "assets/images/stapleFood/card3.png",
  ];
  
  // List of Row Images
  final List<String> imgs = [
    "assets/images/BurgerKing.png",
    "assets/images/Rectangle1.png",
    "assets/images/Rectangle2.png",
  ];
  
  // List of Food Name 
  final List<String> foodName =[
    'برغر كينغ ',
    'ماكدونالدز ',
    'طاكوس دو ليون ',
  ];
  
  // List of Local Place
  final List<String> localPlace = [
    'معارف',
    'معارف',
    'معارف',
  ];

  @override
  Widget build(BuildContext context) {
    return RTLPage(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // NavBar and Ads-Container
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // NavBar
                  Container(
                    height: 254,
                    color: Color.fromRGBO(51, 51, 77, 1),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 50),
                        // Row Content with Dropdown for location and shopping cart button
                        _appBarContent(deliveryAddress!),
                        SizedBox(height: 20),
                        // Search 
                        _searchBar(searchText, () {}),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  // Ads-Container
                  Positioned(
                    top: 218, left: 0, right: 0,
                    child: Center( child: _adsContainer() ),
                  ),
                ],
              ),
              SizedBox(height: 140),                            
              // Food Vertical List
              SizedBox(
                height: 66, // Define height explicitly
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return _foodVerticalList(items[index]["image"]!, items[index]["text"]!);
                  },
                ),
              ),
              // Cards List with fixed height
              SizedBox(
                height: 600, // Adjust height as needed
                child: ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      child: _storeCard(cards[i], imgs[i], '${foodName[i]} ${localPlace[i]}', '4.5', '600 m'),
                      onTap: () {
                        Navigator.of(context)
                          .pushNamed('storeProducts', 
                          arguments: {'backImage': cards[i], 'logo': imgs[i], 'foodN': foodName[i], 'address': deliveryAddress});
                      }
                    );  
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // AppBar Content with Dropdown for location and shopping cart button
  Widget _appBarContent(String address) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Client Address Dropdown
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('الموقع الجغرافي', style: TextStyle(fontSize: 12, color: Color(0xFFAFAFCA))),
            DropdownButton<String>(
              dropdownColor: Color.fromRGBO(51, 51, 77, 1),
              hint: const Text("حدد موقعا", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
              value: selectedSite,
              onChanged: (site) => selectedSite = site! ,
              items: [
                DropdownMenuItem(
                  value: 'home',
                  child: addressRow(
                    Icons.house_rounded,
                    Colors.white,
                    idMarker == 'House' ? address : 'Empty Address',
                    Colors.white
                  ),
                ),
                DropdownMenuItem(
                  value: 'work',
                  child: addressRow(
                    Icons.work,
                    Colors.white,
                    idMarker == 'Job' ? address : 'Empty Address',
                    Colors.white
                  ),
                ),
                DropdownMenuItem(
                  value: 'lorem',
                  child: addressRow(
                    Icons.apartment,
                    Colors.white,
                    idMarker == 'lorem' ? address : 'Empty Address',
                    Colors.white
                  ),
                ),
                DropdownMenuItem(
                  value: 'new',
                  child: addressRow(
                    Icons.apartment,
                    Colors.white,
                    idMarker == 'new' ? address : 'Empty Address',
                    Colors.white
                  ),
                ),

              ],
            ),
          ],
        ),
        // shopping Icon
        _shoppingCart(),
      ],
    );
  }
}
// Location Row widget for AppBar
Widget addressRow(IconData icon, Color iconColor, String address, Color textColor) {
  return Row(
    children: [
      IconWidget(iconData: icon, color: iconColor),
      Text(
        address,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: textColor),
      ),
    ],
  );
}
// Shopping Cart Icon widget for AppBar
Widget _shoppingCart() {
  return IconContainer(
    backgroundColor:Color.fromRGBO(51, 51, 77, 1),
    borderColor: Color.fromRGBO(51, 51, 77, 1),
    iconButtonWidget: IconButtonWidget(
      iconWidget: IconWidget(iconData: Icons.shopping_cart_outlined, size: 24, color: Colors.white),
      onpressed: () {},
    ),
  );
}
// Search Bar
Widget _searchBar(TextEditingController searchText, VoidCallback onPressed) {
  return TextField(
    controller: searchText,
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color.fromRGBO(69, 69, 104, 1), // Background Color
      hintText: 'البحث',
      hintStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
      prefixIcon: const IconWidget(
        iconData: Icons.search_outlined,
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      suffixIcon: Container(
        margin: EdgeInsets.all(8),
        child: _sliderIcon(onPressed) // Sliders Icon Button
      ),   //,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide(color:const Color.fromRGBO(69, 69, 104, 1),)
      )
    ),
  );
}
Widget _sliderIcon(VoidCallback onPressed) {
  return IconContainer(
    backgroundColor: const Color.fromRGBO(255, 66, 66, 1),
    borderColor: const Color.fromRGBO(255, 66, 66, 1),
    iconButtonWidget: IconButtonWidget(
      iconWidget: const IconWidget(
        iconData: Icons.tune,
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      onpressed: onPressed,
    ),
  );
}

// Ads Red Container
Widget _adsContainer(){
  return Stack(
    children: [
      // Ads-Container
      Container(
        height: 155, width: 366,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(250, 0, 0, 1),
          borderRadius: BorderRadius.circular(24),
        ),
        // Make the logo 'M' at the center
        child: Center(child: Image.asset('assets/images/path20.png', width: 86, height: 100,),),
      ),
      // Ad Text
      Positioned(
        top: 0, left: 0,
        child:Container(
          height: 36, width: 48,
          decoration: const BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 1),            
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            )
          ),
          child: Center(child: Text('Ad')), 
        ),
      ),  
    ],
  );
}

// list of Food Images
Widget _foodVerticalList(String img, String name){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      children: [
        Image.asset(img, width: 48, height: 48),
        Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
      ],
    ),
  );
}
// List of Stroe Card 
Widget _storeCard(String img, String img2, String foodName, String rates, String distance){
  return Container(
    width: double.infinity, height: 170,
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)), // Card Raduis
    child: Stack(
        children: [
          // the Image
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                Image.asset(img,width: double.infinity, height: double.infinity, fit: BoxFit.cover,),
                _filterColor() // to make A Shadow on the Image
              ],
            )
          ),  
          // Favorite Button Icon 
          Positioned(
            top: 12, left: 12,
            child: IconButtonWidget(
              iconWidget: Icon(Icons.favorite_border, color: Color.fromRGBO(255, 255, 255, 1),), 
              onpressed: (){}
            ),
          ),
          // Service Info
          Positioned(
            right: 10, bottom: 10,
            child: Container(
              height: 52, width: 298,
              child: Row(
                children: [
                  // Image
                  Image.asset(img2, width: 48, height: 48, fit: BoxFit.fill),
                  SizedBox(width: 8,),
                  // Service Info
                  Column(
                    children: [
                      // Food Place
                      Row(
                        children: [
                          // Food Name
                          Text(foodName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color.fromRGBO(255, 255, 255, 1))),
                          SizedBox(width: 4,),
                          // Rates
                          iconTextContainer1(
                           Color.fromRGBO(255, 181, 0, 1),    // backgroundColor
                            Icons.star,                         // iconData
                            rates,                              // text
                          ),
                          SizedBox(width: 4,),
                          // Place Distance
                          iconTextContainer1(
                           Color.fromRGBO(51, 51, 77, 1),     // backgroundColor
                            Icons.location_on,                  // iconData
                            distance,                           // text
                          ),
                        ],
                      ),
                      // Food Type
                      Row(
                        children: [
                          // fast food
                          textContainer('الطعام السريع'),
                          SizedBox(width: 4,),
                          //
                          textContainer('وجبات خفيفة'),
                          SizedBox(width: 4,),
                          // fast food
                          textContainer('الطعام السريع'),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ]
      ),
  );
}
// Filter Color
Widget _filterColor(){
  // Gradient overlay
  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(51, 51, 77, 0.0), // Start with transparent
          Color.fromRGBO(51, 51, 77, 0.8), // End with opacity 0.8
        ],
        begin: Alignment.topCenter,   // Start on the Top
        end: Alignment.bottomCenter,  // End on the Bottom
      ),
      borderRadius: BorderRadius.circular(24),
    ),
  );
}

// Container with Icon and Text, with direction option
Widget iconTextContainer1(Color backgroundColor, IconData icon,  String text, {TextDirection direction = TextDirection.ltr} ) {
  Color color = Color.fromRGBO(255, 255, 255, 1);
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
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Fit content width
          children: [
            Icon(icon, color: color, size: 10),
            SizedBox(width: 4), // Space between icon and text
            Text(text, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    )
  );  
}
// Container with Text
Widget textContainer(String text, {Color c =const Color.fromRGBO(14, 18, 23, 0.25), TextDirection direction = TextDirection.ltr}) {
  return Directionality(
    textDirection: direction, 
    child: GestureDetector(
      onTap: () {},
      child: Container(
        height: 24,
        padding: const EdgeInsets.symmetric(horizontal: 8), // Adjust as needed
        decoration: BoxDecoration(
          color: c,
          borderRadius: BorderRadius.circular(40), // Match rounded edges if needed
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Fit content width
          children: [
            Text(
              text,
              style: TextStyle( fontSize: 11, color: Color.fromRGBO(255, 255, 255, 1), fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    )
  );  
}
