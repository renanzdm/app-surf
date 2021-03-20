import 'package:surf_app/infrastructure/rest_client/i_rest_client.dart';
import 'package:surf_app/infrastructure/rest_client/rest_client_exception.dart';
import 'package:surf_app/modules/auth/register/domain/error/register_errors.dart';
import 'package:surf_app/modules/auth/register/infra/datasource/i_user_register_datasource.dart';

class UserRegisterDatasource implements IUserRegisterDatasource {
  final IRestClient _client;

  UserRegisterDatasource(this._client);

  @override
  Future<void> saveUser(String name, String email, String password) async {
    try {
      final client = _client.instance();
      await client.post('/users',
          data: {"name": name, "email": email, "password": password});
    } on RestClientException catch (e) {
      if (e.response?.statusCode == 409) {
        throw RegisterErrorEmailInUse();
      }
      throw RegisterErrorServer(message: e.error);
    } catch (e) {
      throw RegisterErrorServer(message: e.toString());
    }
  }
}
