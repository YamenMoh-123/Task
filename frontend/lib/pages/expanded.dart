import 'package:flutter/material.dart';
import '../models/item.dart';

class expandedItem extends StatefulWidget {

  final Item item;
  const expandedItem({super.key, required this.item});

  @override
  State<expandedItem> createState() => _expandedItemState();
}

class _expandedItemState extends State<expandedItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title as String),
      ),
      body: const Center(
        child: Text('Expanded Item'),
      ),
    );
  }
}
