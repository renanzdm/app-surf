import 'package:dio/dio.dart';

class RestClientException extends DioError {
  RestClientException(DioError e)
      : super(
          requestOptions: e.requestOptions,
          response: e.response,
          error: e.error,
        );
}
