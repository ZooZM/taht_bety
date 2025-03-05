import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';

class AddToBasketWidget extends StatelessWidget {
  const AddToBasketWidget({super.key, required this.price});
  final String price;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: ksecondryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Add to basket",
                style: Styles.text14Light.copyWith(color: Colors.white),
              ),
              Text(
                "$price.00EGP",
                style: Styles.text14Light.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
