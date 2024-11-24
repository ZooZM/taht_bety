import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 150,
      width: width > 370 ? 350 : width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 114,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bedrooms",
                  style: Styles.subtitle16Bold,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: width > 370 ? 212 : width * 0.45,
                      child: const Text(
                        "consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna ",
                        style: Styles.text14Medium,
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Row(
                  children: [
                    Text(
                      "20000 - 80000",
                      style: Styles.text14Medium,
                    ),
                    Text(
                      " EGP",
                      style: Styles.text16SemiBold,
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Stack(
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    // color: kBlack,
                    fit: BoxFit.cover,
                    imageUrl:
                        "https://s3-alpha-sig.figma.com/img/814c/902a/8d92023fe7ac38baa31f6faae9b6f752?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=RIjnTa3Lqd33gY5nhkJEUNO9v7LhdbtdnEXVEoOoiaEm5mS5B1TdciDNuoBwdYs7M03SoPCo9DM6Pzom1IzSQ4XCInBd6HS2mQCOz3pq2yI1h1Om8QNV8zhrl1FmvkVqPt3GXWWgSEEFIktNKXqH4jbqzF9-oyF59XlL6WcHYGbfU1eT6qxuqO2qtwEzJTgsifuxXUPcqmyPI4lY-YlaPGMBiiT26fPY0sIz2hYamho0MiMk5x~ewe5XFGwgqpi1LDnbbfvzeM9~LlZQ4W9jm2mltLOQIOnFTloCGVGNxAW4krJW5hTCIAqMPpEmMVxFSi1wtyI30KmS71uTgFWo6A__",
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black26,
                ),
                child: Center(
                  child: Text(
                    "+20",
                    style: Styles.subtitle18Bold.copyWith(color: kWhite),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
