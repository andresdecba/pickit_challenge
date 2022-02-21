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
      final response = await http.get(uri);
      return _response(response);
    } on SocketException {
      throw UnspecifiedException;
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

  dynamic _response (http.Response response) {

    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException();
      case 404:
        throw UnregisteredException();
      case 500:
        throw InternalException();
      default:
        throw UnspecifiedException('Error Communication, StatusCode: ${response.statusCode}');
    }
  }
}