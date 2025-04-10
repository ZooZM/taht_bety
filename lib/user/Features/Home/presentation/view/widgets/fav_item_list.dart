import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/user/Features/Home/data/models/fav_provider_model.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/fav_item_card.dart';

class FavItemList extends StatelessWidget {
  const FavItemList({
    super.key,
    required this.providers,
  });
  final List<FavProviderModel> providers;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        providers.length,
        (index) => GestureDetector(
          onTap: () {
            context.push(AppRouter.kServProfile, extra: providers[index].id);
          },
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: FavItemCard(
                provider: providers[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
