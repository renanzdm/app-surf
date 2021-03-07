import 'package:dartz/dartz.dart';
import 'package:surf_app/modules/auth/register/domain/error/register_errors.dart';

abstract class IRegisterUseCase {
  Future<Either<RegisterErrors, Unit>> registerUser(
      String name, String email, String password);
}
