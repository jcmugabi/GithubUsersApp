import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectionProvider with ChangeNotifier {
  final Connectivity _connectivity;
  bool _isConnected = true;

  InternetConnectionProvider(this._connectivity) {
    _connectivity.onConnectivityChanged.listen((status) {
      _isConnected = status != ConnectivityResult.none;
      notifyListeners();
    });
  }

  bool get isConnected => _isConnected;

  Widget getFeedbackCard() {
    return _isConnected
        ? Container()
        : const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No internet connection'),
      ),
    );
  }
}
