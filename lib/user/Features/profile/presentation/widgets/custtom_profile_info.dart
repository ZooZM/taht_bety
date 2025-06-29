import 'dart:io';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/core/widgets/show_custom_choose_image_source.dart';

class CusttomProfileInfo extends StatefulWidget {
  CusttomProfileInfo({
    super.key,
    required this.image,
    required this.name,
    required this.email,
  });

  String image;
  final String name;
  final String email;

  @override
  State<CusttomProfileInfo> createState() => _CusttomProfileInfoState();
}

class _CusttomProfileInfoState extends State<CusttomProfileInfo> {
  Future<void> _pickAndUploadImage(BuildContext context) async {
    try {
      final File? pickedFile = await showCustomChooseImageSource(context);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        final bytes = await imageFile.readAsBytes();
        final base64Image = 'data:image/jpeg;base64,${base64Encode(bytes)}';
        final user = UserStorage.getUserData();
        final dio = Dio();

        final response = await dio.put(
          '${kBaseUrl}users/update-me',
          data: {
            'photo': base64Image,
          },
          options: Options(
            headers: {'Authorization': 'Bearer ${user.token}'},
          ),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          UserStorage.updateUserData(
            photo: response.data['data']['user']['photo'],
          );
          setState(() {
            widget.image = UserStorage.getUserData().photo;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Profile photo updated successfully"),
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Failed to update profile photo"),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.16,
              child: ClipOval(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: widget.image,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.person),
                  ),
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
                child: GestureDetector(
                  onTap: () {
                    _pickAndUploadImage(context);
                  },
                  child: const Icon(
                    Icons.edit_outlined,
                    color: kWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          widget.name,
          style: Styles.subtitle18Bold,
        ),
        Text(
          widget.email,
          style: Styles.text16SemiBold,
        ),
      ],
    );
  }
}
