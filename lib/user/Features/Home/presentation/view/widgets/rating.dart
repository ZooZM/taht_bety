import 'package:flutter/material.dart';
import 'package:taht_bety/core/utils/styles.dart';

class Rating extends StatelessWidget {
  const Rating({
    super.key,
    required this.reviewCount,
    required this.rating,
  });
  final int reviewCount;
  final double rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star_rounded,
          color: Color(0xFFFF9633),
          size: 24,
        ),
        Text(
          "${rating.round()} ",
          style: Styles.text14Medium,
        ),
        Text(
          "($reviewCount)",
          style: Styles.text12Light,
        ),
      ],
    );
  }
}
