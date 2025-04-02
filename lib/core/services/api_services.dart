import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:movies/core/services/custom_exception.dart';

class ApiService {
  final Dio _dio;
  static const String domain = "https://yts.mx/api/v2/";

  ApiService(this._dio) {
    _initializeDio();
  }

  void _initializeDio() {
    // Handle SSL/TLS handshake issues using the new createHttpClient method
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    // Add logging interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        log("📤 Request: ${options.method} ${options.uri}");
        log("📋 Headers: ${options.headers}");
        log("📩 Body: ${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        log("✅ Response [${response.statusCode}]: ${response.data}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        log("❌ Dio error: ${e.message}");
        return handler.next(e);
      },
    ));
  }

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,  
  }) async {
    try {
      final response =
          await _dio.get("$domain$endpoint", queryParameters: queryParams);
      return response;
    } on DioException catch (dioEx) {
      log("❌ GET Error: ${dioEx.message}");
      throw DioCustomException(dioException: dioEx);
    } catch (e) {
      log("❌ General GET Error: ${e.toString()}");
      throw CustomException(errMessage: e.toString());
    }
  }

  Future<Response> post(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.post("$domain$endpoint",
          data: data, queryParameters: queryParams);
      return response;
    } on DioException catch (dioEx) {
      log("❌ POST Error: ${dioEx.message}");
      throw DioCustomException(dioException: dioEx);
    } catch (e) {
      log("❌ General POST Error: ${e.toString()}");
      throw CustomException(errMessage: e.toString());
    }
  }

  Future<Response> put(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.put("$domain$endpoint",
          data: data, queryParameters: queryParams);
      return response;
    } on DioException catch (dioEx) {
      log("❌ PUT Error: ${dioEx.message}");
      throw DioCustomException(dioException: dioEx);
    } catch (e) {
      log("❌ General PUT Error: ${e.toString()}");
      throw CustomException(errMessage: e.toString());
    }
  }

  Future<Response> delete(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.delete("$domain$endpoint",
          queryParameters: queryParams);
      return response;
    } on DioException catch (dioEx) {
      log("❌ DELETE Error: ${dioEx.message}");
      throw DioCustomException(dioException: dioEx);
    } catch (e) {
      log("❌ General DELETE Error: ${e.toString()}");
      throw CustomException(errMessage: e.toString());
    }
  }
}
