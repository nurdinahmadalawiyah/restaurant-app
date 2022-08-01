import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/widgets/error_animation.dart';
import 'package:restaurant_app/widgets/item_detail_restaurant.dart';
import '../data/api/api_service.dart';

class RestaurantDetailScreen extends StatelessWidget {
  static const routeName = '/restaurant-detail';

  final String id;

  const RestaurantDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const pictureUrl = 'https://restaurant-api.dicoding.dev/images/medium/';
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) =>
            DetailRestaurantProvider(apiService: ApiService(), id: id),
        child: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (state.state == ResultState.HasData) {
                final restaurant = state.detailRestaurant;
                return ItemDetailRestaurant(
                    restaurant: restaurant, pictureUrl: pictureUrl);
              } else if (state.state == ResultState.NoData) {
                return const Center(child: ErrorAnimation());
              } else if (state.state == ResultState.Error) {
                return const Center(child: ErrorAnimation());
              } else {
                return const Text('Unknown Error');
              }
            }
          },
        ),
      ),
    );
  }
}
