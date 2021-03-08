import 'package:dartz/dartz.dart';
import 'package:surf_app/modules/home/domain/entities/user_id.dart';
import 'package:surf_app/modules/home/domain/errors/get_user_info_errors.dart';

abstract class IHomeUseCase {
  Future<Either<GetUserInfoError, UserId>> getUserInfromations();
}
