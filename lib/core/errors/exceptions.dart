/// Data-layer exceptions thrown by remote/local datasources.
/// These are caught by repository implementations and mapped to [Failure] types.
/// They intentionally do NOT extend [Failure] — exceptions belong to the
/// data layer, while failures belong to the domain layer.

class ServerException implements Exception {
  final String message;
  const ServerException(this.message);

  @override
  String toString() => 'ServerException(message: $message)';
}

class CacheException implements Exception {
  final String message;
  const CacheException(this.message);

  @override
  String toString() => 'CacheException(message: $message)';
}

class ValidationException implements Exception {
  final String message;
  const ValidationException(this.message);

  @override
  String toString() => 'ValidationException(message: $message)';
}

class AuthenticationException implements Exception {
  final String message;
  const AuthenticationException(this.message);

  @override
  String toString() => 'AuthenticationException(message: $message)';
}
