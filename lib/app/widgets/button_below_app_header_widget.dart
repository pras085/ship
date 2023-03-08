import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class ButtonBelowAppHeaderWidget extends StatelessWidget {
  void Function() onTap;
  String title = "";
  Color backgroundColor;
  Color borderColor;
  Color titleColor; //Color(ListColor.colorDarkBlue2)
  FontWeight titleFontWeight;
  Widget suffixIcon;
  Widget prefixIcon;
  double borderRadius;
  ButtonBelowAppHeaderWidget(
      {@required this.onTap,
      @required this.title,
      this.backgroundColor = Colors.white,
      this.borderColor,
      this.titleColor, //Color(ListColor.colorDarkBlue2)
      this.suffixIcon,
      this.prefixIcon,
      this.borderRadius,
      this.titleFontWeight});
  @override
  Widget build(BuildContext context) {
    borderRadius =
        GlobalVariable.ratioWidth(Get.context) * (borderRadius ?? 12);
    return Container(
      height: GlobalVariable.ratioWidth(Get.context) * 24,
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.colorLightGrey).withOpacity(0.3),
              blurRadius: 2,
              spreadRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
              width: GlobalVariable.ratioWidth(Get.context) * 1,
              color: borderColor ?? Color(ListColor.colorLightGrey))),
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 13),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  prefixIcon != null
                      ? Row(mainAxisSize: MainAxisSize.min, children: [
                          prefixIcon,
                          SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 5,
                          ),
                        ])
                      : SizedBox.shrink(),
                  Container(
                    // padding: EdgeInsets.symmetric(vertical: 5),
                    child: CustomText(title,
                        fontWeight: titleFontWeight == null
                            ? FontWeight.w500
                            : titleFontWeight,
                        color: titleColor ?? Color(ListColor.colorDarkBlue2)),
                  ),
                  suffixIcon != null
                      ? Row(mainAxisSize: MainAxisSize.min, children: [
                          SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 5,
                          ),
                          suffixIcon
                        ])
                      : SizedBox.shrink()
                ],
              ),
            )),
      ),
    );
  }
}
