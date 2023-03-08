import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class AppBarProfile extends PreferredSize {
  final String title;
  final Widget customBody;
  final List<Widget> prefixIcon;
  final VoidCallback onClickBack;
  final bool isBlueMode;
  final Widget titleWidget;
  final bool isWithShadow;
  final bool isWithBackgroundImage;
  final bool isCenter;

  AppBarProfile({
    Key key,
    this.title = '',
    this.customBody,
    this.prefixIcon,
    this.onClickBack,
    this.isBlueMode = false,
    this.isWithShadow = true,
    this.isWithBackgroundImage = false,
    this.isCenter = true,
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
              if (isWithBackgroundImage)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset('assets/fallin_star_3_icon.png',
                    width: GlobalVariable.ratioWidth(context) * 138,
                    height: GlobalVariable.ratioWidth(context) * 58.14,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
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
                          if (isCenter) 
                            Align(
                              alignment: Alignment.center,
                              child: _titleProfileWidget(),
                            )
                          else
                            Positioned(
                              left: GlobalVariable.ratioWidth(context) * 44,
                              right: GlobalVariable.ratioWidth(context) * 44,
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
      color: Color(isBlueMode ? ListColor.colorWhite : ListColor.colorBlue),
      fontWeight: FontWeight.w700,
      fontSize: 16,
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
