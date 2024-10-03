import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taht_bety/core/utils/styles.dart';

class RecentState extends StatelessWidget {
  const RecentState({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent",
                style: Styles.subtitle16Bold,
              ),
              Text(
                "Clear All",
                style: Styles.text16SemiBold,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Styles.text14Medium,
                  ),
                  const Icon(
                    FontAwesomeIcons.circleXmark,
                    size: 20,
                  )
                ],
              ),
            ),
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}
