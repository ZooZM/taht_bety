import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/constants.dart';

class ChangePhoneDialog extends StatefulWidget {
  const ChangePhoneDialog({super.key});

  @override
  _ChangePhoneDialogState createState() => _ChangePhoneDialogState();
}

class _ChangePhoneDialogState extends State<ChangePhoneDialog> {
  final TextEditingController _newPhoneController = TextEditingController();
  bool _isLoading = false;

  Future<void> _changePhoneNumber() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = UserStorage.getUserData();
      final response = await Dio().patch(
        '${kBaseUrl}users/update-me',
        data: {'phoneNumber': _newPhoneController.text},
        options: Options(
          headers: {'Authorization': 'Bearer ${user.token}'},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Phone number updated successfully"),
            duration: Duration(seconds: 3),
          ),
        );
        UserStorage.updateUserData(
          name: user.name,
          email: user.email,
          photo: user.photo,
          phoneNamber: _newPhoneController.text,
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to update phone number"),
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
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _newPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                    weight: 2,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Text(
              "Enter your new phone number",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff15243f),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _newPhoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "New Phone Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _changePhoneNumber,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C3E5A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                fixedSize: const Size(120, 50),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "Change",
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

void showChangePhoneDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const ChangePhoneDialog(),
  );
}
