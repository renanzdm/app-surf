import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'i_rest_client.dart';
import 'rest_client_exception.dart';

class CustomDio implements IRestClient {
  Dio _dio = Dio();

  BaseOptions options = BaseOptions(
    baseUrl: env['base_url']!,
    connectTimeout: int.parse(env['dio_connectTimeout']!),
    receiveTimeout: int.parse(env['dio_receiveTimeout']!),
  );

  @override
  Dio instance() => _dio;

  CustomDio() {
    _dio = Dio(options)
      ..interceptors.addAll([
        ErrorInterceptor(),
        AuthInterceptor(),
      ]);
  }
}

class ErrorInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    throw (RestClientException(err.error));
  }
}

class AuthInterceptor extends InterceptorsWrapper {
  SharedPreferences? _prefs;

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {}

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    _prefs = await SharedPreferences.getInstance();
    if (options.headers.containsKey('requireToken')) {
      options.headers.remove('requireToken');

      var token = _prefs?.get('token-user');
      options.headers.addAll({'x-access-token': token});
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {}
}
