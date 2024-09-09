import 'package:flutter/material.dart';
import 'package:taht_bety/user/Features/Home/widgets/custtom_listtile.dart';
import 'package:taht_bety/user/Features/Home/widgets/custtom_profile_info.dart';
import 'package:taht_bety/user/constant/const_data.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: CusttomProfileInfo(),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: profileItems.length,
                itemBuilder: (context, index) => CustomListTile(
                    icon: profileItems[index]['icon'],
                    title: profileItems[index]['title']),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
