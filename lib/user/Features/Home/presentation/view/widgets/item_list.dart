import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/user/Features/Home/data/models/provider_list_model/provider_list_model.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/item_card.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({
    super.key,
    required this.providers,
  });
  final List<ProviderListModel> providers;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        providers.length,
        (index) => GestureDetector(
          onTap: () {
            context.push(AppRouter.kServProfile,
                extra: providers[index].userId);
          },
          child: SizedBox(
            width: 175,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              child: ItemCard(
                provider: providers[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
