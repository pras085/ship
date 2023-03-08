import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_notifikasi/manajemen_notifikasi_aplikasi/manajemen_notifikasi_aplikasi_controller.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_notifikasi/manajemen_notifikasi_email/manajemen_notifikasi_email_controller.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_notifikasi/ringkasan_manajemen_notifikasi/ringkasan_manajemen_notifikasi_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'manajemen_notifikasi_controller.dart';

class ManajemenNotifikasiView extends GetView<ManajemenNotifikasiController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back();
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarDetailProfil(
          type: 1,
          onClickBack: () {
            Get.back();
          },
          title: "Manajemen Notifikasi"
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
              vertical: GlobalVariable.ratioWidth(Get.context) * 20,
            ),
            child: Column(
              children: [
                _listItem((){
                  GetToPage.toNamed<ManajemenNotifikasiEmailController>(Routes.MANAJEMEN_NOTIFIKASI_EMAIL);
                }, 
                  "Notifikasi di Email", false),
                _listItem((){
                  GetToPage.toNamed<ManajemenNotifikasiAplikasiController>(Routes.MANAJEMEN_NOTIFIKASI_APLIKASI);
                }, 
                  "Notifikasi di Aplikasi", false),
                _listItem((){
                  GetToPage.toNamed<RingkasanManajemenNotifikasiController>(Routes.RINGKASAN_MANAJEMEN_NOTIFIKASI);
                }, 
                  "Ringkasan", true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listItem(Function onTap, String text, bool isLast) {
    return GestureDetector(
      onTap: (){onTap();},
      child: Container(
        margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 18),
        decoration: BoxDecoration(
          border: (!isLast) 
            ? Border(
                bottom: BorderSide(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(ListColor.colorStroke),
                )
              )
            : null
        ),
        height: GlobalVariable.ratioWidth(Get.context) * 42,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
              ),
              child: SvgPicture.asset(
                "assets/ic_arrow_right_subscription.svg",
                color: Color(ListColor.colorGrey3),
                width: GlobalVariable.ratioWidth(Get.context) * 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarDetailProfil extends PreferredSize {
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
      backgroundColor = Color(ListColor.colorBlue);
      color = Color(ListColor.colorWhite);
    }
    else if(type == 2){
      backgroundColor = Color(ListColor.colorYellowTransporter);
      color = Color(ListColor.colorBlack);
    }
    else if(type == 3){
      backgroundColor = Color(ListColor.colorLightBlue11);
      color = Color(ListColor.colorWhite);
    }

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
                          Positioned(
                            top: 5,
                            right: 0,
                            child: Image(
                              image: AssetImage("assets/fallin_star_3_icon.png"),
                              height: GlobalVariable.ratioWidth(context) * 56,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
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
      fontWeight: FontWeight.w700,
      fontSize: 16,
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