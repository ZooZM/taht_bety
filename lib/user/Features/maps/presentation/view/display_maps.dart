import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taht_bety/auth/data/models/curuser.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/location_service.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/user/Features/maps/presentation/view/widgets/lower_widget_of_maps.dart';
import 'package:taht_bety/user/Features/maps/presentation/view/widgets/maps_app_bar.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/custtom_button.dart';

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
              setState(() {
                isloading = true;
                centerCoordinates = position.target;
              });
            },
            onCameraIdle: () {
              setState(() {
                isloading = false;
              });
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
                onArrowPress: () async {
                  await updateCurrentLocation();
                },
                onButtonPress: isloading
                    ? () {}
                    : () async {
                        CurUser? user = UserStorage.getUserData();

                        UserStorage.saveUserData(
                          token: user.token,
                          userId: user.userId,
                          name: user.name,
                          email: user.email,
                          photo: user.photo,
                          phoneNamber: user.phoneNamber,
                          lat: currentLocation!.latitude.toString(),
                          long: currentLocation!.longitude.toString(),
                        );
                        print(user.lat);
                        widget.voidCallbackAction();
                      },
              )),
          MapsAppBar(
            isLoading: isloading,
            onPress: isloading
                ? () {}
                : () {
                    widget.voidCallbackAction();
                  },
          ),
        ],
      ),
    );
  }

  Future<void> updateCurrentLocation() async {
    try {
      isloading = true;
      setState(() {});
      var currentLocation = await locationService.getLocation();
      var curPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      CameraPosition updatedCameraPos = CameraPosition(
        target: curPosition,
        zoom: 18.0,
      );

      isloading = false;
      mapController
          .animateCamera(CameraUpdate.newCameraPosition(updatedCameraPos));
    } on LocationEnabledException catch (e) {
      return showModalBottomSheet(
        // ignore: use_build_context_synchronously
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.26,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 26),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Log Out",
                    style: Styles.subtitle18Bold,
                  ),
                  const Flex(
                    direction: Axis.vertical,
                  ),
                  Text(
                    "$e",
                    style: Styles.text16SemiBold,
                  ),
                  const Flex(
                    direction: Axis.vertical,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flex(direction: Axis.horizontal),
                        CusttomButton(
                          isborder: true,
                          color: kWhite,
                          function: () => Navigator.pop(context),
                          title: "Cancel",
                          titleColor: kBlack,
                        ),
                        const CusttomButton(
                          isborder: false,
                          color: kOrange,
                          title: "Log out",
                          titleColor: kWhite,
                        ),
                        const Flex(direction: Axis.horizontal),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    } on LocationPremissionException catch (e) {
      print(e);
    }
  }
}
