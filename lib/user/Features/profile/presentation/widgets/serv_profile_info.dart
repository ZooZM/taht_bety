import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_profile_rate.dart';

class ServProfileInfo extends StatelessWidget {
  const ServProfileInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Arabian Carpentry",
              style: Styles.subtitle18Bold,
            ),
            SizedBox(
              width: 12,
            ),
            ServProfileRate(),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 3,
            ),
            const Icon(
              Icons.place_outlined,
              size: 30,
              color: ksecondryColor,
            ),
            const SizedBox(
              width: 6,
            ),
            Flexible(
              child: Text(
                "Street 306 - Saqr Quraish District",
                style: Styles.text14Light.copyWith(color: ksecondryColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
