import 'package:flutter/material.dart';
import 'package:frontend/pages/expanded.dart';
import '../models/item.dart';

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

  void handleCardTap(BuildContext context) {
    //print('Card tapped: ${widget.id}');

    Item curItem = Item(
      id: widget.id,
      title: widget.title,
      rating: widget.rating,
      author: widget.author,
    );
    
    Navigator.of(context).push(
     MaterialPageRoute(builder: (context)=> expandedItem(item: curItem))
    );
  }


  @override
  Widget build(BuildContext context) {

    return InkWell(
        onTap: ()=> handleCardTap(context),
        child: Card(
          child: ListTile(
            leading: Image.asset("assets/images/test.png"),
            title: Text(widget.title),
            subtitle: Text(widget.author),
            trailing: Text(widget.rating),
      ),
    )
    );
  }
}
