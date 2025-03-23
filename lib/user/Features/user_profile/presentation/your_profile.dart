import 'package:flutter/material.dart';

import 'widgets/editEmailDialog.dart';
import 'widgets/editNameDialog.dart';
import 'widgets/editPhoneNumberDialog.dart';

const Color _primaryColor = Color(0xFF2C3E5A); // Dark Blue

class YourProfile extends StatelessWidget {
  const YourProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _primaryColor,
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
                      child: _buildProfileInfo(context),
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
        color: _primaryColor,
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

  Widget _buildProfileInfo(BuildContext context) {
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
                    const CircleAvatar(
                      radius: profilePictureSize / 1.8,
                      backgroundColor: _primaryColor,
                      child: CircleAvatar(
                        radius: profilePictureSize / 1.8 - 3,
                        backgroundImage: NetworkImage(
                            'https://randomuser.me/api/portraits/women/44.jpg'),
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
                            color: _primaryColor,
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
                _buildListTile(context, "Name", "Alaa Khalid"),
                _buildListTile(context, "Email", "alaakhalid@gmail.com"),
                _buildListTile(context, "Phone Number", "01137204439"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, String value) {
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
                showEditNameDialog(context);
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
