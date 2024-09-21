import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';

class UpperWidgetHome extends StatelessWidget {
  const UpperWidgetHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ta7t Bety',
                  style: Styles.projectNameStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.place,
                      size: 35,
                      color: ksecondryColor,
                    ),
                    Text(
                      'New Cairo, Cairo',
                      style: Styles.subtitle18Bold.copyWith(
                        color: ksecondryColor,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              children: [
                const Icon(
                  FontAwesomeIcons.bell,
                  size: 44,
                ),
                Positioned(
                  top: 0,
                  right: 6,
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: kExtraLite,
                    ),
                    child: const Center(
                      child: Text(
                        "3",
                        style: Styles.text14Medium,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 26,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.876,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(16),
            boxShadow: List.filled(
              1,
              const BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset.zero,
              ),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              const Icon(
                FontAwesomeIcons.magnifyingGlass,
                size: 24,
                color: kPrimaryColor,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                "Search",
                style: Styles.subtitle16Bold.copyWith(color: ksecondryColor),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 36,
        ),
      ],
    );
  }
}
