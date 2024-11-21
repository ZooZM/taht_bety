import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taht_bety/core/utils/location_service.dart';

class DisplayMaps extends StatefulWidget {
  const DisplayMaps({super.key});

  @override
  State<DisplayMaps> createState() => _DisplayMapsState();
}

class _DisplayMapsState extends State<DisplayMaps> {
  late CameraPosition initialCameraPoistion;
  late GoogleMapController mapController;
  late LocationService locationService;
  late TextEditingController textEditingController;
  @override
  void initState() {
    initialCameraPoistion = const CameraPosition(target: LatLng(0, 0));
    locationService = LocationService();
    textEditingController = TextEditingController();
    super.initState();
  }

  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: initialCameraPoistion,
          onMapCreated: (controller) {
            mapController = controller;
            updateCurrentLocation();
          },
          markers: markers,
        ),
      ],
    );
  }

  Future<void> updateCurrentLocation() async {
    try {
      var currentLocation = await locationService.getLocation();
      var curPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      CameraPosition updatedCameraPos = CameraPosition(
        target: curPosition,
        zoom: 15.0,
      );
      Marker curMarker = Marker(
        markerId: const MarkerId('value'),
        position: curPosition,
      );
      markers.add(curMarker);
      setState(() {});
      mapController
          .animateCamera(CameraUpdate.newCameraPosition(updatedCameraPos));
    } on LocationEnabledException catch (e) {
      // ignore: avoid_print
      print(e);
    } on LocationPremissionException catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
