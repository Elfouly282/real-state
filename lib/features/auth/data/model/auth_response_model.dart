import '../../domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id,
    required super.name,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

class AuthResponseModel extends AuthResponse {
  const AuthResponseModel({
    required super.token,
    required UserModel super.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    // Backend API can wrap data in a 'data' key or return it directly
    final data = json['data'] ?? json;
    
    return AuthResponseModel(
      token: data['token'] ?? '',
      user: UserModel.fromJson(data['user'] ?? {}),
    );
  }
}
