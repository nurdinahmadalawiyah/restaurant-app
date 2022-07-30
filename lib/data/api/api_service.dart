import 'dart:convert';

import 'package:restaurant_app/data/models/list_restaurant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String _list = '/list';
  static const String _detail = '/detail';
  static const String _search = '/search?q=';

  Future<ListRestaurant> getListRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + _list));
    if (response.statusCode == 200) {
      return ListRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load list restaurant");
    }
  }
}