import 'package:real_state/core/api/dio_helper.dart';
import 'package:real_state/feature/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();

  Future<ProfileModel> updateProfile({
    required String name,
    required String email,
    required String location,
    required String phone,
  });

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl();

  @override
  Future<ProfileModel> getProfile() async {
    final response = await DioHelper.getData(
      url: '/api/v1/auth/me',
      withAuth: true,
    );
    return ProfileModel.fromJson(response.data);
  }


  @override
  Future<ProfileModel> updateProfile({
    required String name,
    required String email,
    required String location,
    required String phone,
  }) async {
    final response = await DioHelper.putDataWithAuth(
      url: '/api/v1/auth/profile',
      withAuth: true,
      data: {
        'name': name,
        'email': email,
        'location': location,
        'phone': phone,
      },
    );
    return ProfileModel.fromJson(response.data);
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await DioHelper.putDataWithAuth(
      url: '/api/v1/auth/password',
      withAuth: true,
      data: {
        'current_password': currentPassword,
        'password': newPassword,
        'password_confirmation': newPassword,
        'new_password': newPassword,
      },
    );
  }
}
