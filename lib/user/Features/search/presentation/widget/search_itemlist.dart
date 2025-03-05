import 'package:flutter/material.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/user/Features/Home/data/models/provider_list_model/provider_list_model.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/item_card.dart';

class SearchItemlist extends StatelessWidget {
  const SearchItemlist({super.key, required this.providers});
  final List<ProviderListModel> providers;
  @override
  Widget build(BuildContext context) {
    if (providers.isEmpty) {
      return const Center(
        child: Text(
          'No providers found.\n Try a different one!',
          style: Styles.subtitle16Bold,
        ),
      );
    } else {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: providers.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: ItemCard(provider: providers[index]),
        ),
      );
    }
  }
}
