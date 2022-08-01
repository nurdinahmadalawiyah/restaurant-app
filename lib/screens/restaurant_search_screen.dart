import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/custom_color.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_app/widgets/card_search_restaurant.dart';
import 'package:restaurant_app/widgets/error_animation.dart';
import 'package:restaurant_app/widgets/no_connection_animation.dart';
import 'package:restaurant_app/widgets/search_animation.dart';

class RestaurantsSearchScreen extends StatefulWidget {
  static const routeName = '/restaurant-search';

  const RestaurantsSearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RestaurantsSearchScreen> createState() =>
      _RestaurantsSearchScreenState();
}

class _RestaurantsSearchScreenState extends State<RestaurantsSearchScreen> {
  String keyword = '';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tertiaryColor,
      appBar: AppBar(
        title: Text('Search', style: Theme.of(context).textTheme.headline5),
        backgroundColor: tertiaryColor,
        scrolledUnderElevation: 0,
      ),
      body: ChangeNotifierProvider(
        create: (_) => SearchRestaurantProvider(
          apiService: ApiService(),
        ),
        child: Consumer<SearchRestaurantProvider>(
          builder: (context, state, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: TextField(
                    controller: _controller,
                    cursorColor: primaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Search',
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      labelStyle: const TextStyle(color: primaryColor),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          )),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: primaryColor,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: primaryColor,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.clear_rounded,
                          color: Colors.black38,
                        ),
                        onPressed: () {
                          if (keyword != '') {
                            _controller.clear();
                            setState(() {
                              keyword = '';
                            });
                          }
                        },
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        keyword = value;
                      });
                      if (value != '') {
                        state.fetchAllRestaurantSearch(value);
                      }
                    },
                  ),
                ),
                Expanded(child: Consumer<SearchRestaurantProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.state == ResultState.HasData) {
                      state.fetchAllRestaurantSearch(keyword);
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.searchRestaurant!.restaurants.length,
                        itemBuilder: (context, index) {
                          var restaurant =
                              state.searchRestaurant!.restaurants[index];
                          return CardSearchRestaurant(restaurant: restaurant);
                        },
                      );
                    } else if (state.state == ResultState.NoData) {
                      state.fetchAllRestaurantSearch(keyword);
                      return const Center(child: ErrorAnimation());
                    } else if (state.state == ResultState.NoConnection) {
                      return const Center(child: NoConnectionAnimation());
                    } else if (state.state == ResultState.Error) {
                      return const Center(child: SearchAnimation());
                    } else {
                      return const Center(child: Text('Unknown error'));
                    }
                  },
                ))
              ],
            );
          },
        ),
      ),
    );
  }
}
