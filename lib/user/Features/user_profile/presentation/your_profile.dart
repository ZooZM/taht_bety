import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import 'cubit/profile_cubit.dart';
import 'widgets/editEmailDialog.dart';
import 'widgets/editNameDialog.dart';
import 'widgets/editPhoneNumberDialog.dart';

 // Dark Blue

class YourProfile extends StatelessWidget {
  const YourProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ProfileCubit()..fetchUser(),
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
              Navigator.pop(context);
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
                    CircleAvatar(
                      radius: profilePictureSize / 1.8,
                      backgroundColor: kPrimaryColor,
                      child: CircleAvatar(
                        radius: profilePictureSize / 1.8 - 3,
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: image,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: InkWell(
                        onTap: () {
                          // Handle camera action
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(color: Colors.white, width: 1.5)),
                            color: kPrimaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt_outlined,
                              color: Colors.white, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: profilePictureSize / 2),
            child: Column(
              children: [
                _buildListTile(context, "Name", name,name,email,phoneNumber),
                _buildListTile(context, "Email", email,name,email,phoneNumber),
                _buildListTile(context, "Phone Number", phoneNumber,name,email,phoneNumber),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, String value,String name,
      String email, String phoneNumber) {
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
