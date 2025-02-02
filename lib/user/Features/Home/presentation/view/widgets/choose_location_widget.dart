import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/location_name.dart';
import 'package:taht_bety/user/Features/Home/presentation/view_model/providers_cubit/providers_cubit.dart';
import 'package:taht_bety/user/Features/maps/presentation/view/display_maps.dart';

List userLocations = [
  "Home",
  "Work",
  "School",
  "Park",
  "Gym",
  "Current",
];

class ChooseLocationWidget extends StatefulWidget {
  const ChooseLocationWidget({
    super.key,
  });

  @override
  State<ChooseLocationWidget> createState() => _ChooseLocationWidgetState();
}

class _ChooseLocationWidgetState extends State<ChooseLocationWidget> {
  String selectedLocation = userLocations[0];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PopupMenuButton<String>(
          padding: EdgeInsets.zero,
          onSelected: (value) {
            setState(() {
              selectedLocation = value;
            });
            context.read<ProvidersCubit>().fetchProviderList();
          },
          itemBuilder: (context) {
            return userLocations.map(
              (location) {
                return PopupMenuItem<String>(
                  value: location,
                  padding: EdgeInsets.zero,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: (selectedLocation == location)
                          ? ksecondryColor
                          : Colors.transparent,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Text(
                      location,
                      style: Styles.text14Light.copyWith(
                        color: (selectedLocation == location) ? kWhite : kBlack,
                      ),
                    ),
                  ),
                );
              },
            ).toList();
          },
          child: LocationName(
            locationName: selectedLocation,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        OpenContainer(
          closedColor: Colors.transparent,
          closedElevation: 0,
          closedBuilder: (context, action) {
            return const Icon(
              Icons.my_location,
              size: 30,
              color: kPrimaryColor,
            );
          },
          openBuilder: (context, action) => DisplayMaps(
            voidCallbackAction: () => action(),
          ),
        )
      ],
    );
  }
}
