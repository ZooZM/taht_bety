import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/favorite.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/home_body.dart';
import 'package:taht_bety/user/Features/profile/presentation/user_profile.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/custtom_page_Icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 1;
  List<Widget> pages = [
    const UserProfile(),
    const HomeBody(),
    const Favorite(),
  ];
  List<bool> iconPressed = [
    false,
    true,
    false,
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
            for (int i = 0; i < iconPressed.length; i++) {
              iconPressed[i] = (i == value);
            }
          });
        },
        index: pageIndex,
        items: [
          CusttomPageIcon(
            icon: Icons.person_outline,
            isPressed: iconPressed[0],
          ),
          CusttomPageIcon(
            icon: Icons.home_outlined,
            isPressed: iconPressed[1],
          ),
          CusttomPageIcon(
            icon: Icons.favorite_outline,
            isPressed: iconPressed[2],
          ),
        ],
      ),
    );
  }
}
