import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider extends ChangeNotifier {
  List<ConnectivityResult> _connectivityResult = [ConnectivityResult.none];
  bool _isConnected = true;

  ConnectivityProvider() {
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      _updateConnectionStatus(result);
    });
  }

  bool get isConnected => _isConnected;

  Future<void> _checkConnectivity() async {
    final List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    _connectivityResult = result;
    _isConnected = _connectivityResult.contains(ConnectivityResult.wifi) || _connectivityResult.contains(ConnectivityResult.mobile);
    notifyListeners();
  }
}
