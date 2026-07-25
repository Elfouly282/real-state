import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:real_state/feature/profile/domain/entity/profile_entity.dart';



import '../../domain/usecases/change_password_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  ProfileCubit({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.changePasswordUseCase,
  }) : super(ProfileInitial());

  // 1. جلب بيانات البروفايل
  Future<void> getProfile() async {
    emit(ProfileLoading());

    final result = await getProfileUseCase();

    result.fold(
      (failure) => emit(ProfileError(message: failure.message)),
      (profile) => emit(ProfileSuccess(profile: profile)),
    );
  }

  // 2. تحديث بيانات البروفايل
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
    (failure) => emit(UpdateProfileError(message: failure.message)),
    (updatedProfile) {
      // 1. نرسل إشعار النجاح للشاشة الحالية لتغلق نفسها
      emit(UpdateProfileSuccess(profile: updatedProfile));
      
      // 2. فوراً نرسل حالة النجاح العامة بالبيانات الجديدة لتتحدث الشاشة الرئيسية بالكامل
      emit(ProfileSuccess(profile: updatedProfile));
    },
  );
}

  // 3. تغيير كلمة المرور
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
      (failure) => emit(ChangePasswordError(message: failure.message)),
      (_) => emit(ChangePasswordSuccess(message: 'تم تغيير كلمة المرور بنجاح')),
    );
  }
}