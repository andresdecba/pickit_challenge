import 'package:flutter/material.dart';
import 'package:pickit_challenge/models/models.dart';
import 'package:pickit_challenge/ui/create_new_car_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pickit_challenge/state/state.dart';

class ClientOptionsMenu extends StatefulWidget {

  const ClientOptionsMenu({Key? key,}) : super(key: key);

  @override
  _ClientOptionsMenuState createState() => _ClientOptionsMenuState();
}

class _ClientOptionsMenuState extends State<ClientOptionsMenu> {
  @override
  Widget build(BuildContext context) {
    //
    /// get client
    final _appState = Provider.of<AppState>(context);
    final Cliente _client = _appState.selectedClient;

    return SpeedDial(
      icon: Icons.menu,
      backgroundColor: Colors.blue,
      overlayOpacity: 0.4,
      overlayColor: Colors.black45,
      children: [
        //
        /////////// edit ///////////
        SpeedDialChild(
          child: const Icon(Icons.edit),
          label: 'Editar información del cliente',
          backgroundColor: Colors.amberAccent,
          onTap: () => true,
        ),

        /////////// add a new car  ///////////
        SpeedDialChild(
          child: const Icon(Icons.car_rental),
          label: 'Agregar un auto nuevo',
          backgroundColor: Colors.amberAccent,


          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateNewCarScreen(),
            ),
          ),

          
        ),

        /////////// delete cliente ///////////
        SpeedDialChild(
          child: const Icon(Icons.delete_forever),
          label: 'Borrar este cliente',
          backgroundColor: Colors.amberAccent,
          onTap: () async {
            await _appState.deleteClient();
            Navigator.pushNamed(context, '/');
          },
        ),
      ],
    );
  }
}
