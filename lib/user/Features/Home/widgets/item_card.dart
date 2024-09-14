import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';

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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.place_outlined,
                  size: 16,
                ),
                Text(
                  " 2 km",
                  style: Styles.text12Light,
                )
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
