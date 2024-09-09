import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/user/Features/Home/widgets/custtom_page_Icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Selected Index: 15'),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: kLightBlue,
        buttonBackgroundColor: kPrimaryColor,
        onTap: (value) {},
        items: const [
          CusttomPageIcon(
            icon: Icons.person_2_outlined,
          ),
          CusttomPageIcon(
            icon: Icons.home_outlined,
          ),
          CusttomPageIcon(
            icon: Icons.favorite_outline,
          ),
        ],
      ),
    );
  }
}
