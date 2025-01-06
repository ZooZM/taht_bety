import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/location_name.dart';
import 'package:taht_bety/user/Features/maps/presentation/view/display_maps.dart';

class ChooseLocationWidget extends StatefulWidget {
  const ChooseLocationWidget({
    super.key,
  });

  @override
  State<ChooseLocationWidget> createState() => _ChooseLocationWidgetState();
}

class _ChooseLocationWidgetState extends State<ChooseLocationWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const LocationName(),
        OpenContainer(
          closedColor: Colors.transparent,
          closedElevation: 0,
          closedBuilder: (context, action) {
            return const Icon(Icons.add_ic_call);
          },
          openBuilder: (context, action) => DisplayMaps(
            voidCallbackAction: () => action(),
          ),
        )
      ],
    );
  }
}
