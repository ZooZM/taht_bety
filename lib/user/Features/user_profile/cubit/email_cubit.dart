import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/core/utils/api_service.dart';

part 'email_state.dart';

class EmailCubit extends Cubit<EmailState> {
  String? _newEmail;
  EmailCubit() : super(EmailInitial());
  final Dio _dio = Dio();

  void sendVerificationCode(String email) async {
    _newEmail = email;
    emit(EmailLoading());
    try {
      final user = UserStorage.getUserData();
      final response = await ApiService(_dio).post(
        endPoint: 'auth/send-change-email-code',
        data: {"email": email},
        token: user.token,
      );
      if (response['success']) {
        emit(EmailCodeSent());
      } else {
        emit(EmailError("Failed to send verification code."));
      }
    } catch (e) {
      emit(EmailError("Failed to send verification code."));
    }
  }

  void verifyCode(String email, int code) async {
    if (_newEmail == null) {
      emit(EmailError("No email to verify."));
      return;
    } else if (email == '') {
      email = _newEmail!;
    }

    emit(EmailLoading());
    try {
      final user = UserStorage.getUserData();

      final response = await ApiService(_dio).put(
        endPoint: 'auth/change-email',
        data: {"email": email, "verificationCode": code},
        token: user.token,
      );
      if (response['success']) {
        UserStorage.saveUserData(
          token: response['data']['token'],
          userId: response['data']['user']['_id'],
          lat: user.lat,
          long: user.long,
          name: user.name,
          email: response['data']['user']['email'],
          photo: user.photo,
          phoneNamber: user.phoneNumber,
          favProviders: user.favProviders,
        );
        emit(EmailVerified());
      } else {
        emit(EmailError("Invalid verification code."));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          emit(EmailVerifiError("Invalid verification code."));
        } else {
          emit(EmailError("Failed to verify code."));
        }
      } else {
        emit(EmailError("Failed to verify code."));
      }
    }
  }

  void updateEmail(String newEmail) async {
    emit(EmailLoading());
    try {
      // Simulate updating the email
      await Future.delayed(const Duration(seconds: 2));
      emit(EmailUpdated(newEmail));
    } catch (e) {
      emit(EmailError("Failed to update email."));
    }
  }
}
