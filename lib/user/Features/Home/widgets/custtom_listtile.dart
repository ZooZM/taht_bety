import 'package:flutter/material.dart';
import 'package:taht_bety/core/utils/styles.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
  });
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Icon(
        icon,
        size: 25,
      ),
      title: Text(
        title,
        style: Styles.subtitle16Bold,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 25,
      ),
    );
  }
}
