import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  final int id;
  final String title;
  final String rating;
  final String author;
  const CardItem({super.key, required this.id, required this.title, required this.rating, required this.author});


  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        leading: Image.asset("assets/images/test.png"),
        title: Text(widget.title),
        subtitle: Text(widget.author),
        trailing: Text(widget.rating),
      ),
    );
  }
}
