import 'package:flutter/material.dart';
import 'package:pickit_challenge/ui/styles/styles.dart';
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
      body: ListView(
        padding: const EdgeInsets.all(20),
        physics: const ScrollPhysics(),
        children: [
          /// if is loading
          appState.estado == Status.loading
              ? const _Loading(loadingMessage: 'Cargando datos...')

              /// if data is fetched
              : appState.estado == Status.completed
                  ? ListView.separated(
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

                  /// if error
                  : appState.estado == Status.error
                      ? _Error(errorMessage: appState.error, retry: () => appState.getClients())
                      : Container()
        ],
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key, required this.loadingMessage}) : super(key: key);
  final String loadingMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(loadingMessage),
          const SizedBox(height: 24),
          const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
        ],
      ),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({Key? key, required this.errorMessage, required this.retry}) : super(key: key);
  final String errorMessage;
  final Function retry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(errorMessage),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => retry,
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}
