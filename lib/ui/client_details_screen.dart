import 'package:flutter/material.dart';
import 'package:pickit_challenge/ui/styles/styles.dart';
import 'package:pickit_challenge/ui/widgets/car_card.dart';
import 'package:pickit_challenge/ui/widgets/item_tile.dart';
import 'package:provider/provider.dart';

import 'package:pickit_challenge/models/models.dart';
import 'package:pickit_challenge/state/state.dart';
import 'package:pickit_challenge/ui/widgets/alert_text.dart';
import 'package:pickit_challenge/ui/widgets/client_options_menu.dart';

class ClientDetailsScreen extends StatelessWidget {

  const ClientDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    /// get selectedClient
    final _appState = Provider.of<AppState>(context);
    final Cliente client = _appState.selectedClient;

    return Scaffold(
      //
      /// options button
      floatingActionButton: const ClientOptionsMenu(),

      /// appbar
      appBar: AppBar(
        title: const Text('Ficha del cliente'),
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, '/'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),

      /// body
      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

             /// BUILD CLIENT INFO
            Card(
              color:kOrange.withOpacity(0.7),
              shape: roundedBorders(),
              child: Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Column(
                  children: [
                    ItemTile(title: 'Nombre', text: client.nombre),
                    const Divider(),
                    ItemTile(title: 'Apellido', text: client.apellido),
                    const Divider(),
                    ItemTile(title: 'DNI', text: client.dni),
                    const Divider(),
                    ItemTile(title: 'Autos registrados', text: client.autos!.isEmpty ? '0' : client.autos!.length.toString()),
                  ],
                ),
              ),
            ),            

            /// BUILD CARS LIST
            client.autos!.isEmpty
            ? const AlertText(text: 'No hay autos aún')
            : ListView.builder(
                shrinkWrap: true,
                itemCount: client.autos!.length,
                physics: const NeverScrollableScrollPhysics(),

                itemBuilder: (BuildContext context, int index) {
                  // get plate number
                  String patente = client.autos!.keys.elementAt(index);

                  return CarCard(car: client.autos![patente]!);

                },
              ),
          ],
        ),
      ),
    );
  }
}




