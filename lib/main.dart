import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/custom_color.dart';
import 'package:restaurant_app/common/custom_text.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:restaurant_app/screens/restaurant_detail_screen.dart';
import 'package:restaurant_app/screens/restaurant_list_screen.dart';
import 'package:restaurant_app/screens/restaurant_search_screen.dart';
import 'package:restaurant_app/screens/splash_screen.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  await AndroidAlarmManager.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        )
      ],
      child: MaterialApp(
          title: 'Restaurant App by Nurdin A. Alawiyah',
          theme: ThemeData(
            useMaterial3: true,
            primarySwatch: primaryGreen,
            textTheme: myTextTheme(),
          ),
          navigatorKey: navigatorKey,
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            RestaurantsListScreen.routeName: (context) =>
                const RestaurantsListScreen(),
            RestaurantDetailScreen.routeName: (context) =>
                RestaurantDetailScreen(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as Restaurant,
                ),
            RestaurantsSearchScreen.routeName: (context) =>
                const RestaurantsSearchScreen(),
          }),
    );
  }
}
