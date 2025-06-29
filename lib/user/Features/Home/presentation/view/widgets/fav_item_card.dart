import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/core/widgets/custom_cushed_image.dart';
import 'package:taht_bety/user/Features/Home/data/models/fav_provider_model.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/distance_icon.dart';

class FavItemCard extends StatelessWidget {
  const FavItemCard({
    super.key,
    required this.provider,
  });

  final FavProviderModel provider;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.17,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kExtraLite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  CustomCushedImage(
                    image: provider.imageUrl,
                    height: double.infinity,
                    width: screenWidth * 0.25,
                    hasShadow: false,
                    isImage: false,
                  ),
                  (provider.isOnline)
                      ? const SizedBox()
                      : Container(
                          height: double.infinity,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: Colors.black12,
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
                          child: Center(
                            child: Text(
                              'Busy',
                              style: Styles.subtitle18Bold.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.name,
                      style: Styles.subtitle16Bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      provider.providerType.split('-').last,
                      style: Styles.text12Light,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    DistanceIcon(
                      distance: provider.distance.round(),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          "${provider.avgRating.round()}",
                          style: Styles.text12Light
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "(${provider.reviewsCount})",
                          style: Styles.text12Light,
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.favorite,
                          color: kPrimaryColor,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
