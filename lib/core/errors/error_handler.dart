import 'package:dio/dio.dart';

import 'failure.dart';
import 'remote_exception.dart';

class ErrorHandler implements Exception {
  final Failure failure;

  ErrorHandler.fromError(dynamic error) : failure = mapFailure(error);

  static Failure handle(dynamic error) => mapFailure(error);

  static Failure mapFailure(dynamic error) {
    if (error is Failure) {
      return error;
    }
    if (error is RemoteException) {
      return ApiFailure(message: error.message);
    }
    if (error is ServerException) {
      return ApiFailure(message: error.message);
    }
    if (error is DioException) {
      return _mapDioException(error);
    }
    return ServiceFailure(message: error.toString());
  }

  static Failure _mapDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServiceFailure(message: error.message ?? 'Request timeout');
      case DioExceptionType.connectionError:
        return NoInternetFailure(
          message: error.message ?? 'No internet connection',
        );
      case DioExceptionType.cancel:
        return ServiceFailure(message: 'Request cancelled');
      case DioExceptionType.badCertificate:
        return ServiceFailure(message: 'Bad certificate');
      default:
        final statusCode = error.response?.statusCode;
        final statusMessage = error.response?.statusMessage;
        if (statusCode != null) {
          return ApiFailure(message: '$statusCode, $statusMessage');
        }
        return ServiceFailure(message: error.message ?? 'Unknown error');
    }
  }
}

enum DataSource {
  connectionTimeout,
  receiveTimeout,
  sendTimeout,
  badCertificate,
  connectionError,
  cancel,
  cacheError,
  noInternetConnection,
  unKnown,
}

class ResponseMessage {}
