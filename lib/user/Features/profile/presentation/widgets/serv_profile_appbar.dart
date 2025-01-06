import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/custom_icon.dart';

class ServProfileAppBar extends StatefulWidget {
  const ServProfileAppBar({
    super.key,
  });

  @override
  State<ServProfileAppBar> createState() => _ServProfileAppBarState();
}

class _ServProfileAppBarState extends State<ServProfileAppBar> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: Container(
            decoration: const BoxDecoration(
              color: kWhite,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: const CustomIcon(
              backGroundColor: kWhite,
              containerSize: 50,
              icon: Icons.arrow_back,
              iconColor: kBlack,
              iconSize: 30,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              isCheck = !isCheck;
            });
          },
          icon: Container(
            decoration: const BoxDecoration(
              color: kWhite,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: CustomIcon(
              backGroundColor: kWhite,
              containerSize: 50,
              icon: isCheck
                  ? FontAwesomeIcons.solidHeart
                  : FontAwesomeIcons.heart,
              iconColor: kBlack,
              iconSize: 30,
            ),
          ),
        )
      ],
    );
  }
}
