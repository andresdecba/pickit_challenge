import 'package:flutter/material.dart';
import 'package:pickit_challenge/ui/styles/styles.dart';

class AlertText extends StatelessWidget {

  const AlertText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {


    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kGrey,
        borderRadius: BorderRadius.circular(kBorderRdius)
      ),
      child: Column(
        children: [
          const Text(':(', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black54),),
          const SizedBox(height: 10,),
          Text(text),
        ],
      ),
    );

  }
}