import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:project_name/language/RTLText.dart';
import 'package:project_name/mapScreens/searchBottomSheet.dart';
import 'package:project_name/mapScreens/titlesBottomSheet.dart';
import 'package:project_name/widgets/iconButton.dart';
import 'package:project_name/widgets/iconContainer.dart';
import 'package:project_name/widgets/iconWidget.dart';


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Marker Image
  List<String> images = [
    'assets/images/mapIcons/homeMarker.png',
    'assets/images/mapIcons/jobMarker.png',
    'assets/images/mapIcons/Maybe.png',
    'assets/images/mapIcons/marker.png',
  ];
  // List of cities where delivery is available
  List<Map<String, dynamic>> cities = [
    {'name': 'Casablanca', 'latitude_min': 33.5, 'latitude_max': 33.7, 'longitude_min': -7.8, 'longitude_max': -7.3},
    {'name': 'Rabat',      'latitude_min': 34.0, 'latitude_max': 34.1, 'longitude_min': -6.8, 'longitude_max': -6.7},
    {'name': 'Oujda',      'latitude_min': 34.7, 'latitude_max': 34.8, 'longitude_min': -1.9, 'longitude_max': -1.8},
    {'name': 'Marrakech',  'latitude_min': 31.6, 'latitude_max': 31.7, 'longitude_min': -8.0, 'longitude_max': -7.9},
    {'name': 'Agadir',     'latitude_min': 30.4, 'latitude_max': 30.5, 'longitude_min': -9.5, 'longitude_max': -9.4},
    {'name': 'El Jadida',  'latitude_min': 33.2, 'latitude_max': 33.3, 'longitude_min': -8.5, 'longitude_max': -8.4},
    {'name': 'Khouribga',  'latitude_min': 32.85, 'latitude_max': 32.91, 'longitude_min': -6.95, 'longitude_max': -6.88},
    {'name': 'Tanger',     'latitude_min': 35.7, 'latitude_max': 35.8, 'longitude_min': -5.9, 'longitude_max': -5.8},
    {'name': 'Hoceima',    'latitude_min': 35.2, 'latitude_max': 35.3, 'longitude_min': -3.9, 'longitude_max': -3.8},
    {'name': 'Al Aayoune', 'latitude_min': 27.1, 'latitude_max': 27.2, 'longitude_min': -13.2, 'longitude_max': -13.1},
    {'name': 'Dakhla',     'latitude_min': 23.7, 'latitude_max': 23.8, 'longitude_min': -15.9, 'longitude_max': -15.8},
    {'name': 'Kenitra',    'latitude_min': 34.2, 'latitude_max': 34.3, 'longitude_min': -6.6, 'longitude_max': -6.5},
    {'name': 'Fes',        'latitude_min': 34.0, 'latitude_max': 34.1, 'longitude_min': -5.0, 'longitude_max': -4.9},
  ];  
  // Google Api Key for Google Map
  final String _googleApiKey = 'AIzaSyBe37FXA6dKSNbiBq_O9IclfQlFM3Ylmao'; 
  // Initialize Location instance
  Location location = Location();
  // Completer for GoogleMapController
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  LatLng initialPosition = LatLng(34.020882, -6.841650); // Rabat, Morocco

  Set<Marker> _markers = {};
  BitmapDescriptor? _customIcon;
  bool _showCard = false;

  String city = 'Casablanca';
  String markerAddress = '';
  String idMarker = 'empty';

  double currentZoom = 0.0;
  bool isInsideCities = false;
          

  // If user Select a Delivery Place
  bool isDeliveryPlaceSelected = false;
  // Loading state to wait for location to be fetched
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _loadCustomMarker();
  }

  // Load Center Marker
  void _loadCustomMarker() async {
    _customIcon = await _createCustomMarker(images[3]); // Maybe Icon
    _addMarker('centerMarker', _customIcon!);
    _updateMarker();
  }
  
  // update the Place of the Center Marker at the Map
  void _updateMarker() {
    final Marker? centerMarker = _markers.firstWhere(
      (marker) => marker.markerId == MarkerId('centerMarker')                    
    );
    if (centerMarker != null ){
      setState(() {
        _markers.remove(centerMarker); // Remove the old marker
        _currentZoom();
        _addMarker('centerMarker', _customIcon!);
      });
    }
  }

  // add Delivery Marker
  void __buildDeliveryMarker(String idMarker, LatLng markerPosition, int i) async{
    BitmapDescriptor image = await _createCustomMarker(images[i]); 
    setState(() {
      _addMarker(idMarker, image);
    });
  }
  
  // Add New Marker
  void _addMarker(String markerID, BitmapDescriptor _customIcon){
    _markers.add(
      Marker(
        markerId: MarkerId(markerID),
        position: initialPosition,
        icon: _customIcon,
        infoWindow: InfoWindow.noText, // Remove the infoWindow
        onTap: markerID == 'centerMarker' ? (){} : () {
          // Fetch the address of the marker (replace this with your address fetching logic)
          String address =  markerAddress;
          // Navigate to the HomePage and pass the address
          Navigator.of(context).pushNamed('home', arguments: { 'address': address, 'id': markerID });
        },
      ),
    );
  }

  // Function to get the current zoom level
  void _currentZoom() async {
    currentZoom = await _getCurrentZoomLevel(); // Await the future
  }

  // Control the Size of the Marker
  Future<BitmapDescriptor> _createCustomMarker(String image) async {
    final ByteData data = await rootBundle.load(image);
    final ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 60, targetHeight: 90);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final Uint8List resizedMarker = (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(resizedMarker);
  }

  // Function to get the current zoom level using _controller
  Future<double> _getCurrentZoomLevel() async {
    final GoogleMapController controller = await _controller.future;
    return await controller.getZoomLevel();
  }



  // get the Current Address of the Marker
  Future<void> _getAddressFromLatLng(LatLng position) async {
    final String apiUrl = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$_googleApiKey';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        markerAddress = data['results'][0]['formatted_address'];
      });
    }
  }

  // get the LatLang of Place searched by User
  Future<void> _searchedPalce(String locationName) async {
    if (locationName.isEmpty) return;
    final String apiUrl = 'https://maps.googleapis.com/maps/api/geocode/json?address=$locationName&key=$_googleApiKey';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'].isNotEmpty) {
        final lat = data['results'][0]['geometry']['location']['lat'];
        final lng = data['results'][0]['geometry']['location']['lng'];
        setState(() {
          initialPosition = LatLng(lat, lng);
        });
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newLatLngZoom(initialPosition, 13.0));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No results found for $locationName')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to get coordinates')));
    }
  }
  
  // Get user location and request necessary permissions
  Future<void> _getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    // Check if the location service is enabled
    _serviceEnabled = await location.serviceEnabled();
    // If the location service is not enabled, request to enable it
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    // Check location permission status
    _permissionGranted = await location.hasPermission();
    // If permission is denied, request for permission
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    // Get user location
    var userLocation = await location.getLocation();
    // Update the UI with the user location and stop loading
    setState(() {
      // Set the initial position to the user's current location
      initialPosition = LatLng(userLocation.latitude!, userLocation.longitude!);   
      isLoading = false;
    });
    // Move the camera to the user's current location
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: initialPosition,
          zoom: 13.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    isInsideCities = isInsideCity(
      initialPosition.latitude,
      initialPosition.longitude,
      cities
    );
    return RTLPage(child: Scaffold(
      body: isLoading  // Loading state to wait for userlocation to be fetched
      ? Center(child: CircularProgressIndicator()) // Show a loading indicator until Userlocation is fetched
      : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: initialPosition,
              zoom: 13,
            ),
            onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
            },
            markers: _markers,
            myLocationEnabled: true, // Shows the blue dot
            myLocationButtonEnabled: true,
            //polylines: _polylines,
            onCameraMove: (CameraPosition position) {
              setState(() {
                initialPosition = position.target;
                _updateMarker();
                _showCard = false;
              });
            },
            onCameraIdle: () {
              setState(() {
                _showCard = true; // Show the card when scrolling stops
                _updateMarker();
                _getAddressFromLatLng(initialPosition);
              });
            },
          ),
          // IconButton "->"
          Positioned(
            top: 30, right: 20, // position of back icon button "->" 
            child: _iconContainer(
              Icons.arrow_back_sharp,
              (){ Navigator.pop(context); } // comeBack to last Screen
            ), 
          ),
          // Position IconButon
          Positioned(
            top: 30, left: 20, // position of position icon button  
            child: _iconContainer(  
              Icons.my_location,
              (){ _getUserLocation(); } 
            ),  
          ),
          // Show the card on top of the marker if _showCard is true
          if (_showCard)
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.5 + 31 , // Adjust to marker position
              left: MediaQuery.of(context).size.width * 0.5 - (256/2)  , // Adjust to marker position
              right: MediaQuery.of(context).size.width * 0.5 - (256/2) , // Adjust to marker position
              child: cardWindow(
                floatingCardWithPointer(
                  _floatingCard(   
                    _cardAddress(
                      markerAddress, // Current Adress Marker 
                        // Card TextButton : استخدم هذا العنوان 
                      _cardTextButton(  
                        () {
                          setState(() {
                            isDeliveryPlaceSelected = true;
                          });
                        },                              
                        isInsideCities
                      ), 
                      isInsideCities,
                    ),
                    _cardImage(isInsideCities)
                  )
                ),
              ), // Display card above the marker
            ),

          // if the User select a delivery place
          isDeliveryPlaceSelected 
          ?
          // Decide the Title of the Selected Place
          TitlesBottomSheet(
            onDataReceived: (idMarker, position, int, isDone) {
              __buildDeliveryMarker(idMarker, position, int);
              isDeliveryPlaceSelected = !isDone;
            },
            markerPostion: initialPosition, 
          )
          :
          // Bottom sheet to Seach new Place 
          SearchBottomSheet(
            selectLocation: _searchedPalce, 
            onDataReceived: (place){city = place;}, 
            initialLocation: city) 
        ],
      ),
    ));
  }
}

Widget cardWindow(Widget floatingCardWithPointer) {
  return Container(
    constraints: const BoxConstraints(
      maxWidth: 256, // Set maximum width for the card
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        floatingCardWithPointer
      ],
    ),
  );
}


// Combined Floating Card with Pointer Triangle
Widget floatingCardWithPointer(Widget floatingCard) {
  return Stack(
    alignment: Alignment.topCenter,
    children: [
      // Column containing both the card and pointer
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          floatingCard, // Floating Card
          const SizedBox(height: 10),  // Small space between card and pointer
          _pointerTriangle(),  
          const SizedBox(height: 4,)       // Pointer Triangle directly below card
        ],
      ),
    ],
  );
}
// Floating Card Current Address
Widget _floatingCard(Widget cardAddress, Widget cardImage) {
  return Card(
    margin: EdgeInsets.zero,
    elevation: 3, // Adds a shadow effect to the card
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Card corner radius
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          // 1st Item: Icon in a styled container
          cardImage,
          const SizedBox(width: 10), // Space between icon and address
          // 2nd Item: Address text and button column
          Expanded(
            child: cardAddress,
          ),
        ],
      ),
    ),
  );
}

// Icon of the Place Delivery, 'YES' or 'NO' images
Widget _cardImage(bool isInsideCity){
  String image = 'assets/images/mapIcons/No.png';
  Color color = Color.fromRGBO(255, 245, 245, 1);
  if(isInsideCity){
    image = 'assets/images/mapIcons/Yes.png';
    color = Color.fromARGB(245, 229, 251, 246);
  }
  return Container(     
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    // Card Icon Yes  
    child: IconWidget(
      imagePath: image,
      sizeW: 24, sizeH: 24,
    ),
  );
}

// display Marker current Address if is Inside City
Widget _cardAddress(String? displayAddress, Widget cardTextButton, bool isInsideCity){
  String text = 'خارج منطقة التسليم';
  if (isInsideCity) {
    text = displayAddress ?? 'Loading address...';
  } 
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text( text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700), ), // Current Marker Address
      cardTextButton // TextButton : استخدم هذا العنوان
    ],
  ); 
}

// Text Button open Titles Bottom Sheet
Widget _cardTextButton(VoidCallback onPressed, bool isInsideCity){
  String text = 'لا يمكننا تسليم هنا';
  Color color = Color.fromRGBO(114, 114, 161, 1);
  VoidCallback onpressed = (){};
  if (isInsideCity) {
    text = 'استخدم هذا العنوان';
    color = Color.fromARGB(255, 29, 177, 142);
    onpressed = onPressed;
  }  
  return TextButton(
    onPressed: onpressed,
    child: Text(
      text, 
      style: TextStyle( fontSize: 12, fontWeight: FontWeight.w500, color: color ),
    ), 
  );
}

// Pointer Triangle of the Card
Widget _pointerTriangle() {
  return Container(
    width: 0, // Zero width for proper triangle shape
    height: 0, // Zero height for proper triangle shape
    decoration: const BoxDecoration(
      border: Border(
        left: BorderSide(width: 10, color: Colors.transparent),
        right: BorderSide(width: 10, color: Colors.transparent),
        bottom: BorderSide(width: 10, color: Colors.white), // Bottom border is the triangle color
      ),
    ),
  );
}

// Check if the Marker is Inside Cities
bool isInsideCity(double markerLat, double markerLng, List<Map<String, dynamic>> cities) {
  for (var city in cities) {
    // If the marker is within the city's bounding box
    if (markerLat >= city['latitude_min'] &&
        markerLat <= city['latitude_max'] &&
        markerLng >= city['longitude_min'] &&
        markerLng <= city['longitude_max']) 
    {
      return true; // Marker is inside this city
    }
  }
  return false; // Marker is not inside any city
}

// this function used for : '->' back and location Icons 
Widget _iconContainer(IconData icon, VoidCallback onPressed){
  return IconContainer(  // used to have a circular Background
    height: 48, width: 48,
    backgroundColor: Colors.white, 
    iconButtonWidget: IconButtonWidget(
      iconWidget: IconWidget(iconData: icon, size: 30),
      onpressed: onPressed,
    ),
  );
}





