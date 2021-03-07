abstract class LoginError{}


class LoginErrorServer extends LoginError{
  final String message;

  LoginErrorServer({this.message});

}

class LoginErrorInvalidUserOrPassword extends LoginError{

}