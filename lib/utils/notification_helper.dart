import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:rxdart/rxdart.dart';

import '../common/navigation.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettings =
        InitializationSettings(android: initializationSettingAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: $payload');
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      ListRestaurant listRestaurant) async {
    var channelId = '1';
    var channelName = 'channel_01';
    var channelDesc = 'restaurant channel';

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDesc,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    var titleNotification = '<b>Recomended Restaurant for you</b>';
    var titleRestaurant = listRestaurant.restaurants[0].name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleRestaurant, platformChannelSpecifics,
        payload: json.encode(listRestaurant.toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((String payload) async {
      var data = ListRestaurant.fromJson(json.decode(payload));
      var restaurant = data.restaurants[0];
      Navigation.intentWithData(route, restaurant);
    });
  }
}
