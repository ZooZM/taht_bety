import 'package:flutter/material.dart';
import 'package:taht_bety/core/utils/styles.dart';

class DistanceIcon extends StatelessWidget {
  const DistanceIcon({
    super.key,
    required this.distance,
  });
  final int distance;
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 3,
        ),
        const Icon(
          Icons.place_outlined,
          size: 16,
        ),
        Text(
          " $distance km",
          style: Styles.text12Light,
        )
      ],
    );
  }
}
