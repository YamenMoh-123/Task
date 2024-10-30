import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item.dart';

class ApiCrud {
  static const String _baseUrl = 'http://192.168.11.139:8000';

  Future<void> deleteItem(int id) async {
    var url = Uri.parse('$_baseUrl/items/$id/');
    try {
      var response = await http.delete(url);
      if (response.statusCode == 204) {
        return;
      } else {
        throw Exception('Failed to delete item');
      }
    } catch (e) {
      throw Exception('Failed to delete item: ${e.toString()}');
    }
  }

  Future<void> editItem(Item item)async{
    var id = item.id;
    var url = Uri.parse('$_baseUrl/items/$id/');
    try{
      var body = jsonEncode(item.toJson());
      var response = await http.put(url, body: body, headers: {'Content-Type': 'application/json'});
      if(response.statusCode == 200){
        return;
      }
      else{
        throw Exception('Failed to edit item');

      }
    }
    catch(e){
      throw Exception('Failed to edit item: ${e.toString()}');
    }
  }

  Future<Item> addItem(Map<String, String> itemData) async {
    var url = Uri.parse('$_baseUrl/items/');
    try {
      var body = jsonEncode(itemData);
      var response = await http.post(url, body: body, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        return Item.fromJson(responseData);
      } else {
        var errorMessage = 'Failed to add item: Status ${response.statusCode}';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Failed to add item: ${e.toString()}');
    }
  }



}