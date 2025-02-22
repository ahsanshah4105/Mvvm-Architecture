class AppException implements Exception {
  final message;
  final prefix;
  AppException([this.message, this.prefix]);

  String toString() {
    return '$prefix$message';
  }
}

class FetchDataException extends AppException {
  FetchDataException({String? message})
    : super(message, "error during communication");
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException({String? message})
    : super(message, "error during communication");
}
