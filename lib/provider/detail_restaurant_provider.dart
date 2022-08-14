import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/detail_restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

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
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant = await apiService.getDetailRestaurant(id);
      _state = ResultState.hasData;
      notifyListeners();
      return _detailrestaurant = detailRestaurant;
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
