import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    // failure = DataSource.unKnown.getFailure();
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

// extension DataSourceExtension on DataSource {
//   Failure getFailure() {
//     switch (this) {
//       case DataSource.connectionTimeout:
//         return ServiceFailure(message: ResponseMessage.connectionTimeout);
//       case DataSource.cancel:
//         return ServiceFailure(message: ResponseMessage.cancel);
//       case DataSource.receiveTimeout:
//         return ServiceFailure(message: ResponseMessage.receiveTimeout);
//       case DataSource.sendTimeout:
//         return ServiceFailure(message: ResponseMessage.sendTimeout);
//       case DataSource.cacheError:
//         return ServiceFailure(message: ResponseMessage.cacheError);
//       case DataSource.noInternetConnection:
//         return NoInternetFailure(message: ResponseMessage.noInternetConnection);
//       case DataSource.unKnown:
//         return ServiceFailure(message: ResponseMessage.unKnown);
//       case DataSource.badCertificate:
//         return ServiceFailure(message: ResponseMessage.badCertificate);
//       case DataSource.connectionError:
//         return ApiFailure(message: ResponseMessage.connectionError);
//     }
//   }
// }

class ResponseMessage {
  // static const String connectionTimeout = AppTexts.timeoutError;
  // static const String cancel = AppTexts.requestCanceled;
  // static const String receiveTimeout = AppTexts.timeoutError;
  // static const String sendTimeout = AppTexts.timeoutError;
  // static const String cacheError = AppTexts.cacheError;
  // static const String noInternetConnection = AppTexts.noInternetError;
  // static const String unKnown = AppTexts.unKnownError;
  // static const String badCertificate = AppTexts.badCertificate;
  // static const String connectionError = AppTexts.connectionError;
}
