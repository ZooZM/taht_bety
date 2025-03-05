import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';

class TotalBill extends StatelessWidget {
  final int totalBill;

  const TotalBill({
    super.key,
    required this.totalBill,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Text("Total bill ", style: Styles.text14Light),
              Text(
                "$totalBill EGP",
                style: Styles.subtitle16Bold.copyWith(color: ksecondryColor),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: ksecondryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  Text("Place order",
                      style: Styles.text14Light.copyWith(color: kWhite)),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: kWhite,
                    size: 12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
