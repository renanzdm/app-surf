import 'package:injectable/injectable.dart';
import 'package:surf_app/modules/auth/register/domain/error/register_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:surf_app/modules/auth/register/domain/repositories/i_register_repository.dart';
import 'package:surf_app/modules/auth/register/infra/datasource/i_user_register_datasource.dart';

@Injectable(as: IRegisterUserRepository)
class UserRegisterRepository implements IRegisterUserRepository {
  final IUserRegisterDatasource _datasource;

  UserRegisterRepository(this._datasource);

  @override
  Future<Either<RegisterErrors, Unit>> registerUser(
      String name, String email, String password) async {
    try {
      await _datasource.saveUser(name, email, password);
      return right(unit);
    } on RegisterErrors catch (e) {
      return left(e);
    } catch (e) {
      return left(RegisterErrorServer(message: e.toString()));
    }
  }
}
