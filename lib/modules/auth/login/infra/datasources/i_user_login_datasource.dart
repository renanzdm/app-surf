import 'package:surf_app/modules/auth/login/domain/entities/user.dart';

abstract class IUserLoginDataSource{
  Future<void> loginUser(String email, String password);
}