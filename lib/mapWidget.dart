import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http; // For querying Google Places API
import 'dart:convert'; // For jsonDecode

import 'package:project_name/language/RTLText.dart';
import 'widgets/iconWidget.dart';
import 'widgets/headerWidget.dart';

class IntegrateMap extends StatefulWidget {
  const IntegrateMap({super.key});

  @override
  _IntegrateMapState createState() => _IntegrateMapState();
}

class _IntegrateMapState extends State<IntegrateMap> {
  // Initialize Location instance
  Location location = Location();
  LatLng initialPosition = LatLng(0, 0);

  // Completer for GoogleMapController
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  //
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = []; // List to hold search results

  // List to store markers
  List<Marker> markers = [];

  // Add a loading state to wait for location to be fetched
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  // Get user location and request necessary permissions
  Future<void> getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Check if the location service is enabled
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    // Check location permission status
    _permissionGranted = await location.hasPermission();
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
      initialPosition = LatLng(userLocation.latitude!, userLocation.longitude!);
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
    // This method queries Google Places API to search for addresses
  Future<void> searchAddress(String input) async {
    String apiKey = 'YOUR_GOOGLE_PLACES_API_KEY'; // Replace with your Google Places API Key
    String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey&types=address&language=en';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body); // Using jsonDecode after importing dart:convert
      setState(() {
        searchResults = json['predictions']; // Update search results
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RTLPage(
    child:Scaffold(  
      appBar: AppBar(title: Text("Select Delivery Address")),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show a loading indicator until location is fetched
          : Stack(
              children : [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: initialPosition, // Initially set to (0, 0) but will update when location is fetched
                  zoom: 13.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: markers.toSet(),
                myLocationEnabled: true,
                zoomControlsEnabled: true,
              ),
              Center(
                child: Container(
                height: 110, width: 256,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Card(
                  child:Row(
                      children: [
                        SizedBox(width: 10,),
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
                        SizedBox(width: 5,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('123 Main St'),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'استخدم هذه النقطة', 
                                style: TextStyle(
                                  color:Color.fromARGB(255, 29, 177, 142),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ),
                          ],
                        ), 
                      ] 
                    )
                  ),
                ),
              )
            ]
        ),
        bottomSheet: _buildBottomSheet(),
      )      
    );
  }

// Build bottom sheet containing search bar and search results
  Widget _buildBottomSheet() {
    return Container(
      height: 100,
      color: Colors.white,
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // seach Button
          ElevatedButton.icon(
            onPressed: () {
              print("Button Pressed");
            },
            icon: Icon(Icons.search, color: Colors.black,), // The rotate icon you want to display
            label: Text('بحث', style: TextStyle(color: Colors.black),), // The text next to the icon
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), 
              backgroundColor: const Color.fromARGB(1,234, 234, 241),
            ),
          ),
          // location Icon + City and neighborhood
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // City & Neighborhood
              const Directionality(
                textDirection: TextDirection.ltr, 
                child: HeaderWidget(
                  title: 'Casablanca', 
                  subtitle: 'Grand Casablanca',
                  textAlign: TextAlign.left,
                  sizeTitle: 14,
                  sizeSubtitle: 12,
                  subtitleColor: Colors.grey,
                ),
              ),
              // space
              const SizedBox(width: 10,),
              // Location Icon
              Container(
                width: 48, // Circle width
                height: 48, // Circle height
                decoration: BoxDecoration(
                  color: Colors.white, // Circle background color
                  shape: BoxShape.circle, // Makes the container circular
                  border: Border.all(color: Colors.grey, width: 1), // Thin grey border
                ),
                child: IconButton(   // location Icon Button  
                  onPressed: () {
                    Navigator.of(context).pushNamed('mapPage');
                  },
                  icon: const IconWidget(
                    size: 20,
                    iconData: Icons.location_on_outlined,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),            
    );
  }
}