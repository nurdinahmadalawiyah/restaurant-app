import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorAnimation extends StatelessWidget {
  const ErrorAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/error.json',
          width: 200,
          fit: BoxFit.fill,
        ),
        Text(
          'Tidak Ada Data',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.black54,
              ),
        ),
      ],
    );
  }
}