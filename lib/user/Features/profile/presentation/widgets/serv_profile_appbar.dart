import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/custom_icon.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';

class ServProfileAppBar extends StatefulWidget {
  const ServProfileAppBar({
    super.key,
    required this.providerID,
  });
  final String providerID;

  @override
  State<ServProfileAppBar> createState() => _ServProfileAppBarState();
}

class _ServProfileAppBarState extends State<ServProfileAppBar> {
  bool isCheck = false;
  bool isLoading = false;
  bool _checkfav(String id) {
    final user = UserStorage.getUserData();
    if (user.favProviders.isNotEmpty) {
      return user.favProviders.contains(id);
    } else {
      return false;
    }
  }

  @override
  void initState() {
    isCheck = _checkfav(widget.providerID);
    super.initState();
  }

  Future<void> _toggleFavorite() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = UserStorage.getUserData();
      final dio = Dio();

      final updatedFavorites = user.favProviders;
      if (isCheck) {
        updatedFavorites.remove(widget.providerID);
      } else {
        updatedFavorites.add(widget.providerID);
      }

      final response = await dio.patch(
        '${kBaseUrl}users/update-me',
        data: {
          'favoriteProviders': updatedFavorites,
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${user.token}'},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          isCheck = !isCheck;
        });

        UserStorage.updateUserData(
          favProviders: updatedFavorites,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isCheck
                  ? "Added to favorites successfully"
                  : "Removed from favorites successfully",
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to update favorites"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          duration: const Duration(seconds: 3),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            context.pop();
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
          onPressed: isLoading
              ? null
              : () {
                  _toggleFavorite();
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
              iconColor: isCheck ? Colors.red : kBlack,
              iconSize: 30,
            ),
          ),
        )
      ],
    );
  }
}
