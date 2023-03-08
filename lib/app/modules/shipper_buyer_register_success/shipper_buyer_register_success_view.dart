import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/check_after_register_login_go_to_home_function.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register_success/shipper_buyer_register_success_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class ShipperBuyerRegisterSuccessView
    extends GetView<ShipperBuyerRegisterSuccessController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(ListColor.color4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(
            () => AnimatedContainer(
              duration: Duration(milliseconds: controller.textDuration),
              margin: EdgeInsets.only(
                  bottom: controller.marginBottom.value ? 300 : 0),
              child: SlideTransition(
                position: controller.splashAnimation1,
                //   child: ScaleTransition(
                //     scale: controller.scaleAnimation,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.yellow, shape: BoxShape.circle),
                ),
                //   ),
              ),
            ),
          ),
          Obx(
            () => AnimatedContainer(
              duration: Duration(milliseconds: controller.textDuration),
              margin: EdgeInsets.only(
                  bottom: controller.marginBottom.value ? 300 : 0),
              child: SlideTransition(
                position: controller.splashAnimation2,
                //   child: ScaleTransition(
                //     scale: controller.scaleAnimation,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
                //   ),
              ),
            ),
          ),
          Obx(
            () => AnimatedContainer(
              duration: Duration(milliseconds: controller.textDuration),
              margin: EdgeInsets.only(
                  bottom: controller.marginBottom.value ? 300 : 0),
              child: SlideTransition(
                position: controller.splashAnimation3,
                //   child: ScaleTransition(
                //     scale: controller.scaleAnimation,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.yellow, shape: BoxShape.circle),
                ),
                //   ),
              ),
            ),
          ),
          Obx(
            () => AnimatedContainer(
              duration: Duration(milliseconds: controller.textDuration),
              margin: EdgeInsets.only(
                  bottom: controller.marginBottom.value ? 300 : 0),
              child: SlideTransition(
                position: controller.splashAnimation4,
                //   child: ScaleTransition(
                //     scale: controller.scaleAnimation,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
                //   ),
              ),
            ),
          ),
          Obx(
            () => AnimatedContainer(
              duration: Duration(milliseconds: controller.textDuration),
              margin: EdgeInsets.only(
                  bottom: controller.marginBottom.value ? 300 : 0),
              child: SlideTransition(
                position: controller.splashAnimation5,
                //   child: ScaleTransition(
                //     scale: controller.scaleAnimation,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.yellow, shape: BoxShape.circle),
                ),
                //   ),
              ),
            ),
          ),
          Obx(
            () => AnimatedContainer(
              duration: Duration(milliseconds: controller.textDuration),
              margin: EdgeInsets.only(
                  bottom: controller.marginBottom.value ? 300 : 0),
              child: SlideTransition(
                position: controller.splashAnimation6,
                //   child: ScaleTransition(
                //     scale: controller.scaleAnimation,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      color: Colors.yellow, shape: BoxShape.circle),
                ),
                //   ),
              ),
            ),
          ),
          Obx(
            () => AnimatedContainer(
              duration: Duration(milliseconds: controller.textDuration),
              margin: EdgeInsets.only(
                  bottom: controller.marginBottom.value ? 300 : 0),
              child: SlideTransition(
                position: controller.splashAnimation7,
                //   child: ScaleTransition(
                //     scale: controller.scaleAnimation,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
                //   ),
              ),
            ),
          ),
          Obx(
            () => AnimatedContainer(
              duration: Duration(milliseconds: controller.textDuration),
              margin: EdgeInsets.only(
                  bottom: controller.marginBottom.value ? 300 : 0),
              child: SlideTransition(
                position: controller.splashAnimation8,
                //   child: ScaleTransition(
                //     scale: controller.scaleAnimation,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: Colors.yellow, shape: BoxShape.circle),
                ),
                //   ),
              ),
            ),
          ),
          Obx(
            () => AnimatedContainer(
              duration: Duration(milliseconds: controller.textDuration),
              margin: EdgeInsets.only(
                  bottom: controller.marginBottom.value ? 300 : 0),
              child: ScaleTransition(
                scale: controller.scaleAnimation,
                child: Container(
                  width: 150,
                  height: 150,
                  child: Image(
                    image: AssetImage("assets/ic_registered2.png"),
                  ),
                ),
              ),
            ),
          ),
          FadeTransition(
              opacity: controller.fadeAnimation,
              child: SlideTransition(
                  position: controller.slideAnimation,
                  child: CustomText(
                    "ShipperRegisterLabelSuccess".tr,
                    textAlign: TextAlign.center,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ))),
          Obx(
            () => Opacity(
              opacity: controller.marginBottom.value ? 1 : 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      CountdownTimer(
                        endTime: controller.endTime,
                        widgetBuilder: (_, CurrentRemainingTime time) {
                          String timer = "";
                          if (time != null) {
                            String seconds =
                                time.sec != null ? '${time.sec}' : '0';
                            timer = seconds;
                          } else {
                            timer = "0";
                            controller.timeoutTimer();
                          }
                          return CustomText(timer,
                              fontSize: 30, color: Colors.white);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          onPressed: () {
                            // CheckAfterRegisterLoginGoToHome.checkGoToHome();
                            // Get.offAllNamed(Routes.HOME);
                            Get.offAllNamed(Routes.AFTER_LOGIN_SUBUSER);
                          },
                          color: Colors.yellow,
                          child: CustomText("ShipperRegisterLabelContinue".tr,
                              color: Color(ListColor.color4),
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ])),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
