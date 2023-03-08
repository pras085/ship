import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/global_variable.dart';
import 'dart:math' as math;

class CustomBackButton extends StatelessWidget {
  final BuildContext context;
  final Function onTap;
  final Color iconColor;
  final Color backgroundColor;
  CustomBackButton({
    @required this.context,
    @required this.onTap,
    this.iconColor,
    this.backgroundColor,
  });
  @override
  Widget build(BuildContext context) {
    double radius = 12;
    return Container(
      height: GlobalVariable.ratioWidth(context) * 24,
      width: GlobalVariable.ratioWidth(context) * 24,
      decoration: BoxDecoration(
        color: backgroundColor ?? Color(ListColor.colorWhite),
        borderRadius: BorderRadius.circular(
          GlobalVariable.ratioWidth(context) * radius,
        ),
      ),
      child: Material(
        borderRadius:
            BorderRadius.circular(GlobalVariable.ratioWidth(context) * radius),
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                GlobalVariable.ratioWidth(context) * radius),
          ),
          onTap: () {
            if (onTap != null) onTap();
          },
          child: Container(
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: SvgPicture.asset(
                "assets/ic_arrow_right_subscription.svg",
                color: iconColor ?? Color(ListColor.colorBlue),
                // color: iconColor ?? Color(ListColor.colorRed),
                width: GlobalVariable.ratioWidth(Get.context) * 24,
                height: GlobalVariable.ratioWidth(Get.context) * 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomBackButton2 extends StatelessWidget {
  final BuildContext context;
  final Function onTap;
  final Color iconColor;
  final Color backgroundColor;
  CustomBackButton2(
      {@required this.context,
      @required this.onTap,
      this.iconColor,
      this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    double radius = 25;
    return Container(
      height: GlobalVariable.ratioWidth(context) * 32,
      width: GlobalVariable.ratioWidth(context) * 32,
      decoration: BoxDecoration(
        color: backgroundColor ?? Color(ListColor.colorWhite),
        borderRadius:
            BorderRadius.circular(GlobalVariable.ratioWidth(context) * radius),
      ),
      child: Material(
        borderRadius:
            BorderRadius.circular(GlobalVariable.ratioWidth(context) * radius),
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                GlobalVariable.ratioWidth(context) * radius),
          ),
          onTap: () {
            onTap();
          },
          child: Container(
            child: SvgPicture.asset(
              "assets/ic_back_blue_in_white.svg",
              width: GlobalVariable.ratioWidth(Get.context) * 32,
              height: GlobalVariable.ratioWidth(Get.context) * 32,
            ),
          ),
        ),
      ),
    );
  }
}