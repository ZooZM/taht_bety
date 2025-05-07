import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/core/utils/api_service.dart';
import 'package:taht_bety/core/widgets/custom_circular_progress.dart';

import '../../../user_profile/presentation/widgets/textformfield.dart';

class PasswordMangerScreen extends StatefulWidget {
  const PasswordMangerScreen({super.key});

  @override
  State<PasswordMangerScreen> createState() => _PasswordMangerScreenState();
}

class _PasswordMangerScreenState extends State<PasswordMangerScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  bool isLoading = false;
  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmNewPasswordVisible = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() async {
    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmNewPassword = _confirmNewPasswordController.text;

    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmNewPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    if (newPassword != confirmNewPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("New passwords do not match")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });
    try {
      final user = UserStorage.getUserData();
      final response = await ApiService(Dio()).put(
          endPoint: 'auth/update-password',
          data: {
            "currentPassword": currentPassword,
            "newPassword": newPassword,
            "newPasswordConfirm": confirmNewPassword,
          },
          token: user.token);

      if (response['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text("Password updated successfully, Please log in again")),
        );
        UserStorage.deleteUserData();
        context.go('/');
      }
    } on DioException catch (e) {
      String errorMessage = "An error occurred";
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        errorMessage = e.response!.data['message'] ?? errorMessage;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
        title: const Text(
          'Password Manger',
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
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextForm(
              labelText: "Current Password",
              isPassword: !_isCurrentPasswordVisible,
              keyboardType: TextInputType.visiblePassword,
              mycontroller: _currentPasswordController,
              validate: (val) {
                return null;
              },
              suffix: IconButton(
                icon: Icon(
                  _isCurrentPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextForm(
              labelText: "New Password",
              isPassword: !_isNewPasswordVisible,
              keyboardType: TextInputType.visiblePassword,
              mycontroller: _newPasswordController,
              validate: (val) {
                return null;
              },
              suffix: IconButton(
                icon: Icon(
                  _isNewPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isNewPasswordVisible = !_isNewPasswordVisible;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextForm(
              labelText: "Confirm New Password",
              isPassword: !_isConfirmNewPasswordVisible,
              keyboardType: TextInputType.visiblePassword,
              mycontroller: _confirmNewPasswordController,
              validate: (val) {
                return null;
              },
              suffix: IconButton(
                icon: Icon(
                  _isConfirmNewPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isConfirmNewPasswordVisible =
                        !_isConfirmNewPasswordVisible;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 200),
          ElevatedButton(
            onPressed: _changePassword,
            style: ElevatedButton.styleFrom(
              shadowColor: const Color(0xffd8dbe2),
              backgroundColor: const Color(0xFF2C3E5A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              fixedSize: const Size(160, 45),
            ),
            child: isLoading
                ? const CustomCircularprogress(size: 20, color: Colors.white)
                : const Text(
                    "Change Password",
                    softWrap: false,
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ],
      ),
    ));
  }
}
