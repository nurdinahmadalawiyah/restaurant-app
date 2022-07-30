
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/custom_color.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widgets/card_list_restaurant.dart';

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
        title:
            Text('Restaurants', style: Theme.of(context).textTheme.headline5),
        backgroundColor: tertiaryColor,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () {},
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
                      return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/error.json',
                          width: 200,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          'Tidak Ada Data',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.black54,
                                  ),
                        ),
                      ],
                    );
                    } else if (state.state == ResultState.Error) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/error.json',
                          width: 200,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          'Gagal Memuat Data',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.black54,
                                  ),
                        ),
                      ],
                    );
                    } else {
                      return const Text('Unknown Error');
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
