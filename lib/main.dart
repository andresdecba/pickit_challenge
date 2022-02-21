import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pickit_challenge/ui/client_details_screen.dart';
import 'package:pickit_challenge/ui/create_new_car_screen.dart';
import 'package:pickit_challenge/ui/create_new_client_screen.dart';
import 'package:pickit_challenge/state/state.dart';
import 'package:pickit_challenge/ui/clients_list_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // inyectar el provider
    return ChangeNotifierProvider(
      
      create: (context) => AppState(), lazy: false,

      // app
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pickit App',
        initialRoute: '/',
        routes: {
          '/': (_) => const ClientsListScreen(),
          'ClientDetailsScreen': (context) => const ClientDetailsScreen(),
          'createNewClientScreen': (context) => const CreateNewClientScreen(),
          'createNewCarScreen': (context) => const CreateNewCarScreen (),
        },
      ),
    );
  }
}


/*
_scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: new Text('Something went wrong..'),
        duration: new Duration(seconds: 2),
      )
*/