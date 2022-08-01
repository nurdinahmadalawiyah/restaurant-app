import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/list_restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error, NoConnection }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fecthListRestaurant();
  }

  late ListRestaurant _listRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  ListRestaurant get list => _listRestaurant;

  ResultState get state => _state;

  Future<dynamic> _fecthListRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.getListRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No data found';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _listRestaurant = restaurant;
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
