import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taht_bety/user/Features/user_profile/cubit/email_cubit.dart';
import 'textformfield.dart';

class EditEmailDialog extends StatelessWidget {
  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _verificationCodeController =
      TextEditingController();

  EditEmailDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailCubit(),
      child: BlocConsumer<EmailCubit, EmailState>(
        listener: (context, state) {
          if (state is EmailError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is EmailUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Email updated to: ${state.newEmail}")),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is EmailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EmailCodeSent) {
            return _buildVerificationDialog(context);
          } else {
            return _buildNewEmailDialog(context);
          }
        },
      ),
    );
  }

  Widget _buildNewEmailDialog(BuildContext context) {
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
            CustomTextForm(
              keyboardType: TextInputType.emailAddress,
              validate: (val) {
                return null;
              },
              labelText: "New Email",
              mycontroller: _newEmailController,
            ),
            ElevatedButton(
              onPressed: () {
                context
                    .read<EmailCubit>()
                    .sendVerificationCode(_newEmailController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C3E5A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                fixedSize: const Size(100, 60),
              ),
              child: const Text("Send Code",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationDialog(BuildContext context) {
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
            CustomTextForm(
              keyboardType: TextInputType.number,
              validate: (val) {
                return null;
              },
              labelText: "Enter Verification Code",
              mycontroller: _verificationCodeController,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<EmailCubit>().verifyCode(
                      _newEmailController.text,
                      int.parse(_verificationCodeController.text),
                    );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C3E5A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                fixedSize: const Size(100, 60),
              ),
              child: const Text("Verify",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

void showEditEmailDialog(BuildContext context) async {
  final newName = await showDialog(
    context: context,
    builder: (context) => EditEmailDialog(),
  );
  if (newName != null) {
    print("Updated Email: $newName");
  }
}
