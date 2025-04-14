import 'package:flutter/material.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/core/widgets/custom_cushed_image.dart';
import 'package:taht_bety/user/Features/Home/data/models/provider_list_model/provider_list_model.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/distance_icon.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/rating.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.provider,
  });
  final ProviderListModel provider;
  bool _checkfav(String id) {
    bool isCheck = false;
    final user = UserStorage.getUserData();
    if (user.favProviders.isNotEmpty) {
      for (var element in user.favProviders) {
        if (element == id) {
          isCheck = true;
        }
      }
      return isCheck;
    } else {
      return isCheck;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
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
            provider.photo?.isNotEmpty == true
                ? CustomCushedImage(
                    image: provider.photo!,
                    height: 0.15,
                    width: 0.34,
                    hasShadow: false,
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.34,
                    child: const Icon(
                      Icons.person,
                      size: 38,
                    ),
                  ),
            const Spacer(),
            SizedBox(
              child: Text(
                provider.name!,
                style: Styles.subtitle16Bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              provider.providerType!.split('-').last,
              style: Styles.text12Light,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  DistanceIcon(
                    distance: provider.distance!.round(),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Rating(
                        reviewCount: provider.reviewsCount!,
                        rating: (provider.avgRating?.round() ?? 0).toDouble(),
                      ),
                      Icon(
                        _checkfav(provider.userId ?? "")
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
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
