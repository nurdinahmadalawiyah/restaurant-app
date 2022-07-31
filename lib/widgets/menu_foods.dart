import 'package:flutter/material.dart';
import 'package:restaurant_app/common/custom_color.dart';
import 'package:restaurant_app/data/models/detail_restaurant.dart';

class MenuFoods extends StatelessWidget {
  const MenuFoods({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final DetailRestaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount:
          restaurant.restaurant.menus.foods.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          color: secondaryColor,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(
                  Icons.fastfood_rounded,
                  color: primaryColor,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                      restaurant.restaurant.menus
                          .foods[index].name,
                      overflow: TextOverflow.clip,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2),
                ),
              ],
            ),
          ),
        );
      },
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4 / 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
    );
  }
}