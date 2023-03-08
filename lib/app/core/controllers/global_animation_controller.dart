import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingAnimationController extends GetxController {
  LoadingAnimationController(
    this.showImage,
    this.firstActive,
    this.secondActive,
    this.thirdActive,
  );

  var showImage = true.obs;
  var firstActive = true.obs;
  var secondActive = false.obs;
  var thirdActive = false.obs;
  var timerCount = 0.0.obs;
  var firstTick = 0.0;
  var secondTick = 0.2;
  var thirdTick = 0.4;
  var duration = 0.4;
  var imageDuration = 0.2;
  Timer timer;

  @override
  void onInit() {
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      timerCount.value = (timerCount.value + 0.1) % 1.2;
      firstActive.value = timerCount.value >= firstTick &&
          timerCount.value <= (firstTick + duration);
      secondActive.value = timerCount.value >= secondTick &&
          timerCount.value <= (secondTick + duration);
      thirdActive.value = timerCount.value >= thirdTick &&
          timerCount.value <= (thirdTick + duration);
      showImage.value = (timerCount.value % 0.4) >= 0 && (timerCount.value % 0.4) <= imageDuration;
    });
  }
}
