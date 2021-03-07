import 'package:dartz/dartz.dart';
import 'package:surf_app/modules/auth/login/domain/entities/user.dart';

abstract class IHomeUseCase {
  Future<Either<Exception, User>> getUserInfromations();
}
