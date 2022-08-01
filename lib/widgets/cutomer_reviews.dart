import 'package:flutter/material.dart';
import 'package:restaurant_app/common/custom_color.dart';
import 'package:restaurant_app/data/models/detail_restaurant.dart';

class CustomerReviews extends StatelessWidget {
  const CustomerReviews({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final DetailRestaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: restaurant.restaurant.customerReviews.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          color: Colors.grey[200],
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person_rounded,
                            color: primaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                                restaurant
                                    .restaurant.customerReviews[index].name,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.subtitle1),
                          ),
                        ],
                      ),
                    ),
                    Text(restaurant.restaurant.customerReviews[index].date,
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.caption),
                  ],
                ),
                const SizedBox(height: 5),
                Text(restaurant.restaurant.customerReviews[index].review,
                    overflow: TextOverflow.clip,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        );
      },
    );
  }
}
