import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_app/infrastructure/rest_client/i_rest_client.dart';
import 'package:surf_app/infrastructure/rest_client/rest_client_exception.dart';
import 'package:surf_app/modules/auth/login/domain/error/login_errors.dart';
import 'package:surf_app/modules/auth/login/infra/datasources/i_user_login_datasource.dart';

class UserLoginDatasource implements IUserLoginDataSource {
  final IRestClient _client;

  UserLoginDatasource(this._client);

  @override
  Future<void> loginUser(String email, String password) async {
    try {
      var client = _client.instance();
      var res = await client.post('/users/authenticate',
          data: {'email': email, 'password': password});
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('token-user', res.data['token']);
    } on RestClientException catch (e) {
      if (e.response?.statusCode == 401)
        throw LoginErrorInvalidUserOrPassword();
      throw LoginErrorServer(
          message: e.response?.statusMessage ?? 'Erro No Server');
    } catch (e) {
      throw LoginErrorServer(message: e.toString());
    }
  }
}
