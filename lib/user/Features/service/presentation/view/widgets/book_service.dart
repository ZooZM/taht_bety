import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/core/widgets/custom_circular_progress.dart';

class BookService extends StatelessWidget {
  BookService(
      {super.key,
      required this.price,
      required this.onTap,
      required this.isLoading,
      this.isEnable = true});
  final String price;
  final VoidCallback onTap;
  final bool isLoading;
  bool isEnable;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? () {} : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isEnable ? ksecondryColor : kLightBlue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: isLoading
              ? const Center(
                  child: CustomCircularprogress(size: 20, color: kWhite),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.book_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    Text(
                      "Book This Appointment",
                      style: Styles.text14Light.copyWith(color: Colors.white),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
