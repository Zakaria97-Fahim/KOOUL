import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_name/widgets/buttonWithIcon.dart';
import 'package:project_name/widgets/iconButton.dart';
import 'package:project_name/widgets/iconContainer.dart';
import 'package:project_name/widgets/iconWidget.dart';
import 'package:project_name/widgets/listTileAdresse.dart';

class SearchBottomSheet extends StatefulWidget {
  
  final Future<void> Function(String) selectLocation; // Declare the function type  
  final Function(String) onDataReceived; // Callback function to pass the data back
  final String initialLocation; // Initial location to be displayed in the search bar

  const SearchBottomSheet({
    Key? key,
    required this.selectLocation,
    required this.onDataReceived,
    required this.initialLocation,
  }) : super(key: key);
  

  @override
  _SearchBottomSheetState createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  bool isSearch = true;
  TextEditingController searchController = TextEditingController();
  
  // List to hold search results (Places)
  List<String> searchResults = [];

  late String location; 

  /*  Fetches location suggestions from the Google Places API based on the user's input. 
    * This method takes a string input, representing the user's search query, and performs
    * an HTTP GET request to the Google Places Autocomplete API to retrieve a list of location
    * predictions. If the input is empty, the function immediately returns without making
    * an API call. Upon receiving a successful response (HTTP status code 200), it decodes the
    * JSON response and extracts the list of predicted locations. The resulting suggestions
    * are stored in the `searchResults` list, which is then used to update the UI.
    * If an error occurs during the fetch process, an error message is printed to the console.
    *
    * Parameters:
    * - [input]: The user's search query used to fetch location suggestions.
    *
    * Returns:
    * - A [Future] that completes when the suggestions have been fetched.
  */
  Future<void> _fetchSuggestions(String input) async {
    if (input.isEmpty) return;
    String _googleApiKey = 'AIzaSyBe37FXA6dKSNbiBq_O9IclfQlFM3Ylmao';
    final String apiUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$_googleApiKey&components=country:ma';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final predictions = data['predictions'] as List;
        setState(() {
          searchResults = predictions
              .map((prediction) => prediction['description'] as String)
              .toList();
        });
      } else {
        throw Exception('Failed to load suggestions');
      }
    } catch (error) {
      print('Error fetching suggestions: $error');
    }
  }

  final sheet = GlobalKey();
  final controller = DraggableScrollableController();
  /* Adds a listener to the controller to monitor changes in the sheet's scrollable size 
   and call [onChanged] whenever it changes. */
  @override
  void initState() {
    super.initState();
    location = widget.initialLocation;
    location == 'Casablanca' ? isSearch = true : isSearch = false ;
    // Adding a listener to the controller to detect size changes
    controller.addListener(() {
      if (controller.size <= 0.2) { // Threshold for detecting if the bottomsheet is minimized
        setState(() {
          isSearch = false;
        });
      }else{
        setState(() {
          isSearch = true;
        });
      }
    });
  }
  /*
    * Called whenever the DraggableScrollableSheet changes size.
    * - If the sheet size is less than or equal to 0.15, it triggers the [collapse] function.
  */
  void onChanged() {
    final currentSize = controller.size;
    if (currentSize <= 0.15) collapse();
  }
  /*
    * Animates the sheet to its smallest snap size to "collapse" it.
    * Animates the sheet to its largest snap size to position it at the "anchor" state.
    * Expands the sheet to its maximum size.
    * Hides the sheet by animating it to its minimum size.
  */
  void collapse() => animateSheet(getSheet.snapSizes!.first);
  void anchor() => animateSheet(getSheet.snapSizes!.last);
  void expand() => animateSheet(getSheet.maxChildSize);
  void hide() => animateSheet(getSheet.minChildSize);
  /*
    * Animates the sheet to a specified size.
    * - [size]: The target size to animate to.
    * - Animation duration is set to 50 milliseconds with an easing curve.
  */
  void animateSheet(double size) {
    controller.animateTo(
      size,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }
  DraggableScrollableSheet get getSheet => sheet.currentWidget as DraggableScrollableSheet;
  
  void toggleSearch() {
    setState(() {
      controller.animateTo(
        isSearch? 0.5 : 0.16, // Minimum size of the bottom sheet
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ); 
    });
  }
  //Dispose of the searchController to free up memory when this widget is removed from the widget tree
  @override
  void dispose() {    
    searchController.dispose();
    super.dispose();
  }

  /* 
    * Builds a bottom sheet widget that displays either a search interface or a button row based on 
    the current state of the 'isSearch' boolean variable. 
    * The height of the bottom sheet changes dynamically:
    * - If 'isSearch' is true, the height is set to 300 pixels, indicating the search interface is currently active.
    * - If 'isSearch' is false, the height is reduced to 100 pixels, indicating that the search interface 
    is not visible and only the button row is displayed.
    * The bottom sheet has a white background and includes padding for visual spacing.
    * Returns:
    * - A [Container] widget configured as a bottom sheet with either the search column or button row based on 
    the state.
  */
  Widget _buildBottomSheet() {
    return Container(
      height: isSearch ? 300 : 100,
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      child: isSearch ? _buildSearchColumn() : _buildButtonRow(),
    );
  }
  
  /*
    * Builds a column widget containing a search field and a list of search results.
    * This widget is used as the search interface when 'isSearch' is true, allowing users to enter text 
    to search for an address and view a list of suggestions.
    * The column contains:
      - A [TextField] for search input, styled with a custom border and prefix icon.
      - A [ListView.builder] that dynamically displays the list of suggestions if there are any otherwise, 
      it shows a "No results found" message.
    * Returns: - A [Column] widget displaying the search interface.
  */
  Widget _buildSearchColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(1, 234, 234, 241),
            hintText: 'Search for address...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
          onChanged: (query) {
            _fetchSuggestions(query); // fill searchResults from google Place API
          },
        ),
        const SizedBox(height: 10),
        // Places List
        Expanded(
          child: searchResults.isNotEmpty
            ? ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return _buildLocationInfo(searchResults[index], TextDirection.rtl);
                },
              )
            : const Center(child: Text('No results found')),
        ),
      ],
    );
  }

  /*
    * Builds a row widget containing a Search Button and Selected Location information display.
    * This widget is shown when 'isSearch' is false, providing an interface with:
    * - An Button [ElevatedButton.icon] for initiating a search, which changes the state to display  the search interface.
    * - A custom widget, [_buildLocationInfo()], which displays location-related information.
    * Returns: - A [Row] widget with evenly spaced search button and location information.
  */
  Widget _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonWithIcon(
          iconData: Icons.search,
          text: 'بحث',
          backgroundColor: Color.fromARGB(1, 234, 234, 241),
          paddingH: 24,
          paddingV: 14,
          onpressed: (){
            setState(() {
              isSearch = true; // to open the _buildSearchColumn() [the search TField and Places list]
            });
            toggleSearch();            
          },
        ),
        Expanded(child: _buildLocationInfo(location, TextDirection.ltr)),
      ],
    );
  }
  //  Location Info content : Location Name and Location Icon
  Widget _buildLocationInfo(String place, TextDirection direction) {
    // location Icon + City and neighborhood
    return ListTileAdresse(
      // Title
      title: place.isNotEmpty ? place : 'Casablanca',
      sizeTitle: 14,
      fontWeight: FontWeight.bold,
      // SubTitle
      subtitle: '',
      sizeSubtitle: 12,
      subtitleColor: Colors.grey,
      textAlign: TextAlign.start,
      direction: direction,
      // Leading
      iconButtonContainer: IconContainer(
        iconButtonWidget: IconButtonWidget(
          iconWidget: const IconWidget(iconData: Icons.location_on_outlined,),
          onpressed: ()  async { 
            await widget.selectLocation(place); 
            location = place;
            setState(() {
              isSearch = false; // hide search interface
              widget.onDataReceived(location);        
            });
            toggleSearch();
          },
        )
      ),
      // when the user select a place, the map focus on it 
      ontap: () async {  
        await widget.selectLocation(place);
        location = place;
        setState(() {
          isSearch = false; // hide search interface
          widget.onDataReceived(location);
        });
        toggleSearch();
      },
    );
  }
 
  
  /*
    * Main build method for the SearchBottomSheet widget
    * - Uses DraggableScrollableSheet to allow the user to drag it to different snap positions based on interaction.
    * - The sheet's initial size is adjusted according to `isSearch` state.
    * - Customizable snap positions allow for smooth transitions between minimized and expanded states.
    * - A DecoratedBox is used to style the DraggableScrollableSheet with rounded top corners and a white background.
    * - CustomScrollView within the sheet provides a scrollable area using `slivers`, which hold flexible layout elements.
    *   - topButtonIndicator: A flexible header in the scroll view for visual feedback.
    *   - _buildBottomSheet(): A custom widget representing the main content of the bottom sheet.
  */
  @override
  Widget build(BuildContext context) { 
    // DraggableScrollableSheet as a main component in the Stack
    return DraggableScrollableSheet(
      key: sheet,
      initialChildSize: isSearch ? 0.5 : 0.16,
      minChildSize: 0.16,
      maxChildSize: 0.5,
      expand: true,
      snap: true,
      snapSizes: const [0.16, 0.5],
      controller: controller,
      builder: (BuildContext context, ScrollController scrollController) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              topButtonIndicator(),
              SliverToBoxAdapter(
                child: _buildBottomSheet(),
              ),
            ],
          ),
        );
      },
    );
  }
}


/*
 * Creates a SliverToBoxAdapter widget that contains a styled indicator bar.
 * This widget can be used as a top button or drag indicator within a scrollable area.
 */ 
SliverToBoxAdapter topButtonIndicator() {
  return SliverToBoxAdapter(
    // This container represents the indicator bar.
    child: Container(
      decoration:  BoxDecoration(
        // borderRadius: BorderRadius.horizontal(right: Radius.circular(20) ,left: Radius.circular(20)),
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: Center(
        child: Wrap(
          children: <Widget>[
            Container(
              width: 100,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              height: 5,
              decoration: const BoxDecoration(
                color: Colors.black45,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}