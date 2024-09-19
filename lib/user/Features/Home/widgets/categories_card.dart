import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({
    super.key,
    required this.title,
    required this.isCheck,
  });
  final String title;
  final bool isCheck;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isCheck ? kPrimaryColor : kLightBlue,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
        child: Center(
          child: Text(
            title,
            style: Styles.subtitle16Bold
                .copyWith(color: isCheck ? kWhite : kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
