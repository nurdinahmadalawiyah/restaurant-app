import 'dart:convert';

import 'package:restaurant_app/data/models/detail_restaurant.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;

class ApiService {
  Client? client;
  ApiService({this.client}) {
    client ??= Client();
  }

  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String _list = '/list';
  static const String _detail = '/detail';
  static const String _search = '/search?q=';

  Future<ListRestaurant> getListRestaurant() async {
    final response = await client!.get(Uri.parse(_baseUrl + _list));
    if (response.statusCode == 200) {
      return ListRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load list restaurant");
    }
  }

  Future<DetailRestaurant> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl$_detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load detail restaurant");
    }
  }

  Future<SearchRestaurant> getSearchRestaurant(String keyword) async {
    final response = await http.get(Uri.parse("$_baseUrl$_search$keyword"));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load search restaurant");
    }
  }
}
