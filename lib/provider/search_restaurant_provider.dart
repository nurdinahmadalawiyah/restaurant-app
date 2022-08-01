import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/search_restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error, NoConnection }

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService}) {
    fetchAllRestaurantSearch(keyword);
  }

  SearchRestaurant? _searchrestaurant;
  String _message = '';
  String _keyword = '';
  ResultState? _state;

  String get message => _message;
  String get keyword => _keyword;

  SearchRestaurant? get searchRestaurant => _searchrestaurant;

  ResultState? get state => _state;

  Future<dynamic> fetchAllRestaurantSearch(String keyword) async {
    try {
      _state = ResultState.Loading;
      _keyword = keyword;

      final searchRestaurant = await apiService.getSearchRestaurant(keyword);
      if (searchRestaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No data found';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searchrestaurant = searchRestaurant;
      }
    } on SocketException {
      _state = ResultState.NoConnection;
      notifyListeners();
      return _message = 'No internet connection';
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}
