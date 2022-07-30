import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/custom_color.dart';
import 'package:restaurant_app/common/custom_text.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/screens/detail_screen.dart';
import 'package:restaurant_app/screens/list_screen.dart';
import 'package:restaurant_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: primaryColor,
                  secondary: secondaryColor,
                  tertiary: tertiaryColor,
                ),
            textTheme: myTextTheme(),
          ),
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            RestaurantsListScreen.routeName: (context) =>
                const RestaurantsListScreen(),
            RestaurantDetailScreen.routeName: (context) => RestaurantDetailScreen(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as Restaurant,
                ),
          }),
    );
  }
}
