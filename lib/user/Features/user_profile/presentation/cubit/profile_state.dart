part of 'profile_cubit.dart';

abstract class ProfileState  {
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final String name;
  final String email;
  final String photo;
  final String phoneNumber;

   ProfileLoaded({
    required this.name,
    required this.email,
    required this.photo,
    required this.phoneNumber,
  });
}

final class ProfileError extends ProfileState {
  final String message;

   ProfileError({required this.message});
}

final class ProfileUpdated extends ProfileState {
  final String message;

   ProfileUpdated({required this.message});

}

final class ProfileUpdateError extends ProfileState {
  final String message;

   ProfileUpdateError({required this.message});

}
