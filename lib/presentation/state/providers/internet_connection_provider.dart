import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectionProvider extends ChangeNotifier {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  bool _isConnected = false;

  InternetConnectionProvider() {
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      _updateConnectionStatus(results.first);
    });
  }

  bool get isConnected => _isConnected;

  Future<void> _checkConnectivity() async {
    final ConnectivityResult result = (await Connectivity().checkConnectivity()).first;
    _updateConnectionStatus(result);
  }


  void _updateConnectionStatus(ConnectivityResult result) {
    _connectivityResult = result;
    _isConnected = _connectivityResult != ConnectivityResult.none;
    notifyListeners();
  }
}
