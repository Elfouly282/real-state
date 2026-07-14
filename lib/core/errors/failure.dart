abstract class Failure {
  final String message;
  Failure({required this.message});

  @override
  String toString() => '$runtimeType(message: $message)';
}

class ApiFailure extends Failure {
  ApiFailure({required super.message});
}

class ServiceFailure extends Failure {
  ServiceFailure({required super.message});
}

class NoInternetFailure extends Failure {
  NoInternetFailure({required super.message});
}

class ServerException extends Failure {
  ServerException(String message) : super(message: message);
}

class CacheException extends Failure {
  CacheException(String message) : super(message: message);
}

class ValidationException extends Failure {
  ValidationException(String message) : super(message: message);
}

class AuthenticationException extends Failure {
  AuthenticationException(String message) : super(message: message);
}

class ProductNotFoundException extends Failure {
  ProductNotFoundException(String message) : super(message: message);
}

class CategoryNotFoundException extends Failure {
  CategoryNotFoundException(String message) : super(message: message);
}

class OrderNotFoundException extends Failure {
  OrderNotFoundException(String message) : super(message: message);
}

class PageNotFoundException extends Failure {
  PageNotFoundException(String message) : super(message: message);
}
