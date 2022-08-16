import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/custom_color.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tertiaryColor,
      appBar: AppBar(
        backgroundColor: tertiaryColor,
        title: const Text('Settings'),
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return Consumer<SchedulingProvider>(
          builder: (context, scheduled, _) {
            return Material(
              color: tertiaryColor,
              child: ListTile(
                title: const Text('Restaurant Notification'),
                subtitle: Text(scheduled.message),
                trailing: Switch.adaptive(
                  value: provider.isDailyRestauranActive,
                  onChanged: (value) async {
                    scheduled.scheduledRestaurant(value);
                    provider.enableDailyRestaurants(value);
                  },
                ),
              ),
            );
          },
        );
        },
      ),
    );
  }
}
