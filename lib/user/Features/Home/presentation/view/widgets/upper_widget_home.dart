import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/categories_list.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/choose_location_widget.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/custtom_search_container.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/notification_icon.dart';
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
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ta7t Bety',
                  style: Styles.projectNameStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                ChooseLocationWidget()
              ],
            ),
            NotificationIcon(),
          ],
        ),
        const SizedBox(
          height: 26,
        ),
        OpenContainer(
          closedColor: Colors.transparent,
          closedElevation: 0,
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
          height: 22,
        ),
        CategoriesList(),
      ],
    );
  }
}
