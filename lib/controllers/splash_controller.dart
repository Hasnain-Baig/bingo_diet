import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/home.dart';

class SplashController extends GetxController {
  int _myTimer = 0;
  int get myTimer => _myTimer;

  void onInit() {
    super.onInit();
    timerPlay();
  }

  timerPlay() {
    var _splashScreenTimer;
    _splashScreenTimer =
        new Timer.periodic(new Duration(milliseconds: 1000), (timer) {
      _myTimer++;
      if (_myTimer == 5) {
        _splashScreenTimer.cancel();
        Get.to(WillPopScope(onWillPop: () async => false, child: Home()));
        Get.to(Home());
      }
    });
  }
}
