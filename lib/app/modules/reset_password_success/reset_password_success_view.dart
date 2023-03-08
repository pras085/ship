import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/background_stack_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'reset_password_success_controller.dart';

class ResetPasswordSuccessView extends GetView<ResetPasswordSuccessController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundStackWidget(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/mail_icon.svg",
                  width: 104,
                  height: 104,
                ),
                SizedBox(height: 38),
                CustomText('ResetPasswordLabelSuccessSendEmail'.tr,
                    textAlign: TextAlign.center,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
                SizedBox(
                  height: 62,
                ),
                CustomText('ResetPasswordLabelYourEmail'.tr,
                    textAlign: TextAlign.center,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
                CustomText(controller.email.value,
                    textAlign: TextAlign.center,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
                SizedBox(
                  height: 62,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(ListColor.colorYellow)),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Get.back();
                            DeviceApps.openApp("com.google.android.gm");
                          },
                          child: Center(
                              child: CustomText('ResetPasswordLabelCekEmail'.tr,
                                  color: Color(ListColor.color4),
                                  fontWeight: FontWeight.w800))),
                    ))
              ]),
        ),
      ),
    );
  }
}
