import 'package:flutter/material.dart';
import 'package:pickit_challenge/ui/styles/styles.dart';
import 'package:provider/provider.dart';

import 'package:pickit_challenge/models/models.dart';
import 'package:pickit_challenge/ui/widgets/service_card.dart';
import 'package:pickit_challenge/state/state.dart';
import 'package:pickit_challenge/ui/create_new_service_screen.dart';
import 'package:pickit_challenge/ui/widgets/alert_text.dart';
import 'package:pickit_challenge/ui/widgets/item_tile.dart';

////////////////////////////////////////////
/// REUSABLE CAR CARD INFO ///
////////////////////////////////////////////

class CarCard extends StatelessWidget {
  const CarCard({Key? key, required this.car}) : super(key: key);
  final Auto car;

  @override
  Widget build(BuildContext context) {
    //
    /// get car
    final appState = Provider.of<AppState>(context);

    return Card(
      color: kGrey,
      shape: roundedBorders(),
      child: Stack(
        children: [
          Column(
            children: [
              //// nro patente
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  car.patente,
                  style: const TextStyle(fontSize: 24),
                ),
              ),

              /// info del auto
              Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Column(
                  children: [
                    ItemTile(title: 'Marca', text: car.marca),
                    ItemTile(title: 'Modelo', text: car.modelo),
                    ItemTile(title: 'Services', text: car.historial!.isEmpty ? '0' : car.historial!.length.toString()),
                    const SizedBox(height: 10),

                    /// check if null and build CAR SERVICES HISTORIAL
                    car.historial!.isEmpty

                        ? const AlertText(text: 'No hay services aún')
                        
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: car.historial!.length,
                            reverse: true,
                            /// BUILD SERVICES LIST
                            itemBuilder: (BuildContext context, int index) {
                              // get historial keys
                              String fecha = car.historial!.keys.elementAt(index);

                              return ServiceCard(
                                service: car.historial![fecha]!,
                                plateNbr: car.patente,
                              );
                            },
                          ),

                    const Divider(),            
                  ],
                ),
              ),
            ],
          ),

          ////////////////////////////////////////////
          /// ADD A SERVICE and DELETE CAR BUTTONS ///
          ////////////////////////////////////////////

          Positioned(
            right: 0,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_box),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateNewServiceScreen(carPlate: car.patente)),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: () => appState.deleteCar(car: car),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
