import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/user/Features/Home/widgets/distance_icon.dart';
import 'package:taht_bety/user/Features/Home/widgets/rating.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.255,
      decoration: BoxDecoration(
        color: kExtraLite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: List.filled(
          1,
          const BoxShadow(
            color: Colors.black45,
            blurRadius: 7,
            offset: Offset.zero,
          ),
        ),
      ),
      child: AspectRatio(
        aspectRatio: 0.76,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 0.95,
                  child: CachedNetworkImage(
                    // color: kBlack,
                    fit: BoxFit.fill,
                    imageUrl:
                        "https://th.bing.com/th/id/OIP.RdNN9GEvTFDohpXmSeeplwHaGd?rs=1&pid=ImgDetMain",
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            const Text(
              "Family Market",
              style: Styles.subtitle16Bold,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  DistanceIcon(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Rating(),
                      Flex(direction: Axis.horizontal),
                      Icon(Icons.favorite_border),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
