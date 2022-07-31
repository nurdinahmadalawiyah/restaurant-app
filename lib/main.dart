import 'package:flutter/material.dart';
import 'package:restaurant_app/common/custom_color.dart';
import 'package:restaurant_app/common/custom_text.dart';
import 'package:restaurant_app/screens/restaurant_detail_screen.dart';
import 'package:restaurant_app/screens/restaurant_list_screen.dart';
import 'package:restaurant_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Restaurant App by Nurdin A. Alawiyah',
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
          RestaurantDetailScreen.routeName: (context) =>
              RestaurantDetailScreen(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
        });
  }
}
