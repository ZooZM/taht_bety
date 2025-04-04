import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taht_bety/user/Features/user_profile/presentation/cubit/profile_cubit.dart';

import 'textformfield.dart';

class EditNameDialog extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String name;
  final String email;
  final String phoneNumber;
  late final TextEditingController _nameController;

  EditNameDialog({
    super.key,
    required this.name,
    required this.email,
    required this.phoneNumber,
  }) {
    _nameController = TextEditingController(text: name);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: const Color(0xffFFFEFE),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Form(
              key: _formKey,
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
                      if (val!.isEmpty) {
                        return "Please enter your name";
                      } else if (val.length < 3) {
                        return "Name must be at least 3 characters";
                      }
                      return null;
                    },
                    labelText: "Name",
                    mycontroller: _nameController,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Save the new name
                        String newName = _nameController.text.toString();
                        BlocProvider.of<ProfileCubit>(context).updateUser(
                            name: newName,
                            email: email,
                            phoneNumber: phoneNumber);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Name updated successfully"),
                          ),
                        );

                        Navigator.pop(context);
                      }
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
        },
      ),
    );
  }
}

void showEditNameDialog(
    BuildContext context, String name, String email, String phoneNumber) async {
  await showDialog(
    context: context,
    builder: (context) =>
        EditNameDialog(email: email, name: name, phoneNumber: phoneNumber),
  );
}
