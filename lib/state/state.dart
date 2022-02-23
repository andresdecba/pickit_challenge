import 'package:flutter/material.dart';
import 'package:pickit_challenge/models/models.dart';
import 'package:pickit_challenge/network/custom_exception.dart';
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
  final DataRepository _dataRepository = DataRepository();

  /// errors GET and SET
  CustomException? _exception;
  CustomException? get exception => _exception;
  _setFailure(CustomException value) {
    _exception = value;
    _setDataState(Status.error);
  }

  /// data state GET and SET
  Status _dataState = Status.loading;
  Status get dataState => _dataState;
  _setDataState(Status value) {
    _dataState = value;
    notifyListeners();
  }

  ////////////////////////////////////////////
  /// GET CLIENTS ///
  ////////////////////////////////////////////

  Future getClients() async {
    _setDataState(Status.loading);
    try {
      clientsList = await _dataRepository.fetchFirebaseData(path: "clientes.json");
      _setDataState(Status.completed);
    } on CustomException catch (e) {
      _setFailure(e);
    }
    notifyListeners();
  }

  ////////////////////////////////////////////
  /// ADD THINGS ///
  ////////////////////////////////////////////

  Future createNewClient() async {
    try {
      await _dataRepository.putFirebaseApi(client: selectedClient);
      await getClients();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future addNewCar({required Auto car}) async {
    try {
      // 1.agregar nuevo auto al 'selectedClient', 2.actualizar el backend
      selectedClient.autos?.addAll({car.patente: car});
      await _dataRepository.putFirebaseApi(client: selectedClient);
    } catch (e) {
      print('error $e');
    }
    notifyListeners();
  }

  Future addNewService({required String carPlate, required Service service}) async {
    try {
      // 1.agregar nuevo servicio al 'selectedClient',  2.actualizar el backend
      selectedClient.autos![carPlate]!.historial!.addAll({service.fecha: service});
      await _dataRepository.putFirebaseApi(client: selectedClient);
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
      await _dataRepository.deleteFirebaseApi(path: selectedClient.dni);
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
      await _dataRepository.deleteFirebaseApi(path: '${selectedClient.dni}/autos/${car.patente}');
    } catch (e) {
      print('error $e');
    }
    notifyListeners();
  }

  Future deleteService({required String plateNbr, required String date}) async {
    try {
      // 1. borrar service en 'selectedClient',  2.actualizar el backend
      selectedClient.autos![plateNbr]!.historial!.remove(date);
      await _dataRepository.deleteFirebaseApi(path: '${selectedClient.dni}/autos/$plateNbr/historial/$date');
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
