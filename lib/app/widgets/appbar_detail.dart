import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class AppBarDetail extends PreferredSize {
  final String title;
  final Widget customBody;
  final List<Widget> prefixIcon;
  final VoidCallback onClickBack;
  final bool isBlueMode;
  final Widget titleWidget;
  final bool isWithShadow;

  AppBarDetail({
    Key key,
    this.title = '',
    this.customBody,
    this.prefixIcon,
    this.onClickBack,
    this.isBlueMode = false,
    this.isWithShadow = true,
    this.titleWidget,
  });

  @override
  final Size preferredSize = GlobalVariable.preferredSizeAppBar;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(isBlueMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark);
    return Container(
      decoration: BoxDecoration(color: Color(isBlueMode ? ListColor.colorBlue : ListColor.colorWhite), boxShadow: [
        if (isWithShadow)
          BoxShadow(
            offset: Offset(
              GlobalVariable.ratioWidth(context) * 0,
              GlobalVariable.ratioWidth(context) * 4,
            ),
            blurRadius: GlobalVariable.ratioWidth(context) * 15,
            color: Colors.black.withOpacity(0.20),
          ),
      ]),
      child: SafeArea(
        child: Container(
          height: GlobalVariable.ratioWidth(context) * 56,
          color: Color(isBlueMode ? ListColor.colorBlue : ListColor.colorWhite),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                ),
                child: customBody == null
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: _backButtonWidget(context),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: _titleProfileWidget(),
                          ),
                          prefixIcon != null
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ...prefixIcon,
                                    ],
                                  ),
                                )
                              : SizedBox.shrink()
                        ],
                      )
                    : customBody,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleProfileWidget() {
    return titleWidget ?? CustomText(
      title,
      color: Color(isBlueMode ? ListColor.colorWhite : ListColor.colorBlack),
      fontWeight: FontWeight.w600,
      fontSize: 14,
      textAlign: TextAlign.center,
    );
  }

  Widget _backButtonWidget(context) {
    return CustomBackButton(
      context: context,
      backgroundColor: Color(isBlueMode ? ListColor.colorWhite : ListColor.colorBlue),
      iconColor: Color(isBlueMode ? ListColor.colorBlue : ListColor.colorWhite),
      onTap: onClickBack ?? Get.back,
    );
  }
}

class AppBarDetailProfil extends PreferredSize {
  SystemUiOverlayStyle style;
  Color color;
  Color backgroundColor;

  final String title;
  final Widget customBody;
  final List<Widget> prefixIcon;
  final VoidCallback onClickBack;
  final int type;
  final Widget titleWidget;
  final bool isWithShadow;

  AppBarDetailProfil({
    Key key,
    this.title = '',
    this.customBody,
    this.prefixIcon,
    this.onClickBack,
    this.type,
    this.isWithShadow = true,
    this.titleWidget,
  });

  @override
  final Size preferredSize = GlobalVariable.preferredSizeAppBar;

  @override
  Widget build(BuildContext context) {
    if(type == 1){
      style = SystemUiOverlayStyle.light;
      backgroundColor = Color(ListColor.colorBlue);
      color = Color(ListColor.colorWhite);
    }
    else if(type == 2){
      style = SystemUiOverlayStyle.dark;
      backgroundColor = Color(ListColor.colorYellowTransporter);
      color = Color(ListColor.colorBlack);
    }
    else if(type == 3){
      style = SystemUiOverlayStyle.light;
      backgroundColor = Color(ListColor.colorLightBlue11);
      color = Color(ListColor.colorWhite);
    }

    SystemChrome.setSystemUIOverlayStyle(style);
    return Container(
      decoration: BoxDecoration(color: backgroundColor, boxShadow: [
        if (isWithShadow)
          BoxShadow(
            offset: Offset(
              GlobalVariable.ratioWidth(context) * 0,
              GlobalVariable.ratioWidth(context) * 4,
            ),
            blurRadius: GlobalVariable.ratioWidth(context) * 15,
            color: Colors.black.withOpacity(0.20),
          ),
      ]),
      child: SafeArea(
        child: Container(
          height: GlobalVariable.ratioWidth(context) * 56,
          color: backgroundColor,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                ),
                child: customBody == null
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: _backButtonWidget(context),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: _titleProfileWidget(),
                          ),
                          prefixIcon != null
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ...prefixIcon,
                                    ],
                                  ),
                                )
                              : SizedBox.shrink()
                        ],
                      )
                    : customBody,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleProfileWidget() {
    return titleWidget ?? CustomText(
      title,
      color: color,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      textAlign: TextAlign.center,
    );
  }

  Widget _backButtonWidget(context) {
    return CustomBackButton(
      context: context,
      backgroundColor: color,
      iconColor: backgroundColor,
      onTap: onClickBack ?? Get.back,
    );
  }
}