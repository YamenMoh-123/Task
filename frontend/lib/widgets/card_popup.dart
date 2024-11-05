import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../providers/user_provider.dart';
import '../services/api_crud.dart';

class CardDialog extends StatefulWidget {

  final Item? item;
  final Function(Item) onItemSaved;
  const CardDialog({super.key, this.item, required this.onItemSaved});

  @override
  State<CardDialog> createState() => _CardDialogState();
}

class _CardDialogState extends State<CardDialog> {
  late Map<String, String> formData;

  TextEditingController? titleController;
  TextEditingController? ratingController;
  TextEditingController? progressController;

  @override
  void initState() {
    super.initState();
    formData = {
      'title': widget.item?.title ?? '',
      'rating': widget.item?.rating.toString() ?? '',
      'progress': widget.item?.progress ?? '',
      'favourite': widget.item?.favourite.toString() ?? 'false',
    };

    titleController = TextEditingController(text: formData['title']);
    ratingController = TextEditingController(text: formData['rating']);
    progressController = TextEditingController(text: formData['progress']);
    }

  @override
  void dispose() {
    titleController?.dispose();
    ratingController?.dispose();
    progressController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    int userId = int.parse(userProvider.user.userId);

    return AlertDialog(
      title: Text(widget.item == null ? "Add Item" : "Edit Item"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if(widget.item == null)
            TextField(
              decoration: const InputDecoration(labelText: "Title"),
              onChanged: (value) => setState(() => formData['title'] = value),
              controller: titleController,
            ) ,

          TextField(
            decoration: const InputDecoration(labelText: "Rating"),
            onChanged: (value) => setState(() => formData['rating'] = value),
            controller: ratingController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Progress"),
            onChanged: (value) => setState(() => formData['progress'] = value),
            controller: progressController,
          ),

             CheckboxListTile(
            title: const Text("Favourite"),
              value: formData['favourite'] == 'true',
              onChanged: (bool? value) {
              setState(() {
                formData['favourite'] = value.toString();
              });
            })


        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("Save"),
          onPressed: () async {
            if (!mounted) return;

            if (widget.item == null) {

              try {
                if(formData['title'] == null || formData['rating'] == null || formData['progress'] == null) {
                  print("MISSING INFO");
                  return;
                }

                Item newItem = await ApiCrud().addItem(formData, context);
                if (!mounted) return;
                widget.onItemSaved(newItem);
                Navigator.of(context).pop();
              } catch (e) {
                //
              }
            } else {
                // Editing an existing item
              var toSend = {
                'user': userId,
                'item': widget.item!.id,
                'rating': formData['rating'],
                'progress': formData['progress'],
                'favourite': formData['favourite'],
                'optional_details': {},
              };

                var updatedItem = await ApiCrud().editItem(userId, toSend);
                if (!mounted) return;
                widget.item!.updateWith(updatedItem);
                widget.onItemSaved(widget.item!);
                Navigator.of(context).pop();
              }

            }
        ),
      ],
    );
  }
}
