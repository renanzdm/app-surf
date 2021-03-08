import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_app/modules/home/domain/entities/user_id.dart';
import 'package:surf_app/modules/home/domain/errors/get_user_info_errors.dart';
import 'package:surf_app/modules/home/domain/repositories/i_get_user_info_repository.dart';
import 'package:surf_app/modules/home/infra/datasources/i_get_user_infos_datasource.dart';

@Injectable(as: IGetUserInfosRepository)
class GetUserInfosRepository implements IGetUserInfosRepository {
  final IGetUserInfosDataSource _dataSource;

  GetUserInfosRepository(this._dataSource);

  @override
  Future<Either<GetUserInfoError, UserId>> getUserInfo() async {
    try {
      var user = await _dataSource.getUserInfos();
      return right(user);
    } on GetUserInfoError catch (e) {
      return left(e);
    } catch (e) {
      return left(ErrorInServer(error: e));
    }
  }
}
