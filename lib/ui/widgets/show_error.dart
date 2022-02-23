import 'package:flutter/material.dart';
import 'package:pickit_challenge/state/state.dart';
import 'package:pickit_challenge/ui/styles/styles.dart';
import 'package:provider/provider.dart';

class CartelitoError extends StatelessWidget {
  const CartelitoError({
    Key? key,
    required this.prefix,
    required this.message,
    required this.codigo,
  }) : super(key: key);

  final String prefix;
  final String message;
  final int codigo;

  @override
  Widget build(BuildContext context) {
    /// app state
    final appState = Provider.of<AppState>(context);

    return Container(
      height: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 40, color: kGrey),
          const SizedBox(height: 5),
          Text('$codigo: $prefix'),
          const SizedBox(height: 5),
          Text(message, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => appState.getClients(),
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}
