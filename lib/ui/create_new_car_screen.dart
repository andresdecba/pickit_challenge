import 'package:flutter/material.dart';
import 'package:pickit_challenge/models/models.dart';
import 'package:pickit_challenge/state/state.dart';
import 'package:pickit_challenge/ui/styles/input_decorations.dart';
import 'package:pickit_challenge/ui/styles/styles.dart';
import 'package:provider/provider.dart';

class CreateNewCarScreen extends StatefulWidget {
  const CreateNewCarScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<CreateNewCarScreen> createState() => _CreateNewCarScreenState();
}

class _CreateNewCarScreenState extends State<CreateNewCarScreen> {
  //
  ////////////////////////////////////////////
  /// CREATE A NEW CAR ///
  ////////////////////////////////////////////
  Auto newCar = Auto(
    marca: "marca x",
    modelo: "modelo x",
    patente: "patente x",
    historial: {}
  );

  /// Controllers
  final _plateController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    /// state
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      //
      /// save button
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {

          await appState.addNewCar(car: newCar);
          Navigator.pop(context);
        },
      ),

      /// appbar
      appBar: AppBar(
        title: const Text('Agregar un auto'),
      ),

      /// body
      body: ListView(
        
        padding: const EdgeInsets.all(kPadding),

        children: [


          Form(
          key: appState.newCarFormKey,
          child: Column(
            children: [
              //
              /// PATENTE
              TextFormField(
                controller: _plateController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                decoration: inputDecoration(controller: _plateController, hintText: 'Patente'),
                onChanged: (value) => setState(() => newCar.patente = value.toUpperCase()),
              ),
              const SizedBox(height: 10),
      
              ///  MARCA
              TextFormField(
                controller: _brandController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                decoration: inputDecoration(controller: _brandController, hintText: 'Marca'),
                onChanged: (value) => setState(() => newCar.marca = value),
              ),
              const SizedBox(height: 10),
      
              /// MODELO
              TextFormField(
                controller: _modelController,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                decoration: inputDecoration(controller: _modelController, hintText: 'Modelo'),
                onChanged: (value) => setState(() => newCar.modelo = value),
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