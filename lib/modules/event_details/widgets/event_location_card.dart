import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class EventLocationCard extends StatefulWidget {
   EventLocationCard({super.key, required this.lat, required this.long});
double lat;
double long;

  @override
  State<EventLocationCard> createState() => _EventLocationCardState();
}

class _EventLocationCardState extends State<EventLocationCard> {
  String locationMessage = 'no location data found';
  @override
  void initState() {
    _getLocation();
  }
  Future<void> _getLocation() async{
    List<Placemark> placemarks = await placemarkFromCoordinates(widget.lat, widget.long);
    try {
      if(placemarks.isNotEmpty){
        Placemark placemark = placemarks[0];
        locationMessage = '${placemark.country}, ${placemark.locality}';
        setState(() {
        });
      }
      else{
        setState(() {
        });
        locationMessage = 'Location not found';
      }
    } catch (e) {
      locationMessage = '$e';
    }
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ColorPallette.primaryColor)
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: ColorPallette.primaryColor,
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Icon(Icons.gps_fixed,color: Colors.white,),
            ),
            SizedBox(width: 8),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locationMessage, style: theme.textTheme.titleSmall!.copyWith(
                  color: ColorPallette.primaryColor
                )),
              ],
            ))
          ],
        ),
      ),
    );
  }

}

