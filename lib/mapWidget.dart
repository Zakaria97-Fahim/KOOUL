import 'package:flutter/material.dart';
import 'dart:async'; // Importing Dart's asynchronous utilities (e.g., Future, Stream, etc.)

import 'package:google_maps_flutter/google_maps_flutter.dart'; // Importing Google Maps for Flutter package to integrate Google Maps functionality
import 'package:location/location.dart'; // Importing the location package to handle fetching the user's location

import 'package:http/http.dart' as http; // For making API requests (e.g., querying the Google Places API)
import 'package:project_name/buildBottomSheet.dart';
import 'package:project_name/widgets/iconButton.dart';
import 'package:project_name/widgets/iconContainer.dart';
import 'dart:convert'; // For jsonDecode

import 'language/RTLText.dart'; 
import 'widgets/iconWidget.dart';

class IntegrateMap extends StatefulWidget {  
  @override
  _IntegrateMapState createState() => _IntegrateMapState();
}

class _IntegrateMapState extends State<IntegrateMap> {
  // Initialize Location instance
  Location location = Location();
  // initial Position at the map
  LatLng initialPosition = LatLng(0, 0);
  // Completer for GoogleMapController
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  // List to store markers
  List<Marker> markers = [];
  // Loading state to wait for location to be fetched
  bool isLoading = true;
  // Declare a nullable variable to hold the address received from addressDetails page.  
  String? displayAddress; 


  @override
  void didChangeDependencies() { 
    // Override the didChangeDependencies() method to perform tasks when widget's dependencies change (or on first load).
    super.didChangeDependencies(); 
    // Call the parent class's didChangeDependencies() to ensure proper behavior of inherited dependencies.
    final args = ModalRoute.of(context)?.settings.arguments as String; 
    // Retrieve the arguments (here, the address) passed to this screen through the route's settings.
    setState(() { 
      displayAddress = args; 
    });  
  }
  
  // Get user location and request necessary permissions
  Future<void> getUserLocation() async {
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
      // Add a marker for the user's current location on the map    
      markers.add(
        Marker(
          markerId: MarkerId('current_location'),
          position: initialPosition,
          infoWindow: InfoWindow(title: 'Your Location'),
        ),
      );
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
  // Move to the selected location on the map
  Future<void> _selectLocation(String locationName) async {
    if (locationName.isEmpty) return;
    // Google Places API key, which is used to authenticate API requests  
    String _googleApiKey = 'AIzaSyBe37FXA6dKSNbiBq_O9IclfQlFM3Ylmao'; 
    print(locationName);
    // The Google Places API endpoint for Autocomplete, with the search Input and API-key as query parameters
    final String apiUrl =
      'https://maps.googleapis.com/maps/api/geocode/json?address=$locationName&key=$_googleApiKey';

    // Make a call to your geocoding API to get coordinates for the selected description
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final lat = data['results'][0]['geometry']['location']['lat'];
      final lng = data['results'][0]['geometry']['location']['lng'];
      setState(() {
        initialPosition = LatLng(lat, lng);
      });

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(initialPosition, 13.0),
      );    
    } else {
      print('Failed to get coordinates');
    }
  }

  @override
  void initState() {
    super.initState();
    // Get user location and request necessary permissions
    getUserLocation();
  }
  


  @override
  Widget build(BuildContext context) {
    return RTLPage(     // RTLPage() is used to support Right-to-Left (RTL) languages, like Arabic.
      child:Scaffold(     
        body: isLoading  // Loading state to wait for userlocation to be fetched
          ? Center(child: CircularProgressIndicator()) // Show a loading indicator until Userlocation is fetched
          : Stack( 
            /*  Stack allows for positioning UI elements on top of each other, 
              like buttons overlayed on top of the map.
            */
            children : [
              GoogleMap(
                mapType: MapType.normal, // The map type is set to "normal" (standard map view).
                initialCameraPosition: CameraPosition(
                  target: initialPosition, // The initial camera position is centered on 'initialPosition' (set to (0, 0) until the user's location is fetched).
                  zoom: 13.0, // Initial zoom level is set to 13.0 (closer view of the map).
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller); // When the map is created, the controller is passed to _controller for future use.
                },
                markers: markers.toSet(), // Displays markers on the map, converting the markers list into a Set (which Google Maps uses).
                myLocationEnabled: false, // Enables the display of the user's current location on the map (if location permission is granted).
                zoomControlsEnabled: true, // Enables zoom controls on the map (buttons to zoom in/out).
              ),
              // IconButton "->"
              Positioned(
                top: 30, right: 20,          // position of back icon button "->" 
                child: IconContainer(            // used to have a circular Background
                  height: 48, 
                  width: 48,
                  backgroundColor: Colors.white, 
                  iconButtonWidget: IconButtonWidget(
                    iconWidget: const IconWidget(iconData: Icons.arrow_back_sharp, size: 30),
                    onpressed: (){ Navigator.pop(context); }
                  ),
                ),  
              ),
              // Position IconButon
              Positioned(
                top: 30, left: 20,           // position of position icon button  
                child: IconContainer(            // used to have a circular Background
                  height: 48, 
                  width: 48,
                  backgroundColor: Colors.white, 
                  iconButtonWidget: IconButtonWidget(
                    iconWidget: const IconWidget(iconData: Icons.my_location, size: 30),
                    onpressed: (){}
                  ),
                ),  
              ),
              // Display Current Address on Map at floating card 
              Center(
                child: Container(
                height: 110, width: 256, padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Card( // Floating card 
                  child:Row(
                      children: [
                        SizedBox(width: 10),
                        // 1st Item : Check Circle Icon
                        Container(     
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(color: Color.fromARGB(245, 229, 251, 246),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const IconWidget(
                            iconData: Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 5),
                        // Address Text
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('$displayAddress'), // the Address
                            TextButton(
                              onPressed: () {Navigator.pushNamed(context, 'addresses', arguments: initialPosition);},
                              child: const Text(
                                'استخدم هذا العنوان', 
                                style: TextStyle(
                                  fontSize: 12,fontWeight: FontWeight.w500,
                                  color:Color.fromARGB(255, 29, 177, 142),
                                ),
                              )
                            ),
                          ],
                        ), 
                      ] 
                    )
                  ),
                ),
              ),
              SearchBottomSheet(selectLocation: _selectLocation)
            ]
          )
      ),
    );
  }
}