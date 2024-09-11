import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/user/Features/Home/favorite.dart';
import 'package:taht_bety/user/Features/Home/home.dart';
import 'package:taht_bety/user/Features/Home/profile.dart';
import 'package:taht_bety/user/Features/Home/widgets/custtom_page_Icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 1;
  List pages = [
    const Profile(),
    const Home(),
    const Favorite(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: kLightBlue,
        buttonBackgroundColor: kPrimaryColor,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        index: pageIndex,
        items: const [
          CusttomPageIcon(
            icon: Icons.person_outlined,
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
