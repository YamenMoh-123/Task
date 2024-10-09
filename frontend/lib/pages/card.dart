import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  const CardItem({super.key});

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        leading: Image.asset("assets/images/test.png"),
        title: const Text('The Enchanted Nightingale'),
        subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }
}
