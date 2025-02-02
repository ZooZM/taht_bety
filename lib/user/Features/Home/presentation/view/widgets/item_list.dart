import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/item_card.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        5,
        (index) => GestureDetector(
          onTap: () {
            context.go(AppRouter.kServProfile);
          },
          child: const SizedBox(
            width: 175,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              child: ItemCard(),
            ),
          ),
        ),
      ),
    );
  }
}
