import 'package:flutter/material.dart';
import 'package:open_settings_plus/open_settings_plus.dart';

class NoInternetDialog extends StatelessWidget {
  const NoInternetDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('No Internet Connection'),
      content: const Text('Please check your internet connection.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Dismiss the dialog
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Navigator.of(context).pop(); // Dismiss the dialog
            switch (OpenSettingsPlus.shared) {
              case OpenSettingsPlusAndroid settings:
                settings.wifi();
                break;
              case OpenSettingsPlusIOS settings:
                settings.wifi();
                break;
              default:
                throw Exception('Platform not supported');
            }
          },
          child: const Text('Turn On'),
        ),
      ],
    );
  }
}
