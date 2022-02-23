import 'package:flutter/material.dart';
import 'package:pickit_challenge/ui/styles/styles.dart';
import 'package:pickit_challenge/ui/widgets/show_error.dart';
import 'package:provider/provider.dart';

import 'package:pickit_challenge/models/models.dart';
import 'package:pickit_challenge/state/state.dart';
import 'package:pickit_challenge/ui/widgets/client_card.dart';

class ClientsListScreen extends StatelessWidget {
  const ClientsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    /// app state
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      //
      /// appBar
      appBar: AppBar(
        title: const Text('Listado de clientes'),
        elevation: 0,
      ),

      /// add new client button
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: kOrange,
        onPressed: () {
          ////////////////////////////////////////////
          /// WHEN PRESS, CREATE A NEW CLIENT ///
          ////////////////////////////////////////////
          appState.selectedClient = Cliente(
            apellido: "lastname x",
            nombre: "name x",
            dni: "xxx",
            autos: {},
          );

          Navigator.pushNamed(context, 'createNewClientScreen');
        },
      ),

      /// body
      body: _Mostrar(),
    );
  }
}

class _Mostrar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, _) {
      switch (appState.dataState) {
        case Status.loading:
          return const Center(child: CircularProgressIndicator());
        case Status.completed:
          return const _CargarClientes();
        case Status.error:
          return CartelitoError(
            prefix: appState.exception!.prefix!,
            message: appState.exception!.message!,
            codigo: appState.exception!.code!,
          );
        default:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}

class _CargarClientes extends StatelessWidget {
  const _CargarClientes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return ListView(
      padding: const EdgeInsets.all(20),
      physics: const ScrollPhysics(),
      children: [
        ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 5),
          itemCount: appState.clientsList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                // acá guardamos los datos del cliente elegido en "selectedClient"
                // para poder editarlos sin alterar la lista original que llegó desde el backend,
                // por eso creamos una instancia nueva con "copy()" para romper la referencia al objeto original de la lista
                appState.selectedClient = appState.clientsList[index].copy();
                Navigator.pushNamed(context, 'ClientDetailsScreen');
              },
              child: ClientCard(client: appState.clientsList[index]),
            );
          },
        )
      ],
    );
  }
}
