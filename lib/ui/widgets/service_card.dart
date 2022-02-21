import 'package:flutter/material.dart';
import 'package:pickit_challenge/ui/styles/styles.dart';
import 'package:provider/provider.dart';

import 'package:pickit_challenge/models/models.dart';
import 'package:pickit_challenge/state/state.dart';

////////////////////////////////////////////
/// REUSABLE SERVICE CARD INFO ///
////////////////////////////////////////////

class ServiceCard extends StatelessWidget {
  const ServiceCard({Key? key, required this.service, required this.plateNbr}) : super(key: key);
  final Service service;
  final String plateNbr;

  @override
  Widget build(BuildContext context) {

    final appState = Provider.of<AppState>(context);

    var green = const  Icon(Icons.check, color: Colors.green);
    var red = const  Icon(Icons.close, color: Colors.red);

    return Stack(children: [
      Card(
        color: kGrey.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _ItemTile(title: 'Fecha', element: Text(service.fecha, style: const TextStyle(fontWeight: FontWeight.bold))),
              _ItemTile(title: 'Correa', element: service.correa == true ? green : red),
              _ItemTile(title: 'Filtro', element: service.filtro == true ? green : red),
              _ItemTile(title: 'Aceite', element: service.aceite == true ? green : red),
            ],
          ),
        ),
      ),
      Positioned(
        right: 0,
        child: IconButton(
          onPressed: () => appState.deleteService(plateNbr: plateNbr, date: service.fecha),
          icon: const Icon(Icons.delete_forever),
        ),
      )
    ]);
  }
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({Key? key, required this.title, required this.element}) : super(key: key);

  final String title;
  final Widget element;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text('$title:  '),
          element,
        ],
      ),
    );
  }
}