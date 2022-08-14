import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

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
      _state = ResultState.loading;
      _keyword = keyword;

      final searchRestaurant = await apiService.getSearchRestaurant(keyword);
      if (searchRestaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No data found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchrestaurant = searchRestaurant;
      }
    } on SocketException {
      _state = ResultState.noConnection;
      notifyListeners();
      return _message = 'No internet connection';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}
