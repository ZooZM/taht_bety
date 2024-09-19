import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/user/Features/Home/widgets/item_card.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: kPrimaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                boxShadow: List.filled(
                  1,
                  const BoxShadow(
                    color: Colors.black45,
                    blurRadius: 7,
                    offset: Offset.zero,
                  ),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  "All",
                  style: Styles.subtitle16Bold.copyWith(color: kWhite),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: kLightBlue,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                boxShadow: List.filled(
                  1,
                  const BoxShadow(
                    color: Colors.black45,
                    blurRadius: 7,
                    offset: Offset.zero,
                  ),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  "Restaurant",
                  style: Styles.subtitle16Bold.copyWith(color: kPrimaryColor),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: ItemCard(),
            ),
          ),
        )
      ],
    );
  }
}
