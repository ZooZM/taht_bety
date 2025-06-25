import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/core/widgets/show_custom_choose_image_source.dart';

import '../../../../constants.dart';
import 'cubit/profile_cubit.dart';
import 'widgets/editEmailDialog.dart';
import 'widgets/editNameDialog.dart';
import 'widgets/editPhoneNumberDialog.dart';

// Dark Blue

class YourProfile extends StatefulWidget {
  const YourProfile({super.key});

  @override
  State<YourProfile> createState() => _YourProfileState();
}

class _YourProfileState extends State<YourProfile> {
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
          BlocProvider.of<ProfileCubit>(context).fetchUser();
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
    BlocProvider.of<ProfileCubit>(context).fetchUser();
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 100, // Fixed top position
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is ProfileLoaded) {
                            return _buildProfileInfo(context, state.photo,
                                state.name, state.email, state.phoneNumber);
                          } else if (state is ProfileError) {
                            return Center(child: Text(state.message));
                          } else {
                            return const Center(
                                child: Text('Something went wrong'));
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kPrimaryColor,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
            onPressed: () {
              context.pop();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context, String image, String name,
      String email, String phoneNumber) {
    const double profilePictureSize = 120.0; // Fixed profile picture size
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -profilePictureSize / 1.5,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.18,
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
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: profilePictureSize / 1.2),
            child: Column(
              children: [
                _buildListTile(context, "Name", name, name, email, phoneNumber),
                _buildListTile(
                    context, "Email", email, name, email, phoneNumber),
                _buildListTile(context, "Phone Number", phoneNumber, name,
                    email, phoneNumber),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, String value,
      String name, String email, String phoneNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ListTile(
            title: Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text(value,
                style: const TextStyle(
                    color: Color(0xFF99A8C2), fontWeight: FontWeight.bold)),
            trailing: const Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.black),
            onTap: () {
              if (title == "Name") {
                showEditNameDialog(context, name, email, phoneNumber);
              }
              if (title == "Email") {
                showEditEmailDialog(context);
              }
              if (title == "Phone Number") {
                showChangePhoneDialog(context);
              }
            },
          ),
          const Divider(height: 0.8, color: Color(0xFF99A8C2)),
        ],
      ),
    );
  }
}
