import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/button_below_app_header_widget.dart';

class ButtonBelowAppHeaderTheme1Widget extends StatelessWidget {
  void Function() onTap;
  String title = "";
  bool isActive;
  Widget suffixIcon;
  Widget prefixIcon;
  double borderRadius;
  Color titleColor;
  FontWeight titleFontWeight;
  Color backgroundColor = Colors.white;
  ButtonBelowAppHeaderTheme1Widget(
      {@required this.onTap,
      @required this.title,
      this.isActive = false,
      this.suffixIcon,
      this.prefixIcon,
      this.borderRadius,
      this.titleColor,
      this.titleFontWeight,
      this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return ButtonBelowAppHeaderWidget(
        onTap: onTap,
        borderColor: isActive ? Color(ListColor.color4) : null,
        title: title,
        titleColor: isActive ? Color(ListColor.color4) : titleColor,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        borderRadius: borderRadius,
        titleFontWeight: titleFontWeight,
        backgroundColor: backgroundColor);
  }
}
