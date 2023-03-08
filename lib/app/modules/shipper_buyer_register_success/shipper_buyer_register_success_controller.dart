import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/routes/app_pages.dart';

class ShipperBuyerRegisterSuccessController extends GetxController
    with SingleGetTickerProviderMixin {
  var popUpDuration = 1500;
  var textDuration = 500;
  var slideUpDelay = 100;
  // var splashDuration = 800;

  var marginBottom = false.obs;
  AnimationController animationController;
  Animation fadeAnimation;
  Animation<Offset> slideAnimation;
  CurvedAnimation curve;

  AnimationController splashController;
  Animation<Offset> splashAnimation1;
  Animation<Offset> splashAnimation2;
  Animation<Offset> splashAnimation3;
  Animation<Offset> splashAnimation4;
  Animation<Offset> splashAnimation5;
  Animation<Offset> splashAnimation6;
  Animation<Offset> splashAnimation7;
  Animation<Offset> splashAnimation8;
  // Animation<double> splashScaleAnimation;

  AnimationController scaleController;
  Animation<double> scaleAnimation;
  TickerFuture tickerFuture;

  int endTime = 0;

  @override
  void onInit() {
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: textDuration));
    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    slideAnimation = Tween(begin: Offset(0.0, -0.5), end: Offset.zero)
        .animate(animationController);
    curve =
        CurvedAnimation(curve: Curves.easeInOut, parent: animationController);

    scaleController = AnimationController(
        vsync: this, duration: Duration(milliseconds: popUpDuration))
      ..repeat();
    scaleAnimation =
        CurvedAnimation(curve: Curves.elasticOut, parent: scaleController);
    tickerFuture = scaleController.repeat();
    tickerFuture.timeout(Duration(milliseconds: popUpDuration), onTimeout: () {
      scaleController.forward(from: 1);
      scaleController.stop(canceled: true);
    });

    splashController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1500))
          ..repeat();
    splashAnimation1 = Tween(begin: Offset.zero, end: Offset(7.0, 3.0)).animate(
        CurvedAnimation(parent: splashController, curve: Curves.decelerate));
    splashAnimation2 = Tween(begin: Offset.zero, end: Offset(8.0, -5.0))
        .animate(CurvedAnimation(
            parent: splashController, curve: Curves.decelerate));
    splashAnimation3 = Tween(begin: Offset.zero, end: Offset(-7.0, 6.0))
        .animate(CurvedAnimation(
            parent: splashController, curve: Curves.decelerate));
    splashAnimation4 = Tween(begin: Offset.zero, end: Offset(-9.0, -4.0))
        .animate(CurvedAnimation(
            parent: splashController, curve: Curves.decelerate));
    splashAnimation5 = Tween(begin: Offset.zero, end: Offset(7.6, -4.5))
        .animate(CurvedAnimation(
            parent: splashController, curve: Curves.decelerate));
    splashAnimation6 = Tween(begin: Offset.zero, end: Offset(-8.0, 2.0))
        .animate(CurvedAnimation(
            parent: splashController, curve: Curves.decelerate));
    splashAnimation7 = Tween(begin: Offset.zero, end: Offset(-9.0, -1.0))
        .animate(CurvedAnimation(
            parent: splashController, curve: Curves.decelerate));
    splashAnimation8 = Tween(begin: Offset.zero, end: Offset(-15.0, -13.0))
        .animate(CurvedAnimation(
            parent: splashController, curve: Curves.decelerate));
    // splashScaleAnimation =
    //     CurvedAnimation(curve: Curves.decelerate, parent: splashController);
    Timer(Duration(milliseconds: popUpDuration + slideUpDelay), () async {
      marginBottom.value = true;
      endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
      animationController.forward();
    });
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void timeoutTimer() {
    if (marginBottom.value) {
      Timer(Duration(milliseconds: 1), () async {
        // Get.offAllNamed(Routes.HOME);
        Get.offAllNamed(Routes.AFTER_LOGIN_SUBUSER);
      });
    }
  }
}
