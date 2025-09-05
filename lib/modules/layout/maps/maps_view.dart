import 'package:evently_app/modules/manager/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/color_pallette.dart';

class MapsView extends StatefulWidget {
  const MapsView({super.key});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  late AppProvider appProvider;

  @override
  void initState() {
     AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getLocation();
    appProvider.setLocationListener();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            appProvider.getLocation();
          },
      backgroundColor: ColorPallette.primaryColor,
        foregroundColor: Colors.white,
      child: Icon(Icons.gps_fixed),),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Consumer<AppProvider>(
        builder: (context, provider, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Expanded(child: GoogleMap(
              markers: provider.markers,
              initialCameraPosition: provider.cameraPosition,
            onMapCreated: (mapController) {
                provider.mapController = mapController;
            },
            mapType: MapType.normal,)
      )
          ]),
        ),
    );
  }
}
