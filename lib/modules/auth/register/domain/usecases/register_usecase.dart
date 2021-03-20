import 'package:dartz/dartz.dart';
import 'package:surf_app/modules/auth/register/domain/error/register_errors.dart';
import 'package:surf_app/modules/auth/register/domain/repositories/i_register_repository.dart';
import 'package:surf_app/modules/auth/register/presenter/usecase/i_register_usecase.dart';

class Register implements IRegisterUseCase {
  final IRegisterUserRepository _repository;

  Register(this._repository);

  @override
  Future<Either<RegisterErrors, Unit>> registerUser(
      String name, String email, String password) async {
    var res = await _repository.registerUser(name, email, password);
    return res.fold((l) => left(l), (r) => right(r));
  }
}
