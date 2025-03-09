part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthFailure extends AuthState {
  final String failureMssg;
  AuthFailure({required this.failureMssg});
}

final class AuthSuccess extends AuthState {
  final UserModel user;
  AuthSuccess({required this.user});
}

class VerificationFailure extends AuthState {
  final String email;
  VerificationFailure(this.email);
}
