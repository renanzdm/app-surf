import 'package:dio/dio.dart';
import 'package:surf_app/infrastructure/rest_client/i_rest_client.dart';
import 'package:surf_app/infrastructure/rest_client/rest_client_exception.dart';
import 'package:surf_app/modules/home/domain/entities/user_id.dart';
import 'package:surf_app/modules/home/domain/errors/get_user_info_errors.dart';
import 'package:surf_app/modules/home/infra/datasources/i_get_user_infos_datasource.dart';

class GetUserDatasource implements IGetUserInfosDataSource {
  final IRestClient _client;

  GetUserDatasource(this._client);

  @override
  Future<UserId> getUserInfos() async {
    try {
      final client = _client.instance();
      var response = await client.get(
        '/users/me',
        options: Options(headers: {'requireToken': true}),
      );
      return UserId(
          id: response.data['id'],
          email: response.data['email'],
          name: response.data['name']);
    } on RestClientException catch (e) {
      throw ErrorInServer(error: e.message);
    }
  }
}
