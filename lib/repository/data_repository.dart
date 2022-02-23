import 'dart:convert';

import 'package:pickit_challenge/models/models.dart';
import 'package:pickit_challenge/network/data_provider.dart';

/// El repositorio es un intermediadio ente la api y el state
/// decide si tomar los datos desde el backend o localmente

class DataRepository {
  // api provider instance
  final DataProvider _dataProvider = DataProvider();

  /////// get all clients
  Future<List<Cliente>> fetchFirebaseData({required String path}) async {

    // get data
    var response = await _dataProvider.getApi(path);

    // clients list
    List<Cliente> clients = [];

    // parseamos el json y lo agregamos a la lista de clientes
    response == null
    ? response = {"": ""}
    : response.forEach((key, value) {
        clients.add(Cliente.fromJson(value));
      });

    return clients; 
  }

  /////// create and update data
  Future putFirebaseApi({required Cliente client}) async {    

    _dataProvider.putApi(jsonEncode(client.toJson()), client.dni);
  }

  /////// delete data
  Future deleteFirebaseApi({required String path}) async {
    _dataProvider.deleteApi(path);
  }
}
