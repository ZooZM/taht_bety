import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/core/widgets/custom_failure_message.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/location_name.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/notification_icon.dart';
import 'package:taht_bety/user/Features/maps/presentation/view/display_maps.dart';

class HomeFailurePage extends StatelessWidget {
  const HomeFailurePage({
    super.key,
    required this.failureMssg,
    required this.icon,
  });
  final String failureMssg;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
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
                          OpenContainer(
                            closedColor: Colors.transparent,
                            closedElevation: 0,
                            closedBuilder: (context, action) =>
                                const LocationName(),
                            openBuilder: (context, action) => DisplayMaps(
                              voidCallbackAction: () => action(),
                            ),
                          )
                        ],
                      ),
                      const NotificationIcon(),
                    ],
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Icon(
                  icon,
                  size: 60,
                  color: kPrimaryColor,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: CustomFailureMessage(mess: failureMssg),
                ),
              ],
            ),
            const Flex(
              direction: Axis.vertical,
            ),
            const Flex(
              direction: Axis.vertical,
            ),
          ],
        ),
      ),
    );
  }
}
