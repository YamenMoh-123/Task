import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ApiCrud {

  static const String _baseUrl = '192.168.11.139:8000';

  Future<List<Item>> fetchItems(BuildContext context) async {
    // try catch?
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    var queryParams = {
      "id": userProvider.user.userId,
      "type": "unknown",
    };
    var url = Uri.http(_baseUrl, '/userLink/', queryParams);
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

  Future<void> deleteItem(int userId, int id) async {
    var url = Uri.http(_baseUrl, '/userLink/$userId/$id/');
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

  Future<Map<String, dynamic>> editItem(int userId, Map<String, dynamic> item)async{

    var id = item['item'];
    var url = Uri.http(_baseUrl, '/userLink/$userId/$id/');
    try{
      var body = jsonEncode(item);
      var response = await http.put(url, body: body, headers: {'Content-Type': 'application/json'});
      if(response.statusCode == 200){
        print(response.body);
        return jsonDecode(response.body);
      }
      else{
        throw Exception('Failed to edit item');
      }
    }
    catch(e){
      throw Exception('Failed to edit item: ${e.toString()}');
    }
  }


  Future<Item> addItem(Map<String, String> itemData, BuildContext context) async {
    var url = Uri.http(_baseUrl, '/items/');
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      var body = jsonEncode(itemData);
      var response = await http.post(url, body: body, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 201) {
        var responseData = jsonDecode(response.body);

        url = Uri.http(_baseUrl, '/userLink/');
        var data = jsonEncode(
            {"user_id": userProvider.user.userId,
              "item_id": responseData['id'],
              "rating": itemData['rating'],
              "progress": itemData['progress'],
             // "optional_details": itemData['optional_details']
            });
        var responseLink = await http.post(url, body: data, headers: {'Content-Type': 'application/json'});
        if(responseLink.statusCode == 201){
          var temp = jsonDecode(responseLink.body);

          var toRet = {
            "item_id": responseData['id'],
            "title": responseData['title'],
            "item_type": responseData['type'],
            "additional_details": responseData['additional_details'],
            "rating": temp['rating'],
            "progress": temp['progress'],
            "optionalDetails": temp['optionalDetails']};
          print(toRet);
          Item item = Item.fromJson(toRet);
          print ("NRGNU");
          return item;
        }
        else{
          throw Exception('Failed to add item');
        }


      } else {
        var errorMessage = 'Failed to add item: Status ${response.statusCode}';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Failed to add item: ${e.toString()}');
    }

  }

}