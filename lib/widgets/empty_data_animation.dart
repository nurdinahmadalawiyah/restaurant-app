import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyDataAnimation extends StatelessWidget {
  const EmptyDataAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/empty.json',
          width: 200,
          fit: BoxFit.fill,
        ),
        const SizedBox(height: 20),
        Text(
          'Data Favorite Empty',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.black54,
              ),
        ),
      ],
    );
  }
}
