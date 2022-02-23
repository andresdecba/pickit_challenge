class CustomException implements Exception {

  final String? _message;
  final String? _messagePrefix;
  final int? _code;

  CustomException([this._messagePrefix, this._message, this._code]); // [] = optionals and POSITIONALS params

  String? get message => _message;
  String? get prefix => _messagePrefix;
  int? get code => _code;

  @override
  String toString() {
    return "$_messagePrefix $_message $_code";
  }
}

////////////////////////////////////////////
/// EXCEPTIONS ///
////////////////////////////////////////////

class FetchDataException extends CustomException {
  FetchDataException({message}) : super("Error", message, 400);
}

class UnauthorizedException extends CustomException {
  UnauthorizedException({message}) : super("Unauthorized", message, 401);
}

class NotFoundException extends CustomException {
  NotFoundException({message}) : super("Not found", message, 404);
}

class GoneException extends CustomException {
  GoneException({message}) : super("Invalid Request", message, 410);
}

class InternalServerException extends CustomException {
  InternalServerException({message}) : super("Internal Server Error", message, 500);
}

class UnspecifiedException extends CustomException {
  UnspecifiedException({message, statusCode}) : super("Unspecified error", message, statusCode);
}
