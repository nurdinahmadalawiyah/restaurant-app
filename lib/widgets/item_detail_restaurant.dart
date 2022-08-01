import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/common/custom_color.dart';
import 'package:restaurant_app/data/models/detail_restaurant.dart';
import 'package:restaurant_app/widgets/cutomer_reviews.dart';
import 'package:restaurant_app/widgets/menu_drinks.dart';
import 'package:restaurant_app/widgets/menu_foods.dart';

class ItemDetailRestaurant extends StatelessWidget {
  const ItemDetailRestaurant({
    Key? key,
    required this.restaurant,
    required this.pictureUrl,
  }) : super(key: key);

  final DetailRestaurant restaurant;
  final String pictureUrl;

  @override
  Widget build(BuildContext context) {
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
                tag: restaurant.restaurant.pictureId,
                child: ClipRRect(
                  child: Image.network(
                    pictureUrl + restaurant.restaurant.pictureId,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: isScrolled ? Text(restaurant.restaurant.name) : null,
              titlePadding: const EdgeInsets.only(left: 56, bottom: 14),
            ),
          )
        ];
      },
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.restaurant.name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: primaryColor,
                        size: 20,
                      ),
                      Text(
                          '${restaurant.restaurant.city}, ${restaurant.restaurant.address}',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      RatingBar(
                        initialRating: restaurant.restaurant.rating,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 25,
                        ignoreGestures: true,
                        ratingWidget: RatingWidget(
                          full: const Icon(Icons.star_rounded,
                              color: Colors.orange),
                          half: const Icon(
                            Icons.star_half_rounded,
                            color: Colors.orange,
                          ),
                          empty: const Icon(
                            Icons.star_outline_rounded,
                            color: Colors.orange,
                          ),
                        ),
                        onRatingUpdate: (double value) {},
                      ),
                      const SizedBox(width: 10),
                      Text(restaurant.restaurant.rating.toString(),
                          style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 5,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text("Description",
                          style: Theme.of(context).textTheme.headline6),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(restaurant.restaurant.description,
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 5,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text("Menu Foods",
                          style: Theme.of(context).textTheme.headline6),
                    ],
                  ),
                  const SizedBox(height: 5),
                  MenuFoods(restaurant: restaurant),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 5,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text("Menu Drinks",
                          style: Theme.of(context).textTheme.headline6),
                    ],
                  ),
                  const SizedBox(height: 5),
                  MenuDrinks(restaurant: restaurant),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 5,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text("Customer Reviews",
                          style: Theme.of(context).textTheme.headline6),
                    ],
                  ),
                  const SizedBox(height: 5),
                  CustomerReviews(restaurant: restaurant),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
