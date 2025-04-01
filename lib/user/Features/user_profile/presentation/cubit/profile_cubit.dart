import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:taht_bety/core/utils/api_service.dart';

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
      const String endPoint ='users/update-me';
      final data = {
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
      };

      final Dio _dio = Dio();
      final response =
          await ApiService(_dio).patch(endPoint: endPoint, data: data);

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
