import 'package:flutter/material.dart';
import 'package:pickit_challenge/ui/styles/styles.dart';
import 'package:provider/provider.dart';

import 'package:pickit_challenge/state/state.dart';
import 'package:pickit_challenge/ui/styles/input_decorations.dart';

class CreateNewClientScreen extends StatefulWidget {
  const CreateNewClientScreen({Key? key}) : super(key: key);
  @override
  State<CreateNewClientScreen> createState() => _CreateNewClientScreenState();
}

class _CreateNewClientScreenState extends State<CreateNewClientScreen> {
  /// forms controllers
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _dniController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      //
      /// save button
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          // 1. enviamos el nvo cliente al backend
          await appState.createNewClient();

          // 2. destruimos esta pagina y navegamos a la pantalla del cliente detalles
          Navigator.pushNamedAndRemoveUntil(context, 'ClientDetailsScreen', (route) => false);
        },
      ),

      /// appbar
      appBar: AppBar(
        title: const Text('Crear nuevo cliente'),
      ),

      /// body
      body: ListView(

        padding: const EdgeInsets.all(kPadding),
        children: [
          Form(
            key: appState.newClientFormKey,
            child: Column(
              children: [
                /// CREATE NAME
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  decoration: inputDecoration(controller: _nameController, hintText: 'Nombre'),
                  onChanged: (value) => setState(() => appState.selectedClient.nombre = value),

                  /// guardar valor
                ),
                const SizedBox(height: 10),

                /// CREATE LASTNAME
                TextFormField(
                  controller: _lastnameController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  decoration: inputDecoration(controller: _lastnameController, hintText: 'Apellido'),
                  onChanged: (value) => setState(() => appState.selectedClient.apellido = value),

                  /// guardar valor
                ),
                const SizedBox(height: 10),

                /// CREATE DNI
                TextFormField(
                  controller: _dniController,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  decoration: inputDecoration(controller: _dniController, hintText: 'DNI'),
                  onChanged: (value) => setState(() => appState.selectedClient.dni = value),

                  /// guardar valor
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// extension StringExtension on String {
//     String capitalize() {
//       return "${this[0].toUpperCase()}${this.substring(1)}";
//     }
// }