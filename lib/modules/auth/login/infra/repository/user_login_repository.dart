import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_app/modules/auth/login/domain/entities/user.dart';
import 'package:surf_app/modules/auth/login/domain/error/login_errors.dart';
import 'package:surf_app/modules/auth/login/domain/repositories/i_login_repository.dart';
import 'package:surf_app/modules/auth/login/infra/datasources/i_user_login_datasource.dart';

@Injectable(as: ILoginRepository)
class UserLoginRepository implements ILoginRepository {
  final IUserLoginDataSource _dataSource;

  UserLoginRepository(this._dataSource);

  @override
  Future<Either<LoginError, Unit>> login(String email, String password) async {
    try {
      await _dataSource.loginUser(email, password);
      return right(unit);
    } on LoginError catch (e) {
      return left(e);
    } catch (e) {
      return left(LoginErrorServer());
    }
  }
}
