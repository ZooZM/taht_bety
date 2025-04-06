import 'package:flutter/material.dart';
import 'package:taht_bety/core/utils/styles.dart';

class ServiceInfoWidget extends StatelessWidget {
  const ServiceInfoWidget({
    super.key,
    required this.title,
    required this.description,
    required this.price,
  });
  final String title;
  final String description;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Styles.subtitle16Bold,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$price EGP",
              style: Styles.subtitle16Bold,
            ),
          ],
        )
      ],
    );
  }
}
