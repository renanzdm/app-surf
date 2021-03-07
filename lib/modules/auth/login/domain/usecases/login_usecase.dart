import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_app/modules/auth/login/domain/error/login_errors.dart';
import 'package:surf_app/modules/auth/login/domain/repositories/i_login_repository.dart';
import 'package:surf_app/modules/auth/login/presenter/usecases/i_login_usecase.dart';

@Injectable(as: ILoginUseCase)
class LoginUseCase implements ILoginUseCase {
  final ILoginRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<LoginError, Unit>> loginUser(
      String email, String password) async {
    var res = await _repository.login(email, password);
    return res.fold((l) => left(l), (r) => right(unit));
  }
}
