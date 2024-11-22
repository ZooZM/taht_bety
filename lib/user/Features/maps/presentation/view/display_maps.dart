import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/location_service.dart';
import 'package:taht_bety/user/Features/maps/presentation/view/widgets/lower_widget_of_maps.dart';
import 'package:taht_bety/user/Features/maps/presentation/view/widgets/maps_app_bar.dart';

class DisplayMaps extends StatefulWidget {
  const DisplayMaps({super.key, required this.voidCallbackAction});
  final void Function() voidCallbackAction;
  @override
  State<DisplayMaps> createState() => _DisplayMapsState();
}

class _DisplayMapsState extends State<DisplayMaps> {
  late CameraPosition initialCameraPoistion;
  late GoogleMapController mapController;
  late LocationService locationService;
  LatLng? currentLocation;
  LatLng? centerCoordinates;
  bool isloading = true;
  @override
  void initState() {
    initialCameraPoistion =
        const CameraPosition(target: LatLng(26.820553, 30.802498), zoom: 6);
    locationService = LocationService();
    super.initState();
  }

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPoistion,
            onMapCreated: (controller) {
              mapController = controller;
              updateCurrentLocation();
            },
            onCameraMove: (position) {
              isloading = true;
              setState(() {
                centerCoordinates = position.target;
              });
            },
            onCameraIdle: () {
              isloading = false;
              currentLocation = centerCoordinates;
            },
            markers: markers,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
          ),
          const Center(
            child: IgnorePointer(
              ignoring: true,
              child: Icon(
                Icons.location_pin,
                size: 40,
                color: ksecondryColor,
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: LowerWidgetOfMaps(
                isLoading: isloading,
                onArrowPress: () {
                  updateCurrentLocation();
                  setState(() {});
                },
                onButtonPress: isloading ? () {} : widget.voidCallbackAction,
              )),
          MapsAppBar(
            onPress: widget.voidCallbackAction,
          ),
        ],
      ),
    );
  }

  Future<void> updateCurrentLocation() async {
    try {
      isloading = true;

      var currentLocation = await locationService.getLocation();
      var curPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      CameraPosition updatedCameraPos = CameraPosition(
        target: curPosition,
        zoom: 18.0,
      );

      isloading = false;
      setState(() {});
      mapController
          .animateCamera(CameraUpdate.newCameraPosition(updatedCameraPos));
    } on LocationEnabledException catch (e) {
      print(e);
    } on LocationPremissionException catch (e) {
      print(e);
    }
  }
}
