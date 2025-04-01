import 'package:flutter/material.dart';

import '../../../user_profile/presentation/widgets/textformfield.dart';

class PasswordMangerScreen extends StatelessWidget {
  PasswordMangerScreen({super.key});
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
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
              isPassword: true,
              keyboardType: TextInputType.visiblePassword,
              mycontroller: _currentPasswordController,
              validate: (val) {
                return null;
              },
              suffix: const Icon(Icons.lock_outline),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Forgot Password?",
                style: TextStyle(
                    color: Color(0xff15243f),
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextForm(
              labelText: "New Password",
              isPassword: true,
              keyboardType: TextInputType.visiblePassword,
              mycontroller: _newPasswordController,
              validate: (val) {
                return null;
              },
              suffix: const Icon(Icons.lock_outline),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextForm(
              labelText: "Confirm New Password",
              isPassword: true,
              keyboardType: TextInputType.visiblePassword,
              mycontroller: _confirmNewPasswordController,
              validate: (val) {
                return null;
              },
              suffix: const Icon(Icons.lock_outline),
            ),
          ),
          const SizedBox(height: 200),
          ElevatedButton(
            onPressed: () {
              // change password
            },
            style: ElevatedButton.styleFrom(
              shadowColor: const Color(0xffd8dbe2),
              backgroundColor: const Color(0xFF2C3E5A),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              fixedSize: const Size(160, 45),
            ),
            child: const Text("Change Password",
                softWrap: false, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    ));
  }
}
