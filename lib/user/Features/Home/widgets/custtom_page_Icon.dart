import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';

class CusttomPageIcon extends StatelessWidget {
  const CusttomPageIcon({super.key, required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 38,
      color: kWhite,
    );
  }
}
