import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:taht_bety/auth/data/models/user/user.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';

class CusttomProfileInfo extends StatelessWidget {
  const CusttomProfileInfo({
    super.key,
    required this.image,
    required this.name,
    required this.email,
  });

  final String image;
  final String name;
  final String email;
  Future<void> _fetchuser() async {
    try {
      final curUser = UserStorage.getUserData();
      final dio = Dio();
      final response = await dio.get(
        '${kBaseUrl}users/me',
        options: Options(
          headers: {'Authorization': 'Bearer ${curUser.token}'},
        ),
      );
      final userData = User.fromJson(response.data);
      UserStorage.updateUserData(
        name: userData.name,
        email: userData.email,
        photo: userData.photo,
        phoneNamber: userData.phoneNumber,
      );
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.statusCode == 401) {
          throw Exception(e.message);
        }
      }
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> _pickAndUploadImage(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        final user = UserStorage.getUserData();
        final dio = Dio();
        final formData = FormData.fromMap({
          'photo': await MultipartFile.fromFile(imageFile.path,
              filename: 'profile.jpg'),
        });

        final response = await dio.patch(
          '${kBaseUrl}users/update-me',
          data: formData,
          options: Options(
            headers: {'Authorization': 'Bearer ${user.token}'},
          ),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          await _fetchuser();
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
                    imageUrl: image,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
          name,
          style: Styles.subtitle18Bold,
        ),
        Text(
          email,
          style: Styles.text16SemiBold,
        ),
      ],
    );
  }
}
