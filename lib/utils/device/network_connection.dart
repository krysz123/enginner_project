import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:enginner_project/utils/popups/snackbars.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkConnection extends GetxController {
  static NetworkConnection get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      Snackbars.warningSnackbar(
        title: 'Brak internetu',
        message: 'Sprawdź swoje połączenie z internetem',
      );
    }
  }

  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }
}
