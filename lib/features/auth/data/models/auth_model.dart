import '../../domain/entities/auth_entity.dart';

/// Parses the login response:
/// ```json
/// [
///   {
///     "data": {
///       "user": {
///         "id": 264,
///         "name": "Admin",
///         "email": "admin@example.com",
///         "role": "admin",
///         "created_at": "2026-07-14T18:21:15.000000Z"
///       },
///       "token": "629|htsDyTCVzh3FhRshX3Q1...",
///       "token_type": "Bearer"
///     }
///   }
/// ]
/// ```
class AuthModel extends AuthEntity {
  const AuthModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    required super.createdAt,
    required super.token,
    required super.tokenType,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    // Response is wrapped in an array → first element → "data" key
    final data = json['data'] as Map<String, dynamic>;
    final user = data['user'] as Map<String, dynamic>;

    return AuthModel(
      id: (user['id'] as num).toInt(),
      name: user['name'] as String? ?? '',
      email: user['email'] as String? ?? '',
      role: user['role'] as String? ?? '',
      createdAt: user['created_at'] as String? ?? '',
      token: data['token'] as String? ?? '',
      tokenType: data['token_type'] as String? ?? 'Bearer',
    );
  }
}
