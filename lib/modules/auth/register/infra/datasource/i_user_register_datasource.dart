abstract class IUserRegisterDatasource {
  Future<void> saveUser(String name, String email, String password);
}
