import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/core/widgets/custom_cushed_image.dart';
import 'package:taht_bety/user/Features/Home/data/models/provider_model/post.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.post,
  });
  final Post post;
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
                Text(
                  post.title!,
                  style: Styles.subtitle16Bold,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: width > 370 ? 212 : width * 0.45,
                      child: Text(
                        post.content!,
                        style: Styles.text14Medium,
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      post.price.toString(),
                      style: Styles.text14Medium,
                    ),
                    const Text(
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
              CustomCushedImage(
                image: post.images![0],
                height: 0.1487,
                width: 0.3069,
              ),
              post.images!.length > 1
                  ? Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black26,
                      ),
                      child: Center(
                        child: Text(
                          post.images!.length.toString(),
                          style: Styles.subtitle18Bold.copyWith(color: kWhite),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          )
        ],
      ),
    );
  }
}
