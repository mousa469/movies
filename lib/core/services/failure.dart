import 'package:dio/dio.dart';

class Failure {
  final String errMessage;

  Failure({required this.errMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errMessage});
}
class CacheFailure extends Failure {
  CacheFailure({required super.errMessage});
}

class DioFailure extends Failure {
  DioFailure({required super.errMessage});

  factory DioFailure.fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return DioFailure(errMessage: "Connection timeout. Please try again.");
      case DioExceptionType.sendTimeout:
        return DioFailure(errMessage: "Send timeout. Please try again.");
      case DioExceptionType.receiveTimeout:
        return DioFailure(errMessage: "Receive timeout. Please try again.");
      case DioExceptionType.badCertificate:
        return DioFailure(errMessage: "Bad SSL certificate detected.");
      case DioExceptionType.badResponse:
        return BadResponse.fromDio(e);
      case DioExceptionType.cancel:
        return DioFailure(errMessage: "Request was cancelled.");
      case DioExceptionType.connectionError:
        return DioFailure(errMessage: "No Internet connection.");
      case DioExceptionType.unknown:
        return DioFailure(
            errMessage: "An unknown error occurred: ${e.message}");
      default:
        return DioFailure(
            errMessage: "Something went wrong. Please try again.");
    }
  }
}

class BadResponse extends DioFailure {
  BadResponse({required super.errMessage});

  factory BadResponse.fromDio(DioException e) {
    final statusCode = e.response?.statusCode ?? 0;
    if (statusCode == 400) {
      return BadResponse(errMessage: "Bad request. Please check your input.");
    } else if (statusCode == 401) {
      return BadResponse(errMessage: "Unauthorized. Please log in again.");
    } else if (statusCode == 403) {
      return BadResponse(errMessage: "Forbidden. You don’t have access.");
    } else if (statusCode == 404) {
      return BadResponse(
          errMessage: "Resource not found. Please check the URL.");
    } else if (statusCode == 500) {
      return BadResponse(errMessage: "Internal server error. Try again later.");
    } else if (statusCode == 503) {
      return BadResponse(
          errMessage: "Service unavailable. The server is overloaded.");
    } else {
      return BadResponse(
          errMessage:
              "Server error: $statusCode - ${e.response?.statusMessage}");
    }
  }
}
