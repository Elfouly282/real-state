import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'constant_API.dart';
import '../constant/app_constants.dart';
import '../di.dart';
import '../funcations/app_functions.dart';
import '../security/security_helper.dart';

class DioHelper {
  static Dio? dio;

  static Future<void> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );

    if (!kReleaseMode) {
      dio?.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
  }

  // ─── Private Helpers ────────────────────────────────────────────────────────

  /// Safe accessor — throws a clear assertion if [init] was never called.
  static Dio _dio() {
    assert(dio != null,
        'DioHelper.init() must be called before making any requests.');
    return dio!;
  }

  /// Returns a trimmed, non-empty token or null.
  static String? _validToken() {
    final value = getIt<AuthStorage>().token?.trim();
    return (value != null && value.isNotEmpty) ? value : null;
  }

  /// Returns a trimmed, non-empty userId or null.
  static String? _validUserId() {
    final value = getIt<AuthStorage>().userId?.trim();
    return (value != null && value.isNotEmpty) ? value : null;
  }

  /// Sets common headers. Pass [withAuth] = true to attach the Bearer token.
  static Future<void> _setHeaders({bool withAuth = false}) async {
    final token = _validToken();
    final lang = AppFunctions.getLanguageCode();

    _dio().options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'locale': lang,
      if (withAuth && token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// Builds optional legacy query params (`access-token` + `id`).
  /// Only used by endpoints that still require them via [appendAuthParams].
  static Map<String, dynamic> _authQueryParams() {
    final token = _validToken();
    final userId = _validUserId();
    if (token != null && userId != null) {
      return {'access-token': token, 'id': userId};
    }
    return {};
  }

  // ─── Public API ─────────────────────────────────────────────────────────────

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    bool appendAuthParams = false,
    bool withAuth = false,
  }) async {
    await _setHeaders(withAuth: withAuth);

    final fullQuery = {
      if (appendAuthParams) ..._authQueryParams(),
      if (query != null) ...query,
    };

    return _dio().get(
      url,
      queryParameters: fullQuery.isEmpty ? null : fullQuery,
    );
  }

  static Future<Response> postData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
    bool appendAuthParams = false,
    bool withAuth = false,
  }) async {
    await _setHeaders(withAuth: withAuth);

    final fullQuery = {
      if (appendAuthParams) ..._authQueryParams(),
      if (query != null) ...query,
    };

    return _dio().post(
      url,
      data: data,
      queryParameters: fullQuery.isEmpty ? null : fullQuery,
    );
  }

  static Future<Response> putData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
  }) async {
    await _setHeaders();

    final authParams = _authQueryParams();
    final fullQuery = {
      ...authParams,
      if (query != null) ...query,
    };

    return _dio().put(
      url,
      data: data,
      queryParameters: fullQuery.isEmpty ? null : fullQuery,
    );
  }

  static Future<Response> putDataWithAuth({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
    bool withAuth = false,
  }) async {
    await _setHeaders(withAuth: withAuth);

    final fullQuery = {
      if (withAuth) ..._authQueryParams(),
      if (query != null) ...query,
    };

    return _dio().put(
      url,
      data: data,
      queryParameters: fullQuery.isEmpty ? null : fullQuery,
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    await _setHeaders();

    final fullQuery = {
      ..._authQueryParams(),
      if (query != null) ...query,
    };

    return _dio().delete(
      url,
      queryParameters: fullQuery.isEmpty ? null : fullQuery,
    );
  }

  static Future<Response> deleteDataWithAuth({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    bool withAuth = false,
  }) async {
    await _setHeaders(withAuth: withAuth);
    return _dio().delete(url, data: data, queryParameters: query);
  }

  static Future<Response> patchData({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    bool withAuth = false,
  }) async {
    await _setHeaders(withAuth: withAuth);
    return _dio().patch(url, data: data, queryParameters: query);
  }

  static Future<Response> postMultipartData({
    required String url,
    required FormData formData,
    bool withAuth = false,
  }) async {
    final token = _validToken();

    _dio().options.headers = {
      'Accept': 'application/json',
      if (withAuth && token != null) 'Authorization': 'Bearer $token',
    };

    return _dio().post(url, data: formData);
  }
}
