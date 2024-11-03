import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/item.dart';


class ApiFetch {


  static const String _baseUrl = '192.168.11.139:8000';

  Future<List<Item>> fetchItems(BuildContext context) async {
   // try catch?

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    var queryParams = {
      "id": userProvider.user.userId,
      "type": "unknown",
    };
    var url = Uri.http(_baseUrl, '/items/', queryParams);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Item> items = parseItems(response.body);
        return items;
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception('Failed to load items: ${e.toString()}');
    }
  }

  List<Item> parseItems(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Item>((json) => Item.fromJson(json)).toList();
  }
}