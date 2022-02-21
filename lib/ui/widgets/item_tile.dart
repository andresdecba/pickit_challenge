import 'package:flutter/material.dart';

////////////////////////////////////////////
/// REUSABLE ITEM TIME ///
////////////////////////////////////////////

class ItemTile extends StatelessWidget {
  const ItemTile({Key? key, required this.title, this.text = ''}) : super(key: key);

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text('$title:  '),
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
        ],
      ),
    );
  }
}