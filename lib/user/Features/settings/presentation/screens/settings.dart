import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../profile/presentation/widgets/custtom_listtile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        appBar: AppBar(
          backgroundColor: const Color(0xffFFFFFF),
          title: const Text(
            'Settings',
            style: TextStyle(
                color: Color(0xff15243F),
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          leading: Container(
            margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 60),
            CustomListTile(
              title: "Notification Settings",
              icon: Icons.notifications_outlined,
              function: () {
                context.push(AppRouter.kNotificationSettings, extra: null);
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(height: 0.8, color: Color(0xFF99A8C2)),
            ),
            CustomListTile(
              title: "Password Manger",
              icon: Icons.key_outlined,
              function: () {
                context.push(AppRouter.kPasswordManger, extra: null);
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(height: 0.8, color: Color(0xFF99A8C2)),
            ),
            CustomListTile(
              title: "Delete Account",
              icon: Icons.delete_outline_rounded,
              function: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        iconPadding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        insetPadding: const EdgeInsets.symmetric(vertical: 10),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        actionsOverflowButtonSpacing: 10,
                        actionsAlignment: MainAxisAlignment.spaceAround,
                        alignment: Alignment.center,
                        backgroundColor: Colors.white,
                        icon: const CircleAvatar(
                          radius: 35,
                          backgroundColor: Color(0xfff9f9f9),
                          child: Icon(Icons.info_rounded,
                              color: Color(0xff99a8c2), size: 40),
                        ),
                        title: const Text(
                          'You are going to delete your account',
                          style: TextStyle(
                              fontSize: 24,
                              color: Color(0xff15243f),
                              fontWeight: FontWeight.w700),
                        ),
                        content: const Text(
                            'You won\'t be able to restore your data',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff3a4d6e),
                                fontWeight: FontWeight.w700)),
                        actions: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            height: 45,
                            minWidth: 115,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side:
                                    const BorderSide(color: Color(0xff15243f))),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Color(0xff15243f),
                              ),
                            ),
                          ),
                          MaterialButton(
                            height: 45,
                            minWidth: 115,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: const BorderSide(color: Colors.red)),
                            color: Colors.red,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      );
                    });
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(height: 0.8, color: Color(0xFF99A8C2)),
            ),
          ],
        ),
      ),
    );
  }
}
