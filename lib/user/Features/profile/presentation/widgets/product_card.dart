import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/core/widgets/custom_cushed_image.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/post.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double availableWidth = constraints.maxWidth;
        final double cardWidth =
            // availableWidth > 370 ? 350 :
            availableWidth;

        final double imageWidth = cardWidth * 0.3;
        final double imageHeight = cardWidth * 0.3;
        final double textContainerWidth = cardWidth - imageWidth - 16;

        return Container(
          width: cardWidth,
          padding: const EdgeInsets.symmetric(vertical: 16),
          height: cardWidth * 0.45,
          child: Row(
            children: [
              SizedBox(
                width: textContainerWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title!,
                      style: Styles.subtitle16Bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      post.content!,
                      style: Styles.text14Medium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      '${post.price}  EGP',
                      style: Styles.text16SemiBold,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: imageWidth,
                height: imageHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CustomCushedImage(
                      image: post.images![0],
                      height: imageHeight,
                      width: imageWidth,
                    ),
                    if (post.images!.length > 1)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black26,
                        ),
                        child: Center(
                          child: Text(
                            post.images!.length.toString(),
                            style:
                                Styles.subtitle18Bold.copyWith(color: kWhite),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
