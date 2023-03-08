import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/background_stack_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

import 'error_register_email_still_verify_controller.dart';

class ErrorRegisterEmailStillVerifyView
    extends GetView<ErrorRegisterEmailStillVerifyController> {
  double _getWidthOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.width;
  double _getHeightOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double _getSizeSmallestWidthHeight(BuildContext context) =>
      _getWidthOfScreen(context) < _getHeightOfScreen(context)
          ? _getWidthOfScreen(context)
          : _getHeightOfScreen(context);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          body: BackgroundStackWidget(
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 80),
              SvgPicture.asset(
                "assets/email_still_verify_icon.svg",
                width: _getSizeSmallestWidthHeight(context) / 3.4,
                height: _getSizeSmallestWidthHeight(context) / 3.4,
              ),
              SizedBox(
                height: 28,
              ),
              CustomText(
                'RegisterLabelErrorEmailStillVerify'.tr,
                textAlign: TextAlign.center,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(ListColor.color2),
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        'RegisterLabelYourEmail'.tr,
                        textAlign: TextAlign.center,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(ListColor.color2),
                      ),
                      CustomText(
                        controller.email,
                        textAlign: TextAlign.center,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(ListColor.color2),
                      ),
                    ]),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(height: 80),
                  CustomText(
                    'RegisterLabelClickReRegister'.tr,
                    textAlign: TextAlign.center,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(ListColor.color2),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      color: Color(ListColor.color5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                      onPressed: () {
                        controller.reRegister();
                      },
                      child: CustomText('RegisterLabelButtonReRegister'.tr,
                              fontSize: 16,
                              color: Color(ListColor.color4),
                              fontWeight: FontWeight.w800)),
                  Container(height: 50),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
