import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';

class LocationName extends StatelessWidget {
  const LocationName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.place,
          size: 35,
          color: ksecondryColor,
        ),
        Text(
          'New Cairo, Cairo',
          style: Styles.subtitle18Bold.copyWith(
            color: ksecondryColor,
          ),
        ),
        const Icon(
          Icons.arrow_drop_down,
        ),
      ],
    );
  }
}
