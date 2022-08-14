import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/custom_color.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/screens/restaurant_search_screen.dart';
import 'package:restaurant_app/widgets/card_list_restaurant.dart';
import 'package:restaurant_app/widgets/empty_data_animation.dart';
import 'package:restaurant_app/widgets/error_animation.dart';
import 'package:restaurant_app/widgets/no_connection_animation.dart';

class RestaurantsFavoriteScreen extends StatefulWidget {
  static const routeName = '/restaurant-favorite';
  const RestaurantsFavoriteScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantsFavoriteScreen> createState() =>
      _RestaurantsFavoriteScreenState();
}

class _RestaurantsFavoriteScreenState extends State<RestaurantsFavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tertiaryColor,
      appBar: AppBar(
        title: Text('Favorite', style: Theme.of(context).textTheme.headline5),
        backgroundColor: tertiaryColor,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () {
              Navigator.pushNamed(context, RestaurantsSearchScreen.routeName);
            },
          ),
        ],
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                return CardListRestaurant(
                  restaurant: provider.favorites[index],
                );
              },
            );
          } else if (provider.state == ResultState.noData) {
            return const Center(
              child: EmptyDataAnimation(),
            );
          } else {
            return Center(
              child: Text(provider.message),
            );
          }
        },
      ),
    );
  }
}
