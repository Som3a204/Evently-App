import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:evently_app/modules/manager/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PickEventLocationView extends StatefulWidget {
  const PickEventLocationView({super.key});

  @override
  State<PickEventLocationView> createState() => _PickEventLocationViewState();
}

class _PickEventLocationViewState extends State<PickEventLocationView> {
  late AppProvider appProvider;

  @override
  void initState() {
    appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getLocation();
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<AppProvider>(
      builder: (context, provider, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: GoogleMap(
                  onTap: (location){
                    appProvider.setEventLocation(location);
                    Navigator.pop(context);
                  },
                  markers: provider.markers,
                  initialCameraPosition: provider.cameraPosition,
                  onMapCreated: (mapController) {
                    provider.mapController = mapController;
                  },
                  mapType: MapType.normal,)),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: ColorPallette.primaryColor
                  ),
                  child: Text("Tap on Location to select", style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white
                  ),
                  ),
                )
              ]
      ),
    );
  }
}
