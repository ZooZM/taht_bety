import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/custtom_search_container.dart';
import 'package:taht_bety/user/Features/search/presentation/search.dart';

class UpperWidgetHome extends StatefulWidget {
  const UpperWidgetHome({
    super.key,
  });

  @override
  State<UpperWidgetHome> createState() => _UpperWidgetHomeState();
}

class _UpperWidgetHomeState extends State<UpperWidgetHome> {
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
        OpenContainer(
          closedBuilder: (context, action) {
            return const CusttomSearchContainer();
          },
          openBuilder: (context, closeContainer) => Search(
            onPressFun: () {
              closeContainer();
            },
          ),
        ),
        const SizedBox(
          height: 36,
        ),
      ],
    );
  }
}