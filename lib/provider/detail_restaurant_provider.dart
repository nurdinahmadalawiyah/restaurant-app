import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/detail_restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error, NoConnection }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailRestaurantProvider({
    required this.apiService,
    required this.id,
  }) {
    _fecthDetailRestaurant(id);
  }

  late DetailRestaurant _detailrestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  DetailRestaurant get detailRestaurant => _detailrestaurant;
  ResultState get state => _state;

  Future<dynamic> _fecthDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final detailRestaurant = await apiService.getDetailRestaurant(id);
      if (detailRestaurant.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No data found';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detailrestaurant = detailRestaurant;
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
