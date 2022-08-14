import 'package:flutter/material.dart';
import 'package:restaurant_app/common/custom_color.dart';
import 'package:restaurant_app/screens/restaurant_favorite_screen.dart';
import 'package:restaurant_app/screens/restaurant_list_screen.dart';
import 'package:restaurant_app/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tertiaryColor,
      body: <Widget>[
        const RestaurantsListScreen(),
        const RestaurantsFavoriteScreen(),
        const SettingsScreen(),
      ][_currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: tertiaryColor,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedIndex: _currentIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.food_bank),
            label: 'List',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_rounded),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
