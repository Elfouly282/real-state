part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

// حالات التحميل
final class ProfileLoading extends ProfileState {}
final class UpdateProfileLoading extends ProfileState {}
final class ChangePasswordLoading extends ProfileState {}

// حالات النجاح
final class ProfileSuccess extends ProfileState {
  final ProfileEntity profile;

  ProfileSuccess({required this.profile});
}

final class UpdateProfileSuccess extends ProfileState {
  final ProfileEntity profile;

  UpdateProfileSuccess({required this.profile});
}

final class ChangePasswordSuccess extends ProfileState {
  final String message;

  ChangePasswordSuccess({required this.message});
}

// حالات الخطأ
final class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});
}

final class UpdateProfileError extends ProfileState {
  final String message;

  UpdateProfileError({required this.message});
}

final class ChangePasswordError extends ProfileState {
  final String message;

  ChangePasswordError({required this.message});
}