abstract class RegisterErrors {}

class RegisterErrorValidation extends RegisterErrors {
  final List<String>? error;

  RegisterErrorValidation({this.error});
}

class RegisterErrorServer extends RegisterErrors {
  final String? message;

  RegisterErrorServer({this.message});
}

class RegisterErrorEmailInUse extends RegisterErrors {}
