import 'package:flutter/material.dart';
import 'package:taht_bety/user/Features/Home/presentation/widgets/item_card.dart';

class SearchItemlist extends StatelessWidget {
  const SearchItemlist({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: ItemCard(),
      ),
    );
  }
}
