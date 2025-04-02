part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final String name;
  final String email;
  final String photo;
  final String phoneNumber;

  const ProfileLoaded({
    required this.name,
    required this.email,
    required this.photo,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [name, email, photo, phoneNumber];
}

final class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object> get props => [message];
}

final class ProfileUpdated extends ProfileState {
  final String message;

  const ProfileUpdated({required this.message});

  @override
  List<Object> get props => [message];
}

final class ProfileUpdateError extends ProfileState {
  final String message;

  const ProfileUpdateError({required this.message});

  @override
  List<Object> get props => [message];
}
