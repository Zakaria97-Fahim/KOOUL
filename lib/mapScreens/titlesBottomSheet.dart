import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_name/widgets/buttonWithIcon.dart';
import 'package:project_name/widgets/iconButton.dart';
import 'package:project_name/widgets/iconContainer.dart';
import 'package:project_name/widgets/iconWidget.dart';
import 'package:project_name/widgets/listTileAdresse.dart';

class TitlesBottomSheet extends StatefulWidget {
  final LatLng markerPostion; // Property to hold marker position

  final Function(String, LatLng, int, bool) onDataReceived; // Callback function to pass the data back

  TitlesBottomSheet({
    required this.onDataReceived,
    required this.markerPostion,
  });

  @override
  __TitlesBottomSheetState createState() => __TitlesBottomSheetState();
}

class __TitlesBottomSheetState extends State<TitlesBottomSheet> {
  late LatLng position;

  final sheet = GlobalKey();
  final controller = DraggableScrollableController();

  /* Adds a listener to the controller to monitor changes in the sheet's scrollable size 
   and call [onChanged] whenever it changes. */
  @override
  void initState() {
    super.initState();
    // Adding a listener to the controller to detect size changes
    controller.addListener(() {});
    position = widget.markerPostion; // Use `widget.markerPostion` here

  }
  /*
    * Called whenever the DraggableScrollableSheet changes size.
    * - If the sheet size is less than or equal to 0.15, it triggers the [collapse] function.
  */
  void onChanged() {
    final currentSize = controller.size;
    if (currentSize <= 0.1) collapse();
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
      height: 500,
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('العناوين', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40)),
          SizedBox(height: 20),
          _buildTitleRow(
            //**  Button Modify */
            'تعديل',                   // Text
            Icons.mode_edit_rounded,    // button Icon
            Color.fromRGBO(51, 51, 77, 1),     // Text Color
            Color.fromRGBO(51, 51, 77, 1),     // Icon Color            
            Color.fromRGBO(203, 203, 220, 1),  // Button Background Color
            //** lsitTile : Title With Icon */
            'المنزل',                       // Title
            'App 21, Imm 265, Bd Zerkt...', // SubTitle
            Icons.home_rounded,             // leading Icon
            Color.fromRGBO(249, 249, 251, 1), // leading Icon Color
            Color.fromRGBO(51, 51, 77, 1),    // leading Icon BackgroundColor 
            (){
              widget.onDataReceived( 'House', position, 0, true); // Pass both values back
            }
          ),
          
          _buildTitleRow(
            //**  Button Modify */
            'تعديل',                   // Text
            Icons.mode_edit_rounded,    // button Icon
            Color.fromRGBO(51, 51, 77, 1),     // Text Color
            Color.fromRGBO(51, 51, 77, 1),     // Icon Color            
            Color.fromRGBO(203, 203, 220, 1),  // Button Background Color
            //** lsitTile : Title With Icon */
            'العمل',                         // Title
            'App 21, Imm 265, Bd Zerkt...',  // SubTitle
            Icons.work_outline,     // leading Icon
            Color.fromRGBO(249, 249, 251, 1), // leading Icon Color
            Color.fromRGBO(51, 51, 77, 1),    // leading Icon BackgroundColor 
            (){
              widget.onDataReceived('Job', position, 1, true); // Pass both values back
            }
          ),

          _buildTitleRow(
            //**  Button Modify */
            'تعديل',                   // Text
            Icons.mode_edit_rounded,    // button Icon
            Color.fromRGBO(51, 51, 77, 1),     // Text Color
            Color.fromRGBO(51, 51, 77, 1),     // Icon Color            
            Color.fromRGBO(203, 203, 220, 1),  // Button Background Color
            //** lsitTile : Title With Icon */
            'لوريم',                         // Title
            'App 21, Imm 265, Bd Zerkt...',  // SubTitle
            Icons.apartment_outlined,        // leading Icon
            Color.fromRGBO(51, 51, 77, 1),    // leading Icon Color
            Color.fromRGBO(234, 234, 241, 1), // leading Icon BackgroundColor 
            (){
              widget.onDataReceived('lorem', position, 2, true); // Pass both values back
            }
          ),

          _buildTitleRow(
            //**  Button Modify */
            'إضافة',      // Text
            Icons.add,    // button Icon
            Color.fromRGBO(249, 249, 251, 1),   // Text Color
            Color.fromRGBO(249, 249, 251, 1),   // Icon Color   
            Color.fromRGBO(51, 51, 77, 1),      // Button Background Color
            //** lsitTile : Title With Icon */
            'جديد',                         // Title
            'App 21, Imm 265, Bd Zerkt...', // SubTitle
            Icons.apartment_rounded,        // leading Icon
            Color.fromRGBO(51, 51, 77, 1),    // leading Icon Color
            Color.fromRGBO(234, 234, 241, 1), // leading Icon BackgroundColor 
            (){
              widget.onDataReceived('new', position, 3, true); // Pass both values back
            }
          ),                            
        ],//rgba(203, 203, 220, 1)
      ),
    );
  }
  
  Widget _buildTitleRow(text,iconBtn,textColor,iconClr,btnColor, place,address,leadingIcon,iconColor,backIconColor,onPressed){
    // Buttom With Icon
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _TitlesBottomSheet(place, address, leadingIcon, iconColor, backIconColor,onPressed) ),        
        ButtonWithIcon(
          iconData: iconBtn,
          iconColor: iconClr,
          text: text,
          textColor: textColor,
          backgroundColor: btnColor,
          onpressed: onPressed
        ),
      ],
    );
  }

  Widget _TitlesBottomSheet(place, address, leadingIcon, iconColor, backIconColor,onTap){
    return ListTileAdresse(
      // Title
      title: place,
      sizeTitle: 14,
      fontWeight: FontWeight.bold,
      // SubTitle
      subtitle: address,
      sizeSubtitle: 12,
      subtitleColor: Colors.grey,

      textAlign: TextAlign.start,
      // Leading
      iconButtonContainer: IconContainer(
        backgroundColor: backIconColor,
        iconButtonWidget: IconButtonWidget(
          iconWidget: IconWidget(iconData: leadingIcon, color: iconColor),
          onpressed: onTap,
        )
      ),
      ontap: onTap,
    );    
  }
    
  /*
    * Main build method for the TitlesBottomSheet widget
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
      initialChildSize: 0.49,
      minChildSize: 0.05,
      maxChildSize: 0.49,
      expand: true,
      snap: true,
      snapSizes: const [0.05, 0.49],
      controller: controller,
      builder: (BuildContext context, ScrollController scrollController) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
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