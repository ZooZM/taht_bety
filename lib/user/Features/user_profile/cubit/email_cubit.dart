import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:taht_bety/core/utils/api_service.dart';

part 'email_state.dart';

class EmailCubit extends Cubit<EmailState> {
  EmailCubit() : super(EmailInitial());

  final Dio _dio = Dio();

  void sendVerificationCode(String email) async {
    emit(EmailLoading());
    try {
      final response = await ApiService(_dio).post(
        endPoint: 'auth/resend-verification-code',
        data: {"email": email},
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
    emit(EmailLoading());
    try {
      final response = await ApiService(_dio).post(
        endPoint: 'auth/verify-email',
        data: {"email": email, "verificationCode": code},
      );
      if (response['success']) {
        emit(EmailVerified());
      } else {
        emit(EmailError("Invalid verification code."));
      }
    } catch (e) {
      emit(EmailError("Failed to verify code."));
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
