import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:pickit_challenge/network/custom_exception.dart';

class DataProvider {
  /// build URL
  static const String _url = 'pickit-challenge-default-rtdb.firebaseio.com';

  ////////////////////////////////////////////
  /// GET ///
  ////////////////////////////////////////////

  Future<dynamic> getApi(String _path) async {
    //
    try {
      final uri = Uri.https(_url, _path);
      var response = await http.get(uri);
      return _response(response);
    } on SocketException {
      throw UnspecifiedException(message: 'no hay internet');
    }
  }

  ////////////////////////////////////////////
  /// PUT ///
  ////////////////////////////////////////////

  Future putApi(String client, String path) async {
    try {
      final uri = Uri.https(_url, 'clientes/$path.json');
      final response = await http.put(uri, body: client);
    } on SocketException {
      throw UnspecifiedException;
    }
  }

  ////////////////////////////////////////////
  /// DELETE ///
  ////////////////////////////////////////////

  Future deleteApi(String path) async {
    try {
      final uri = Uri.https(_url, 'clientes/$path.json');
      final response = await http.delete(uri);
    } on SocketException {
      throw UnspecifiedException;
    }
  }

  ////////////////////////////////////////////
  /// EXCEPTIONS ///
  ////////////////////////////////////////////

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw FetchDataException(message: 'Falla durante la comunicación');
      case 401:
        throw UnauthorizedException(message: 'No está autorizado');
      case 404:
        throw NotFoundException(message: 'No se pudo encontrar la información');
      case 410:
        throw GoneException(message: 'La información ya no existe');
      case 500:
        throw InternalServerException(message: 'Error del servidor');
      default:
        throw UnspecifiedException(message: 'Error desconocido', statusCode: response.statusCode);
    }
  }
}
