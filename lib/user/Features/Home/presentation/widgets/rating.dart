import 'package:flutter/material.dart';
import 'package:taht_bety/core/utils/styles.dart';

class Rating extends StatelessWidget {
  const Rating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.star_rounded,
          color: Color(0xFFFF9633),
          size: 24,
        ),
        Text(
          "4.9 ",
          style: Styles.text14Medium,
        ),
        Text(
          "(+100)",
          style: Styles.text12Light,
        ),
      ],
    );
  }
}
