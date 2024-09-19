import 'package:flutter/material.dart';
import 'package:taht_bety/core/utils/styles.dart';

class DistanceIcon extends StatelessWidget {
  const DistanceIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
          width: 3,
        ),
        Icon(
          Icons.place_outlined,
          size: 16,
        ),
        Text(
          " 2 km",
          style: Styles.text12Light,
        )
      ],
    );
  }
}
