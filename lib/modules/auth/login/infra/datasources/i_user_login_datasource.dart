abstract class IUserLoginDataSource {
  Future<void> loginUser(String email, String password);
}
