import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies/core/services/custom_exception.dart';

class ApiService {
  final Dio _dio;

  static const String domain = "https://yts.mx/api/v2/";

  ApiService(this._dio);

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response =
          await _dio.get("${domain}${endpoint}", queryParameters: queryParams);
      return response;
    } on DioException catch (dioEx) {
      log("Exception thrown from ApiServices.get on DioException catch block  and message is : ${dioEx.message} ");
      throw DioCustomException(dioException: dioEx);
    } catch (e) {
      log("Exception thrown from ApiServices.get on general catch block  and message is : ${e.toString()} ");
      throw CustomException(errMessage: e.toString());
    }
  }

  Future<Response> post(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response =
          await _dio.post(endpoint, data: data, queryParameters: queryParams);
      return response;
    } catch (e) {
      throw Exception("POST request failed: $e");
    }
  }

  Future<Response> put(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response =
          await _dio.put(endpoint, data: data, queryParameters: queryParams);
      return response;
    } catch (e) {
      throw Exception("PUT request failed: $e");
    }
  }

  Future<Response> delete(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response =
          await _dio.delete(endpoint, queryParameters: queryParams);
      return response;
    } catch (e) {
      throw Exception("DELETE request failed: $e");
    }
  }
}
