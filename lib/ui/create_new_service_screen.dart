import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:pickit_challenge/models/models.dart';

import 'package:pickit_challenge/state/state.dart';
import 'package:pickit_challenge/ui/styles/styles.dart';
import 'package:provider/provider.dart';

class CreateNewServiceScreen extends StatefulWidget {
  const CreateNewServiceScreen({Key? key, required this.carPlate}) : super(key: key);
  final String carPlate;
  @override
  State<CreateNewServiceScreen> createState() => _CreateNewServiceScreenState();
}

class _CreateNewServiceScreenState extends State<CreateNewServiceScreen> {

  ////////////////////////////////////////////
  /// CREATE A NEW SERVICE ///
  ////////////////////////////////////////////
  Service newService = Service(
    fecha: '00-00-00',
    aceite: false,
    correa: false,
    filtro: false,
  );

  @override
  Widget build(BuildContext context) {

    // state
    final _appState = Provider.of<AppState>(context);

    return Scaffold(
      //
      /// appbar
      appBar: AppBar(
        title: const Text('Agregar un nuevo service'),
      ),

      /// save button
      floatingActionButton: FloatingActionButton(
        
        onPressed: () async {

          // create date and set in newService
          final _date = formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy, '-', HH, ':', nn, ':', ss]);
          newService.fecha = _date;

          // save new service and navigate
          await _appState.addNewService(service: newService, carPlate: widget.carPlate );
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),

      /// body
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          _ServiceItem(
            texto: 'Correa',
            item: Switch(
              activeColor: Colors.black,            
              value: newService.correa,
              onChanged: (value) {
                setState(() {
                  newService.correa = value;
                });
              },
            ),
          ),

          _ServiceItem(
            texto: 'Filtro',
            item: Switch(
              activeColor: Colors.black,            
              value: newService.filtro,
              onChanged: (value) {
                setState(() {
                  //_filtroIsSwitched = value;
                  newService.filtro = value;
                });
              },
            ),
          ),

          _ServiceItem(
            texto: 'Aceite',
            item: Switch(
              activeColor: Colors.black,            
              value: newService.aceite,
              onChanged: (value) {
                setState(() {
                  //_filtroIsSwitched = value;
                  newService.aceite = value;
                });
              },
            ),
          )
          
        ],
      ),
    );
  }
}

class _ServiceItem extends StatefulWidget {

  _ServiceItem({Key? key, required this.texto, required this.item}) : super(key: key);
  final String texto;
  Widget item;
  @override
  State<_ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<_ServiceItem> {

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(kPadding),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: kOrange,
        borderRadius: BorderRadius.circular(kBorderRdius)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.texto, style: const TextStyle(color: Colors.white, fontSize: 16),),
          widget.item,
        ],
      ),
    );
  }
}