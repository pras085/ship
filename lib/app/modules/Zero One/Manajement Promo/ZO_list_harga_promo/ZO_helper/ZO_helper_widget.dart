import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'dart:math' as math;

class ZoWidgetHelper {
  messageBottomNav(BuildContext context, String isiBody) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        margin: EdgeInsets.fromLTRB(
            0, 15, 0, GlobalVariable.ratioWidth(context) * 38),
        width: GlobalVariable.ratioWidth(context) * 148,
        height: GlobalVariable.ratioWidth(context) * 67,
        child: Stack(children: [
          Container(
            width: GlobalVariable.ratioWidth(context) * 148,
            height: GlobalVariable.ratioWidth(context) * 59,
            decoration: BoxDecoration(
              color: Color(ListColor.colorDarkGrey4),
              borderRadius: BorderRadius.circular(9),
              boxShadow: [
                BoxShadow(
                    color: Color(ListColor.colorLightGrey18), blurRadius: 18)
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: Container(
                  width: GlobalVariable.ratioWidth(context) * 24,
                  height: GlobalVariable.ratioWidth(context) * 24,
                  decoration: BoxDecoration(
                    color: Color(ListColor.colorDarkGrey4),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                          color: Color(ListColor.colorLightGrey18),
                          blurRadius: 18)
                    ],
                  ),
                ),
              )),
          Container(
              width: GlobalVariable.ratioWidth(context) * 148,
              height: GlobalVariable.ratioWidth(context) * 59,
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(ListColor.colorDarkGrey4),
                borderRadius: BorderRadius.circular(9),
              ),
              child: CustomText(isiBody,
                  fontSize: GlobalVariable.ratioFontSize(context) * 10,
                  height: GlobalVariable.ratioFontSize(context) * (15.54 / 12),
                  fontWeight: FontWeight.w500,
                  color: Color(ListColor.color2),
                  textAlign: TextAlign.center)),
        ]),
      ),
    ]);
  }

  listseparator() {
    return Container(
        height: 0.5,
        color: Color(ListColor.colorLightGrey10),
        margin: EdgeInsets.only(
            top: GlobalVariable.ratioWidth(Get.context) * 16,
            bottom: GlobalVariable.ratioWidth(Get.context) * 18));
  }

  Widget labelText(
      String title, Color color, double sizeFont, FontWeight fontweight,
      {double linespacing = 1, TextAlign align = TextAlign.left}) {
    return CustomText(
      title,
      textAlign: align,
      fontWeight: fontweight,
      fontSize: GlobalVariable.ratioFontSize(Get.context) * sizeFont,
      color: color,
      height: linespacing,
    );
  }

  Widget sizeBoxHeight(double height) {
    return SizedBox(height: GlobalVariable.ratioFontSize(Get.context) * height);
  }

  Widget sizeBoxWidth(double width) {
    return SizedBox(width: GlobalVariable.ratioFontSize(Get.context) * width);
  }
}
