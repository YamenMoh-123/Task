import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item.dart';

class ApiFetch {
  static const String _baseUrl = 'http://192.168.11.139:8000';

  Future<List<Item>> fetchItems() async {
    var url = Uri.parse('$_baseUrl/items/');
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