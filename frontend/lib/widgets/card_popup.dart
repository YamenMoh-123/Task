import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/api_crud.dart';

class cardDialog extends StatefulWidget {

  final Item? item;
  final Function(Item) onItemSaved;
  const cardDialog({Key? key, this.item, required this.onItemSaved}) : super(key: key);

  @override
  State<cardDialog> createState() => _cardDialogState();
}

class _cardDialogState extends State<cardDialog> {
  late Map<String, String> formData;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      formData = {
        'title': widget.item!.title,
        'rating': widget.item!.rating,
        'author': widget.item!.author,
      };
    } else {
      formData = {
        'title': '',
        'rating': '',
        'author': '',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.item == null ? "Add Item" : "Edit Item"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            decoration: const InputDecoration(labelText: "Title"),
            onChanged: (value) => setState(() => formData['title'] = value),
            controller: widget.item != null ? TextEditingController(text: formData['title']) : null,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Rating"),
            onChanged: (value) => setState(() => formData['rating'] = value),
            controller: widget.item != null ? TextEditingController(text: formData['rating']) : null,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Author"),
            onChanged: (value) => setState(() => formData['author'] = value),
            controller: widget.item != null ? TextEditingController(text: formData['author']) : null,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("Save"),
          onPressed: () async {
            if (widget.item == null) {
              try {
                Item newItem = await ApiCrud().addItem(formData);
                widget.onItemSaved(newItem);
                Navigator.of(context).pop();
              } catch (e) {
              }
            } else {
              // Editing an existing item
              widget.item!.title = formData['title']!;
              widget.item!.rating = formData['rating']!;
              widget.item!.author = formData['author']!;
              ApiCrud().editItem(widget.item!);
              widget.onItemSaved(widget.item!);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
