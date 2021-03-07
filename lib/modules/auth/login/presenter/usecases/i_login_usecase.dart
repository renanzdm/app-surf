import 'package:dartz/dartz.dart';
import 'package:surf_app/modules/auth/login/domain/error/login_errors.dart';

abstract class ILoginUseCase {
  Future<Either<LoginError, Unit>> loginUser(String email, String password);
}
