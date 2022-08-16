import 'package:flutter/material.dart';
import 'package:restaurant_app/data/preferences/preference_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyRestaurantPreferences();
  }

  bool _isDailyRestaurantActive = false;
  bool get isDailyRestauranActive => _isDailyRestaurantActive;

  void _getDailyRestaurantPreferences() async {
    _isDailyRestaurantActive = await preferencesHelper.isDailyRestarantActive;
    notifyListeners();
  }

  void enableDailyRestaurants(bool value) {
    preferencesHelper.setDailyRestaurants(value);
    _getDailyRestaurantPreferences();
  }
}
