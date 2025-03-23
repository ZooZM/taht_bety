import 'package:flutter/material.dart';

import 'textformfield.dart';

class EditNameDialog extends StatelessWidget {
  final TextEditingController _nameController =
      TextEditingController(text: "Alaa Khalid");

  EditNameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: const Color(0xffFFFEFE),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
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
            CustomTextForm(
              keyboardType: TextInputType.emailAddress,
              validate: (val) {
                return null;
              },
              labelText: "Name",
              mycontroller: _nameController,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _nameController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C3E5A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                fixedSize: const Size(100, 60),
              ),
              child: const Text("Save",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

void showEditNameDialog(BuildContext context) async {
  final newName = await showDialog(
    context: context,
    builder: (context) => EditNameDialog(),
  );
  if (newName != null) {
    print("Updated Name: $newName");
  }
}
