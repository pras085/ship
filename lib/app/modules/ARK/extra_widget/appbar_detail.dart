import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class AppBarDetail extends PreferredSize {
  final String title;
  Widget bottom;
  Widget customBody;
  Widget prefixIcon;
  void Function() onClickBack;

  @override
  final Size preferredSize = GlobalVariable.preferredSizeAppBar;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: preferredSize.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 64,
              color: Colors.white,
              child: Stack(children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: customBody == null
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: _backButtonWidget()),
                            Align(
                                alignment: Alignment.center,
                                child: _titleProfileWidget()),
                            prefixIcon != null
                                ? Align(
                                    alignment: Alignment.centerRight,
                                    child: prefixIcon)
                                : SizedBox.shrink()
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

  Widget _titleProfileWidget() {
    return Text(
      title,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
    );
  }

  Widget _backButtonWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        child: ClipOval(
          child: Material(
              shape: CircleBorder(),
              color: Color(ListColor.color4),
              child: InkWell(
                  onTap: () {
                    if (onClickBack == null)
                      Get.back();
                    else
                      onClickBack();
                  },
                  child: Container(
                      width: 30,
                      height: 30,
                      child: Center(
                          child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 30 * 0.7,
                        color: Colors.white,
                      ))))),
        ),
      ),
    );
  }

  AppBarDetail(
      {this.title,
      this.bottom,
      this.customBody,
      this.onClickBack,
      this.prefixIcon});
}
