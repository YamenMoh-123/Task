import 'package:flutter/material.dart';
import '../models/item.dart';

class ExpandedItem extends StatefulWidget {

  final Item item;
  const ExpandedItem({super.key, required this.item});

  @override
  State<ExpandedItem> createState() => _ExpandedItemState();
}

class _ExpandedItemState extends State<ExpandedItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
      ),
      body: const Center(
        child: Text('Expanded Item'),
      ),
    );
  }
}
