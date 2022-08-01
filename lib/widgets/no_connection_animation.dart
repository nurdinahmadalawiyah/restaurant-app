import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoConnectionAnimation extends StatelessWidget {
  const NoConnectionAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/no-connection.json',
          width: 200,
          fit: BoxFit.fill,
        ),
        const SizedBox(height: 20),
        Text(
          'No Internet Connection',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.black54,
              ),
        ),
      ],
    );
  }
}
