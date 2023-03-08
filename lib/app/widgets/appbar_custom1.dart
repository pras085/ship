import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class AppBarCustom1 extends PreferredSize {
  final String title;
  Widget bottom;
  Widget customBody;
  double heightAppBarOnly;
  final bool centerTitle;
  final int color;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    heightAppBarOnly =
        heightAppBarOnly == null ? preferredSize.height : heightAppBarOnly;

    return SafeArea(
        child: Container(
      height: preferredSize.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: heightAppBarOnly,
              color: Color(color ?? ListColor.color4),
              child: Stack(children: [
                Positioned(
                  top: 5,
                  right: 0,
                  child: Image(
                    image: AssetImage("assets/fallin_star_3_icon.png"),
                    height: heightAppBarOnly,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: customBody == null
                      ? (centerTitle ?? true)
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: _backButtonWidget()),
                                Align(
                                    alignment: Alignment.center,
                                    child: _titleProfileWidget())
                              ],
                            )
                          : Row(
                              children: [
                                SizedBox(width: 12),
                                _backButtonWidget(),
                                SizedBox(width: 12),
                                _titleProfileWidget(
                                    fontSize: 18, fontWeight: FontWeight.w600)
                              ],
                            )
                      : customBody,
                )
              ])),
          bottom != null ? bottom : SizedBox.shrink(),
        ],
      ),
    ));
  }

  Widget _titleProfileWidget(
      {double fontSize = 18, FontWeight fontWeight = FontWeight.w700}) {
    return CustomText(
      title,
      color: Colors.white,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }

  Widget _backButtonWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        child: ClipOval(
          child: Material(
              shape: CircleBorder(),
              color: Colors.white,
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      width: 24,
                      height: 24,
                      child: Center(
                          child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 16, // 30 * 0.7,
                        color: Color(ListColor.color4),
                      ))))),
        ),
      ),
    );
  }

  AppBarCustom1(
      {this.preferredSize,
      this.title,
      this.bottom,
      this.heightAppBarOnly,
      this.customBody,
      this.centerTitle,
      this.color});
}
