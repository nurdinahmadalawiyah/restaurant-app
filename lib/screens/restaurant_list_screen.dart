import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/custom_color.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/screens/restaurant_search_screen.dart';
import 'package:restaurant_app/widgets/card_list_restaurant.dart';
import 'package:restaurant_app/widgets/error_animation.dart';

class RestaurantsListScreen extends StatefulWidget {
  static const routeName = '/restaurant-list';
  const RestaurantsListScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantsListScreen> createState() => _RestaurantsListScreenState();
}

class _RestaurantsListScreenState extends State<RestaurantsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tertiaryColor,
      appBar: AppBar(
        title: Text('Restaurant', style: Theme.of(context).textTheme.headline5),
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 18, bottom: 8),
              child: Text("Recomended Restaurants for you",
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            Expanded(
              child: ChangeNotifierProvider(
                create: (_) => RestaurantProvider(apiService: ApiService()),
                child: Consumer<RestaurantProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (state.state == ResultState.HasData) {
                        return ListView.builder(
                          itemCount: state.list.restaurants.length,
                          itemBuilder: (context, index) {
                            var restaurant = state.list.restaurants[index];
                            return CardListRestaurant(
                              restaurant: restaurant,
                            );
                          },
                        );
                      } else if (state.state == ResultState.NoData) {
                        return const Center(child: ErrorAnimation());
                      } else if (state.state == ResultState.Error) {
                        return Center(
                          child: Text(
                            state.message,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        );
                      } else {
                        return const Text('Unknown Error');
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
