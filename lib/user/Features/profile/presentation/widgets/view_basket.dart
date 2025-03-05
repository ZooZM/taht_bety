import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/core/widgets/custom_circular_progress.dart';

class ViewBasket extends StatelessWidget {
  const ViewBasket(
      {super.key,
      required this.price,
      required this.onTap,
      required this.isLoading,
      required this.count});
  final String price;
  final VoidCallback onTap;
  final bool isLoading;
  final int count;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? () {} : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ksecondryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: isLoading
              ? const Center(
                  child: CustomCircularprogress(size: 20, color: kWhite),
                )
              : Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 1),
                        child: Text(
                          "$count",
                          style: Styles.text14Light
                              .copyWith(color: ksecondryColor),
                        ),
                      ),
                    ),
                    Text(
                      " View basket",
                      style: Styles.text14Light.copyWith(color: Colors.white),
                    ),
                    const Spacer(),
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
