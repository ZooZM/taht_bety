import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/custtom_button.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/custtom_listtile.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/custtom_profile_info.dart';
import 'package:taht_bety/user/constant/const_data.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CusttomProfileInfo(),
            const SizedBox(
              height: 50,
            ),
            CustomListTile(
              function: () {},
              icon: profileItems[0]['icon'],
              title: profileItems[0]['title'],
            ),
            CustomListTile(
              function: () {},
              icon: profileItems[1]['icon'],
              title: profileItems[1]['title'],
            ),
            CustomListTile(
              function: () {
                context.push(AppRouter.kOrder, extra: null);
              },
              icon: profileItems[2]['icon'],
              title: profileItems[2]['title'],
            ),
            CustomListTile(
              function: () {
                context.push(AppRouter.kHelp);
              },
              icon: profileItems[3]['icon'],
              title: profileItems[3]['title'],
            ),
            CustomListTile(
              function: () {
                context.push(AppRouter.kPrivacy);
              },
              icon: profileItems[4]['icon'],
              title: profileItems[4]['title'],
            ),
            CustomListTile(
              function: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25))),
                  builder: (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.26,
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 26),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Log Out",
                              style: Styles.subtitle18Bold,
                            ),
                            const Flex(
                              direction: Axis.vertical,
                            ),
                            const Text(
                              "Are you sure you want to log out?",
                              style: Styles.text16SemiBold,
                            ),
                            const Flex(
                              direction: Axis.vertical,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 26),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Flex(direction: Axis.horizontal),
                                  CusttomButton(
                                    isborder: true,
                                    color: kWhite,
                                    function: () => Navigator.pop(context),
                                    title: "Cancel",
                                    titleColor: kBlack,
                                  ),
                                  CusttomButton(
                                    isborder: false,
                                    color: kOrange,
                                    title: "Log out",
                                    titleColor: kWhite,
                                    function: () {
                                      UserStorage.deleteUserData();
                                      context.go('/');
                                    },
                                  ),
                                  const Flex(direction: Axis.horizontal),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: profileItems[5]['icon'],
              title: profileItems[5]['title'],
            ),
          ],
        ),
      ),
    );
  }
}
