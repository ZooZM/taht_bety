import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/core/utils/styles.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ta7t Bety',
                  style: Styles.projectNameStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                DeliveryToWidget(),
              ],
            ),
            InkWell(
              onTap: () {
                context.go(AppRouter.kMainChatBot);
              },
              child: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                    'assets/images/117c96b1a51a7ed8cc29ef8120de09a1.gif'),
              ),
            ),
            InkWell(
                onTap: () {
                  context.go(AppRouter.kNotification);
                },
                child: const NotificationIcon()),
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
      ],
    );
  }
}

class DeliveryToWidget extends StatelessWidget {
  const DeliveryToWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(
          AppRouter.kMaps,
        );
      },
      child: const SizedBox(
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              size: 32,
              color: kPrimaryColor,
            ),
            Text(
              'Delivery to',
              style: Styles.subtitle18Bold,
            ),
            SizedBox(
              width: 8,
            ),
            Icon(
              Icons.my_location,
              size: 30,
              color: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
