import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key, required this.cartCount});
  final int cartCount;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Icon(
          Icons.shopping_cart_outlined,
          size: 36,
          color: kPrimaryColor,
        ),
        Positioned(
          top: 0,
          right: 1,
          child: Container(
            height: 16,
            width: 16,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: kExtraLite,
            ),
            child: Center(
              child: Text(
                "$cartCount",
                style: Styles.text12Light,
              ),
            ),
          ),
        )
      ],
    );
  }
}
