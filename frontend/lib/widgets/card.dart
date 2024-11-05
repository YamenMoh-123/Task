import 'package:flutter/material.dart';
import 'package:frontend/pages/expanded.dart';
import '../models/item.dart';

class CardItem extends StatefulWidget {
  final int id;
  final String title;
  final String itemType;
  final double rating;
  final String progress;
  final bool favourite;
  final Map<String, dynamic> optionalDetails;
  final Map<String, dynamic> details;

  const CardItem({super.key, required this.id, required this.title, required this.itemType, required this.details,
    required this.rating, required this.progress,
    required this.favourite, required this.optionalDetails});


  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {

  void handleCardTap(BuildContext context) {

    Item curItem = Item(
        id: widget.id,
        title: widget.title,
        itemType: widget.itemType,
        details: widget.details,
        rating: widget.rating,
        progress: widget.progress,
        favourite: widget.favourite,
        optionalDetails: widget.optionalDetails
    );
    
    Navigator.of(context).push(
     MaterialPageRoute(builder: (context)=> ExpandedItem(item: curItem))
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
            subtitle:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(widget.details['author'] ?? "Unkown Author"),
                Text(widget.progress),
              ],
            ),
            trailing: Text(widget.rating.toString()),
      ),
    )
    );
  }
}
