import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';

class CusttomProfileInfo extends StatelessWidget {
  const CusttomProfileInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.16,
              child: ClipOval(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    // color: kBlack,
                    fit: BoxFit.fill,
                    imageUrl:
                        "https://nuitems/Tower__Beef_Meal_512_x_51638253721632353982.png?width=172&height=172",
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kWhite,
                    width: 2,
                  ),
                  color: ksecondryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  color: kWhite,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          "Zeyad Mostafa",
          style: Styles.subtitle18Bold,
        ),
        const Text(
          "zeyadmostafa201@gmail.com",
          style: Styles.text16SemiBold,
        ),
      ],
    );
  }
}
