import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_app/modules/home/domain/entities/user_id.dart';
import 'package:surf_app/modules/home/domain/errors/get_user_info_errors.dart';
import 'package:surf_app/modules/home/domain/repositories/i_get_user_info_repository.dart';
import 'package:surf_app/modules/home/presenter/usecases/i_home_usercase.dart';

@Injectable(as: IHomeUseCase)
class HomeUseCase extends IHomeUseCase {
  final IGetUserInfosRepository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<GetUserInfoError, UserId>> getUserInfromations() async {
    var res = await _repository.getUserInfo();
    return res.fold((l) => left(l), (r) => right(r));
  }
}
