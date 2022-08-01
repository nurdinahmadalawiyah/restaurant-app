import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchAnimation extends StatelessWidget {
  const SearchAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/search.json',
          width: 200,
          fit: BoxFit.fill,
        ),
        Text(
          'Cari Restoran',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.black54,
              ),
        ),
      ],
    );
  }
}
