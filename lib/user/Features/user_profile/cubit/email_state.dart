part of 'email_cubit.dart';

@immutable
abstract class EmailState {}

class EmailInitial extends EmailState {}

class EmailLoading extends EmailState {}

class EmailCodeSent extends EmailState {}

class EmailVerified extends EmailState {}

class EmailVerifiError extends EmailState {
  final String message;

  EmailVerifiError(this.message);
}

class EmailUpdated extends EmailState {
  final String newEmail;

  EmailUpdated(this.newEmail);
}

class EmailError extends EmailState {
  final String message;

  EmailError(this.message);
}
