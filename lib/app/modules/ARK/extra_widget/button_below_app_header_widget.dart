import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

class ButtonBelowAppHeaderWidget extends StatelessWidget {
  void Function() onTap;
  String title = "";
  Color backgroundColor = Colors.white;
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
    borderRadius = borderRadius ?? 20;
    return Container(
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
              width: 1, color: borderColor ?? Color(ListColor.colorLightGrey))),
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  prefixIcon != null
                      ? Row(mainAxisSize: MainAxisSize.min, children: [
                          prefixIcon,
                          SizedBox(
                            width: 10,
                          ),
                        ])
                      : SizedBox.shrink(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: CustomText(title,
                        fontWeight: titleFontWeight == null
                            ? FontWeight.w500
                            : titleFontWeight,
                        color: titleColor ?? Color(ListColor.colorDarkBlue2)),
                  ),
                  suffixIcon != null
                      ? Row(mainAxisSize: MainAxisSize.min, children: [
                          SizedBox(
                            width: 5,
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
