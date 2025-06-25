import 'package:flutter/material.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';

class LocationName extends StatelessWidget {
  const LocationName({
    super.key,
    required this.locationName,
  });
  final String locationName;
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
          '$locationName /n  ${UserStorage.getUserData().address}',
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
