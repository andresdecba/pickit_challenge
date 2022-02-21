import 'package:flutter/material.dart';
import 'package:pickit_challenge/models/models.dart';
import 'package:pickit_challenge/repository/data_repository.dart';

/// tipos de estados posibles
enum Status { loading, completed, error }

class AppState extends ChangeNotifier {
  //
  // constructor: iniciar obteniendo los datos
  AppState() {
    getClients();
  }

  /// clients list the FROM BACKEND
  List<Cliente> clientsList = [];

  /// temporary property to store the data BEFORE upload the backend
  late Cliente selectedClient;

  /// datarepository instance
  final DataRepository dataRepository = DataRepository();

  /// error messages
  String error = '';

  ////////////////////////////////////////////
  /// GET CLIENTS ///
  ////////////////////////////////////////////

  Status estado = Status.loading;
  resetState() => estado = Status.loading;

  Future getClients() async {
    try {

      clientsList.clear();
      var newwww = await dataRepository.fetchFirebaseData(path: "clientes.json");
      clientsList.addAll(newwww);
      estado = Status.completed;
      //notifyListeners();

    } catch (e) {
      error = e.toString();
      estado = Status.error;
    }
    notifyListeners();
    resetState;

    print(clientsList);
  }

  ////////////////////////////////////////////
  /// ADD THINGS ///
  ////////////////////////////////////////////

  Future createNewClient() async {
    try {
      // 1. mandar al backend, 2. actualizar la lista en memoria
      await dataRepository.putFirebaseApi(client: selectedClient);
      await getClients();
      notifyListeners();
    } catch (e) {
      print('error $e');
    }
    notifyListeners();
  }

  Future addNewCar({required Auto car}) async {
    try {
      // 1.agregar nuevo auto al 'selectedClient', 2.actualizar el backend
      selectedClient.autos?.addAll({car.patente: car});
      await dataRepository.putFirebaseApi(client: selectedClient);
    } catch (e) {
      print('error $e');
    }
    notifyListeners();
  }

  Future addNewService({required String carPlate, required Service service}) async {
    try {
      // 1.agregar nuevo servicio al 'selectedClient',  2.actualizar el backend
      selectedClient.autos![carPlate]!.historial!.addAll({service.fecha: service});
      await dataRepository.putFirebaseApi(client: selectedClient);
    } catch (e) {
      print('error $e');
    }
    notifyListeners();
  }

  ////////////////////////////////////////////
  /// DELETE THINGS ///
  ////////////////////////////////////////////

  Future deleteClient() async {
    try {
      // 1. borrar el cliente en el backend, 2. actualizar la lista en memoria
      await dataRepository.deleteFirebaseApi(path: selectedClient.dni);
      await getClients();
    } catch (e) {
      print('error $e');
    }
    notifyListeners();
  }

  Future deleteCar({required Auto car}) async {
    try {
      // 1. borrar auto en 'selectedClient',  2.actualizar el backend
      selectedClient.autos!.remove(car.patente);
      await dataRepository.deleteFirebaseApi(path: '${selectedClient.dni}/autos/${car.patente}');
    } catch (e) {
      print('error $e');
    }
    notifyListeners();
  }

  Future deleteService({required String plateNbr, required String date}) async {
    try {
      // 1. borrar service en 'selectedClient',  2.actualizar el backend
      selectedClient.autos![plateNbr]!.historial!.remove(date);
      await dataRepository.deleteFirebaseApi(path: '${selectedClient.dni}/autos/$plateNbr/historial/$date');
    } catch (e) {
      print('error $e');
    }
    notifyListeners();
  }

  ////////////////////////////////////////////
  /// FORMS ///
  ////////////////////////////////////////////

  GlobalKey<FormState> newClientFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> newCarFormKey = GlobalKey<FormState>();

  bool validateCuentasFormKey() {
    return newClientFormKey.currentState?.validate() ?? false;
  }

  bool validateEditCuentasFormKey() {
    return newCarFormKey.currentState?.validate() ?? false;
  }
}
