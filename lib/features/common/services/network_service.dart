import 'dart:async';

import 'package:dio/dio.dart';
import 'package:grocerlytics/features/common/local_storage/local_storage.dart';
import 'package:grocerlytics/features/common/services/interceptors/auth_interceptor.dart';
import 'package:grocerlytics/features/common/services/interceptors/logging_intercerptor.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NetworkService {
  NetworkService({
    required this.dio,
    required this.localStorage,
  }) {
    baseUrl = const String.fromEnvironment('BASE_URL');
    _setupInterceptors();
  }

  final Dio dio;
  final LocalStorage localStorage;
  late final String baseUrl;

  void _setupInterceptors() {
    dio.interceptors.addAll([
      AuthInterceptor(
        dio: dio,
        localStorage: localStorage,
        baseUrl: baseUrl,
      ),
      LoggingInterceptor(),
    ]);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = false,
  }) async {
    return dio.get(
      '$baseUrl$path',
      queryParameters: queryParameters,
      options: Options(extra: {'requiresAuth': requiresAuth}),
    );
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = false,
  }) async {
    return dio.post(
      '$baseUrl$path',
      data: data,
      queryParameters: queryParameters,
      options: Options(extra: {'requiresAuth': requiresAuth}),
    );
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = false,
  }) async {
    return dio.delete(
      '$baseUrl$path',
      queryParameters: queryParameters,
      options: Options(extra: {'requiresAuth': requiresAuth}),
    );
  }
}
