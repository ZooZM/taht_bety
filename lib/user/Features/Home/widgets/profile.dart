import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: CusttomProfileInfo(),
            ),
          ],
        ),
      ),
    );
  }
}

class CusttomProfileInfo extends StatelessWidget {
  const CusttomProfileInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/images/OIP.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kWhite,
                    width: 2,
                  ),
                  color: ksecondryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  color: kWhite,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          "Zeyad Mostafa",
          style: Styles.subtitle18Bold,
        ),
        const Text(
          "zeyadmostafa201@gmail.com",
          style: Styles.text16SemiBold,
        ),
      ],
    );
  }
}
