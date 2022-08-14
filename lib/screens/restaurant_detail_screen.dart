import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/custom_color.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/error_animation.dart';
import 'package:restaurant_app/widgets/item_detail_restaurant.dart';
import 'package:restaurant_app/widgets/no_connection_animation.dart';
import '../data/api/api_service.dart';

class RestaurantDetailScreen extends StatelessWidget {
  static const routeName = '/restaurant-detail';

  final Restaurant restaurant;

  const RestaurantDetailScreen({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const pictureUrl = 'https://restaurant-api.dicoding.dev/images/medium/';
    return NestedScrollView(
      headerSliverBuilder: (context, isScrolled) {
        return [
          SliverAppBar(
            leading: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            backgroundColor: primaryColor,
            expandedHeight: 200,
            pinned: true,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: restaurant.pictureId,
                child: ClipRRect(
                  child: Image.network(
                    pictureUrl + restaurant.pictureId,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: isScrolled ? Text(restaurant.name) : null,
              titlePadding: const EdgeInsets.only(left: 56, bottom: 14),
            ),
            actions: [
              Consumer<DatabaseProvider>(
                builder: (context, provider, child) {
                  return FutureBuilder<bool>(
                      future: provider.isFavorited(restaurant.id),
                      builder: (context, snapshot) {
                        var isFavorited = snapshot.data ?? false;
                        if (isFavorited) {
                          return IconButton(
                            icon: const Icon(Icons.favorite_rounded),
                            color: Colors.pink,
                            onPressed: () =>
                                provider.removeFavorite(restaurant.id),
                          );
                        } else {
                          return IconButton(
                            icon: const Icon(Icons.favorite_border_rounded),
                            color: Colors.white,
                            onPressed: () => provider.addFavorite(restaurant),
                          );
                        }
                      });
                },
              ),
            ],
          )
        ];
      },
      body: ChangeNotifierProvider(
        create: (_) => DetailRestaurantProvider(
            apiService: ApiService(), id: restaurant.id),
        child: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (state.state == ResultState.hasData) {
                final restaurant = state.detailRestaurant;
                return ItemDetailRestaurant(restaurant: restaurant);
              } else if (state.state == ResultState.noData) {
                return const Center(child: ErrorAnimation());
              } else if (state.state == ResultState.noConnection) {
                return const Center(child: NoConnectionAnimation());
              } else if (state.state == ResultState.error) {
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
