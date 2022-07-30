import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/list_restaurant.dart';

class CardListRestaurant extends StatelessWidget {
  const CardListRestaurant({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    const pictureUrl = 'https://restaurant-api.dicoding.dev/images/medium/';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        child: ListTile(
          // onTap: () {
          //   Navigator.pushNamed(context, RestaurantDetailScreen.routeName,
          //       arguments: restaurant);
          // },
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          leading: Hero(
            tag: restaurant.pictureId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                pictureUrl + restaurant.pictureId,
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
              Text(
                restaurant.rating.toString(),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
