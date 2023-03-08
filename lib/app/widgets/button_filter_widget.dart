import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/button_below_app_header_theme1_widget.dart';
import 'package:muatmuat/app/widgets/button_below_app_header_widget.dart';
import 'package:get/get.dart';
import 'package:muatmuat/global_variable.dart';

class ButtonFilterWidget extends StatelessWidget {
  void Function() onTap;
  String title = "GlobalFilterLabelButtonFilter".tr;
  bool isActive;
  bool isDisable;
  ButtonFilterWidget({
    @required this.onTap,
    this.isActive = false,
    this.isDisable = false,
  });
  @override
  Widget build(BuildContext context) {
    return ButtonBelowAppHeaderTheme1Widget(
      onTap: onTap,
      title: title,
      titleColor: isDisable ? Color(ListColor.colorLightGrey2) : null,
      backgroundColor: isActive
          ? Color(ListColor.colorLightBlue6)
          : Color(ListColor.colorWhite),
      isActive: isActive,
      suffixIcon: SvgPicture.asset(
        "assets/filter_icon.svg",
        height: GlobalVariable.ratioWidth(context) * 16,
        width: GlobalVariable.ratioWidth(context) * 16,
        color: isDisable
            ? Color(ListColor.colorLightGrey2)
            : Color(ListColor.color4),
      ),
      //      backgroundColor: isActive ? Color(ListColor.color4) : null,
      // borderColor: isActive ? Color(ListColor.color4) : null,
      // titleColor: isActive ? Colors.white : null,
      // suffixIcon: SvgPicture.asset("assets/filter_icon.svg",
      //     color: isActive ? Colors.white : Color(ListColor.color4)),
    );
  }
}
