import 'package:flutter/material.dart';
import 'package:pickit_challenge/models/models.dart';
import 'package:pickit_challenge/ui/styles/styles.dart';

////////////////////////////////////////////
/// REUSABLE CLIENT CARD ///
////////////////////////////////////////////

class ClientCard extends StatelessWidget {
  const ClientCard({Key? key, required this.client}) : super(key: key);

  final Cliente client;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:const  CircleAvatar(
        child: Icon(Icons.person, color: kOrange),
        backgroundColor: Colors.white,
      ),
      title: Text(
        '${client.apellido}, ${client.nombre}',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      subtitle: Text('DNI: ${client.dni}'),
      trailing: const Icon(Icons.arrow_forward_ios),
      tileColor: kOrange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
