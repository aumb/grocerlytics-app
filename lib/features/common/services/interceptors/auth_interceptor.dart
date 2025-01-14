import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:grocerlytics/features/common/local_storage/local_storage.dart';
import 'package:grocerlytics/features/common/local_storage/local_storage_keys.dart';
import 'package:grocerlytics/features/common/services/refresh_token/refresh_token_cubit.dart';
import 'package:grocerlytics/features/dependency_injection/injectable.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.dio,
    required this.localStorage,
    required this.baseUrl,
  });

  final Dio dio;
  final LocalStorage localStorage;
  final String baseUrl;

  String get _accessToken =>
      localStorage.getValue(LocalStorageKeys.accessToken);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Check if the request requires authentication
    final requiresAuth = options.extra['requiresAuth'] ?? true;

    if (requiresAuth) {
      if (_accessToken.isEmpty) {
        // If authentication is required but no token is available,
        // reject the request
        return handler.reject(
          DioException(
            requestOptions: options,
            error: 'Authentication required but no token available',
          ),
        );
      }
      options.headers['Authorization'] = _accessToken;
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Only attempt token refresh for authenticated requests
      if (err.requestOptions.extra['requiresAuth'] == true) {
        try {
          await getIt.get<RefreshTokenCubit>().refreshToken();
          return handler.resolve(await _retry(err.requestOptions));
        } catch (e) {
          handler.reject(err);
          log(err.toString());
          getIt.get<RefreshTokenCubit>().handleRefreshError();
          log(e.toString());
          rethrow;
        }
      }
    }
    return handler.next(err);
  }

  Future<Response<T>> _retry<T>(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
      extra: requestOptions.extra,
    );

    return dio.request<T>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
