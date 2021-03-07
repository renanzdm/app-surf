import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'i_rest_client.dart';
import 'rest_client_exception.dart';

@LazySingleton(as: IRestClient)
class CustomDio implements IRestClient {
  Dio _dio;

  BaseOptions options = BaseOptions(
    baseUrl: env['base_url'],
    connectTimeout: int.parse(env['dio_connectTimeout']),
    receiveTimeout: int.parse(env['dio_receiveTimeout']),
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
  Future onError(DioError err) {
    throw RestClientException(err);
  }
}

class AuthInterceptor extends InterceptorsWrapper {
  SharedPreferences _preferences;

  @override
  Future onError(DioError err) async {
    return err;
  }

  @override
  Future onRequest(RequestOptions options) async {
    if (options.headers.containsKey('requireToken')) {
      options.headers.remove('requireToken');
      _preferences = await SharedPreferences.getInstance();
      var token = _preferences.getString('token-user');
      options.headers.addAll({'x-access-token': token});
    }
    return options;
  }

  @override
  Future onResponse(Response response) async {
    return response;
  }
}
