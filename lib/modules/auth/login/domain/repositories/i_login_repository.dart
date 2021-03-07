import 'package:dartz/dartz.dart';
import 'package:surf_app/modules/auth/login/domain/entities/user.dart';
import 'package:surf_app/modules/auth/login/domain/error/login_errors.dart';

abstract class ILoginRepository {
  Future<Either<LoginError, Unit>> login(String email,String password);
}
