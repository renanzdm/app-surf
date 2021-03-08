abstract class GetUserInfoError {}

class ErrorInGetUser extends GetUserInfoError {
  final String error;

  ErrorInGetUser({this.error});
}

class ErrorInServer extends GetUserInfoError {
  final String error;

  ErrorInServer({this.error});
}
