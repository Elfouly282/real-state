import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is Failure) {
      failure = error;
    } else {
      failure = ServiceFailure(message: error.toString());
    }
  }
}
