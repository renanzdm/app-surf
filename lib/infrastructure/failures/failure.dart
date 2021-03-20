class Failure {
  final String? errorMessage;
  final int? code;
  final String? error;

  Failure({this.errorMessage, this.code, this.error});

  factory Failure.fromJsonError(Map<String, dynamic> json) {
    return Failure(
        code: json['code'],
        errorMessage: json['message'],
        error: json['error']);
  }
}
