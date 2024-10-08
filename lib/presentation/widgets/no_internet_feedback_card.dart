import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:android_intent_plus/android_intent.dart';

import '../theme/colours.dart';

class NoInternetFeedback extends StatelessWidget {
  const NoInternetFeedback({super.key});

  Future<void> openSettings() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    if (androidInfo.version.sdkInt >= 21) {
      const AndroidIntent intent = AndroidIntent(
        action: 'android.settings.SETTINGS',
      );
      await intent.launch();
    } else {
      throw 'Device does not support settings navigation';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'No Internet Connection',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Please check your internet connection in settings and try again.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.headerTextColor,
              ),
              onPressed: openSettings,
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
