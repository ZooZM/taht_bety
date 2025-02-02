import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/widgets/custom_failure_message.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          children: [
            Icon(
              icon,
              size: 60,
              color: kPrimaryColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: CustomFailureMessage(mess: failureMssg),
            ),
          ],
        ),
      ],
    );
  }
}
