import 'package:dio/dio.dart';

abstract class Failure {
  final String failurMsg;

  Failure(this.failurMsg);
}

class Serverfailure extends Failure {
  Serverfailure(super.failurMsg);

  factory Serverfailure.fromDioException(DioException dioException) {
    // Ensure dioException.message is not null before using the null check operator
    final message = dioException.message ?? 'Unknown error';

    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return Serverfailure('Connection Timeout, please try again later');

      case DioExceptionType.sendTimeout:
        return Serverfailure('Send Timeout, please try again later');

      case DioExceptionType.receiveTimeout:
        return Serverfailure('Receive Timeout, please try again later');

      case DioExceptionType.badCertificate:
        return Serverfailure('Something happened, please try again later');

      case DioExceptionType.badResponse:
        return Serverfailure.fromResponse(
            dioException.response?.statusCode, dioException.response);

      case DioExceptionType.cancel:
        return Serverfailure('Request was cancelled');

      case DioExceptionType.connectionError:
        return Serverfailure('Connection Error, please try again later');

      case DioExceptionType.unknown:
        if (message.contains('SocketException')) {
          return Serverfailure('No Internet Connection');
        }
        return Serverfailure('There was an Error, please try again later');

      default:
        return Serverfailure('Failure: $message');
    }
  }

  factory Serverfailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return Serverfailure(response['error']['message'] ?? 'Unknown error');
    } else if (statusCode == 404) {
      return Serverfailure('Error 404: Your request not Found');
    } else {
      return Serverfailure('There was an Error, please try again later');
    }
  }
}
