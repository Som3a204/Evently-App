import 'package:evently_app/core/routes/page_route_name.dart';
import 'package:evently_app/core/services/snackbar_service.dart';
import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:evently_app/core/utils/firebase_firestore_utils.dart';
import 'package:evently_app/models/event_data.dart';
import 'package:evently_app/modules/event_details/widgets/date_time_card.dart';
import 'package:evently_app/modules/event_details/widgets/event_location_card.dart';
import 'package:evently_app/modules/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventDetailsView extends StatefulWidget {
  EventData eventData;
  EventDetailsView({super.key, required this.eventData});

  @override
  State<EventDetailsView> createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: ColorPallette.primaryColor,
        title: Text(
          local.edit_details,
          style: theme.textTheme.titleLarge?.copyWith(
            color: ColorPallette.primaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamed(PageRouteName.editEvent, arguments: widget.eventData);
            },
            icon: Icon(Icons.edit, color: ColorPallette.primaryColor),
          ),
          IconButton(
            onPressed: () {
              _deleteEvent(widget.eventData);
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 210,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorPallette.primaryColor),
              image: DecorationImage(
                image: AssetImage(widget.eventData.eventCategoryImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.eventData.eventTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                color: ColorPallette.primaryColor,
              ),
            ),
          ),
          DateTimeCard(dateTime: widget.eventData.selectedDate),
          EventLocationCard(
            lat: widget.eventData.lat ?? 0,
            long: widget.eventData.long ?? 0,
          ),
          Container(
            margin: EdgeInsets.all(16),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorPallette.primaryColor),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: GoogleMap(
                tiltGesturesEnabled: false,
                scrollGesturesEnabled: false,
                zoomGesturesEnabled: false,
                initialCameraPosition: CameraPosition(
                  zoom: 17,
                  target: LatLng(
                    widget.eventData.lat ?? 37.42796133580664,
                    widget.eventData.long ?? -122.085749655962,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Description", style: theme.textTheme.titleLarge),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.eventData.eventDescription,
              style: theme.textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteEvent(EventData eventData) async {
    await FirebaseFirestoreUtils.deleteEventTask(eventData: eventData);
    SnackBarService.showSuccessMessage("Event Deleted Successfully");
    Navigator.pop(context);
  }
}
