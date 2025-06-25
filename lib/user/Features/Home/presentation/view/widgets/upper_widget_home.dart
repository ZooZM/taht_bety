import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/app_router.dart';
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
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Taht Bety',
                  style: Styles.projectNameStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: DeliveryToWidget(),
                ),
              ],
            ),

            // InkWell(
            //   onTap: () {
            //     context.go(AppRouter.kNotification);
            //   },
            //   child: const NotificationIcon(),
            // ),
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
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.67,
        child: Row(
          children: [
            const Icon(
              Icons.location_on,
              size: 32,
              color: kPrimaryColor,
            ),
            Expanded(
              child: Text(
                'Delivery to: \n${UserStorage.getUserData().address}',
                style: Styles.subtitle16Bold,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Icon(
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
