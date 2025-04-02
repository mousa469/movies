import 'package:dio/dio.dart';

class CustomException implements Exception {
  final String errMessage;

  CustomException({required this.errMessage});
  @override
  String toString() {
    // TODO: implement toString
    return errMessage;
  }
}

class DioCustomException implements Exception {
  DioException dioException;
  DioCustomException({required this.dioException});
}

class CacheException extends CustomException {
  CacheException({required super.errMessage});
}

class ServerException extends CustomException {
  ServerException({required super.errMessage});
}
