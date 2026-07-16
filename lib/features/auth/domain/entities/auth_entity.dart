class AuthEntity {
  final int id;
  final String name;
  final String email;
  final String role;
  final String createdAt;
  final String token;
  final String tokenType;

  const AuthEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.token,
    required this.tokenType,
  });

  /// Full authorization header value e.g. "Bearer xxxx"
  String get authorizationHeader => '$tokenType $token';
}
