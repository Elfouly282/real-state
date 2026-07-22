class UserEntity {
  final String? id;
  final String name;
  final String email;

  const UserEntity({
    this.id,
    required this.name,
    required this.email,
  });
}

class AuthResponse {
  final String token;
  final UserEntity user;

  const AuthResponse({
    required this.token,
    required this.user,
  });
}
