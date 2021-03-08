import 'package:surf_app/modules/home/domain/entities/user_id.dart';

abstract class IGetUserInfosDataSource {
  Future<UserId> getUserInfos();
}
