class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix $_message";
  }
}

class UnspecifiedException extends CustomException {
  UnspecifiedException([message]) : super(message, "No hay más información disponible sobre este error $message.");
}

class BadRequestException extends CustomException {
  BadRequestException([message])
      : super(
            message, "(Código de error HTTP = 400) Los parámetros de la solicitud no eran válidos. Una extensión del tipo google.rpc.BadRequest se devuelve para especificar qué campo no era válida.");
}

class UnregisteredException extends CustomException {
  UnregisteredException([message])
      : super(message,
            "(Código de error HTTP = 404) Se anuló el registro de la instancia de la aplicación en FCM. Por lo general, esto significa que el token utilizado ya no es válido y se debe utilizar uno nuevo.");
}

class InternalException extends CustomException {
  InternalException([message]) : super(message, "(Código de error HTTP = 500) Ocurrió un error interno desconocido.");
}

class FetchDataException extends CustomException {
  FetchDataException([message]) : super(message, "No hay conexion a internet");
}
