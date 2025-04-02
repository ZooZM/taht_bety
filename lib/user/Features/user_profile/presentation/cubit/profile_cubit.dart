import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:taht_bety/core/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taht_bety/user/Features/user_profile/cubit/email_cubit.dart';
import 'package:taht_bety/user/Features/user_profile/presentation/widgets/textformfield.dart';

import '../../../../../auth/data/models/user/user.dart';
import '../../../../../auth/data/models/user_strorge.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<User> _fetchUser() async {
    final curUser = UserStorage.getUserData();
    return User(
      name: curUser.name,
      email: curUser.email,
      photo: curUser.photo,
      phoneNumber: curUser.phoneNumber,
    );
  }

  Future<void> fetchUser() async {
    emit(ProfileLoading());
    try {
      final user = await _fetchUser();
      emit(ProfileLoaded(
        name: user.name!,
        email: user.email!,
        photo: user.photo!,
        phoneNumber: user.phoneNumber!,
      ));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> updateUser({
    required String name,
    required String email,
    required String phoneNumber,
  }) async {
    emit(ProfileLoading());
    try {
      const String endPoint = 'users/update-me';
      final data = {
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
      };

      final Dio _dio = Dio();
      final response = await ApiService(_dio).patch(
          endPoint: endPoint,
          data: data,
          token: UserStorage.getUserData().token);

      print('API Response: $response'); // Debugging

      if (response['success'] == true) {
        final updatedUser = response['data']['user'];
        print('API User: $updatedUser');
        await UserStorage.updateUserData(
          name: updatedUser['name'],
          email: updatedUser['email'],
          phoneNamber: updatedUser['phoneNumber'],
        );
        emit(ProfileLoaded(
          name: updatedUser.name!,
          email: updatedUser.email!,
          photo: updatedUser.photo!,
          phoneNumber: updatedUser.phoneNumber!,
        ));
      } else {
        throw Exception('Failed to update profile. Please try again.');
      }
    } catch (e) {
      emit(ProfileUpdateError(message: e.toString()));
    }
  }
}

class EditEmailDialog extends StatelessWidget {
  final TextEditingController _currentEmailController = TextEditingController();
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
          } else if (state is EmailVerified) {
            return _buildNewEmailDialog(context);
          } else {
            return _buildInitialDialog(context);
          }
        },
      ),
    );
  }

  Widget _buildInitialDialog(BuildContext context) {
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
              labelText: "Current Email",
              mycontroller: _currentEmailController,
            ),
            ElevatedButton(
              onPressed: () {
                context
                    .read<EmailCubit>()
                    .sendVerificationCode(_currentEmailController.text);
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
                      _currentEmailController.text,
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
}
