import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/models/Restaurant.dart';
import 'package:restaurant_app/screens/detail_screen.dart';
import 'package:restaurant_app/styles/custom_color.dart';

class RestaurantsListScreen extends StatelessWidget {
  static const routeName = '/restaurant-list';
  const RestaurantsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Restaurant",
                      style: Theme.of(context).textTheme.headline5),
                  Text("Recomended Restaurants for you",
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<String>(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/local_restaurant.json'),
                builder: (context, snapshot) {
                  try {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      var jsonMap = jsonDecode(snapshot.data!);
                      var restaurant = LocalRestaurant.fromJson(jsonMap);
                      return ListView.builder(
                        itemCount: restaurant.restaurants.length,
                        itemBuilder: (context, index) {
                          return _buildRestaurantItem(
                              context, restaurant.restaurants[index]);
                        },
                      );
                    }
                  } catch (e) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline_rounded,
                              size: 120, color: Colors.red[600]),
                          Text('Gagal Memuat Data',
                              style: Theme.of(context).textTheme.headline5),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Card(
        color: secondaryColor,
        elevation: 0,
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, RestaurantDetailScreen.routeName,
                arguments: restaurant);
          },
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          leading: Hero(
            tag: restaurant.pictureId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                restaurant.pictureId,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(restaurant.name,
              style: Theme.of(context).textTheme.subtitle1),
          subtitle: Row(
            children: [
              const Icon(
                Icons.star_rounded,
                color: Colors.orange,
                size: 15,
              ),
              Text(restaurant.rating.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }
}
