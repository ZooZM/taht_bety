import 'package:flutter/material.dart';
import 'package:taht_bety/user/Features/Home/widgets/item_card.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: ItemCard(),
        ),
        childCount: 10,
      ),
    );
  }
}
