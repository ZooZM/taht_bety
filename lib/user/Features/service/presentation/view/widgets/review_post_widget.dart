import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/core/widgets/custom_cushed_image.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/review_post.dart';

class ReviewPostWidget extends StatelessWidget {
  final ReviewPost review;

  const ReviewPostWidget({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomCushedImage(
              image: review.user?.photo?.isNotEmpty == true
                  ? review.user!.photo!
                  : '',
              height: 50,
              width: 50,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              review.user?.name ?? 'Unknown User',
              style: Styles.text14Light.copyWith(
                color: ksecondryColor,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Row(
              children: List.generate(5, (starIndex) {
                return Icon(
                  starIndex >= review.rating! ? Icons.star_border : Icons.star,
                  color: ksecondryColor,
                  size: 24,
                );
              }),
            ),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          review.review ?? '',
          style: Styles.text12Light.copyWith(
            color: ksecondryColor,
          ),
          softWrap: true,
        ),
      ],
    );
  }
}
