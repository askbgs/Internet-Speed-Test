import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:speedtest/app/constants/color_plate.dart';
import 'package:speedtest/app/data/dbHelper.dart';
import 'package:speedtest/app/modules/home/views/home_view.dart';
import 'package:speedtest/app/routes/app_pages.dart';

class SplashscreenController extends GetxController {
  //TODO: Implement SplashscreenController

  final count = 0.obs;
  final loading_v = false.obs;
  var exist = false.obs;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();
  @override
  void onInit() {
    super.onInit();
    initConnectivity();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status' + e.toString());
      return;
    }
    _updateConnectionStatus1(result);
  }

  Future<void> _updateConnectionStatus1(ConnectivityResult result) async {
    _connectionStatus = result;
    if (_connectionStatus == ConnectivityResult.none ||
        _connectionStatus == ConnectivityResult.bluetooth) {
      Get.defaultDialog(
        title: 'No Internet',
        barrierDismissible: false,
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
        buttonColor: closebutton,
        content: const Text(
            'No internet access, please enable the internat access for  run this application'),
      );
    } else {
      Timer(Duration(seconds: 3), () {
        if (DBHelper.checkDbExitiorNot() == true) {
          Get.offAllNamed(Routes.HOME);
        } else {
          DBHelper.initDatabase().then((value) {
            Get.offAllNamed(Routes.HOME);
          }).onError((error, stackTrace) {});
        }
      });
    }

    //print(netWorkType.value);
  }

  Future<void> loading() async {
    Timer(Duration(seconds: 3), () {
      Get.offAndToNamed(Routes.HOME);
    });
  }

  @override
  void onReady() async {
    super.onReady();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus1);
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
