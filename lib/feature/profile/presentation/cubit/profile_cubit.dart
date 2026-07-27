import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:real_state/feature/profile/domain/entity/profile_entity.dart';

import '../../domain/usecases/change_password_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  ProfileEntity? currentProfile;

  ProfileCubit({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.changePasswordUseCase,
  }) : super(ProfileInitial());

  // 1. Get Profile Data
  Future<void> getProfile() async {
    emit(ProfileLoading());

    final result = await getProfileUseCase();

    result.fold((failure) => emit(ProfileError(message: failure.message)), (
      profile,
    ) {
      currentProfile = profile;
      emit(ProfileSuccess(profile: profile));
    });
  }

  // 2. Update Profile Data
  Future<void> updateProfile({
    required String name,
    required String email,
    required String location,
    required String phone,
  }) async {
    emit(UpdateProfileLoading());

    final result = await updateProfileUseCase(
      name: name,
      email: email,
      location: location,
      phone: phone,
    );

    result.fold(
      (failure) {
        emit(UpdateProfileError(message: failure.message));
        if (currentProfile != null) {
          emit(ProfileSuccess(profile: currentProfile!));
        }
      },
      (updatedProfile) {
        currentProfile = updatedProfile;
        emit(UpdateProfileSuccess(profile: updatedProfile));
        emit(ProfileSuccess(profile: updatedProfile));
      },
    );
  }

  // 3. Change Password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(ChangePasswordLoading());

    final result = await changePasswordUseCase(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    result.fold(
      (failure) {
        emit(ChangePasswordError(message: failure.message));
        if (currentProfile != null) {
          emit(ProfileSuccess(profile: currentProfile!));
        }
      },
      (_) {
        emit(ChangePasswordSuccess(message: 'change password successfully'));
        if (currentProfile != null) {
          emit(ProfileSuccess(profile: currentProfile!));
        } else {
          getProfile();
        }
      },
    );
  }
}
