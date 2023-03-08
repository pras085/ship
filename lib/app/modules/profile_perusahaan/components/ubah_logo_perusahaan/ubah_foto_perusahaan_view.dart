import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/modules/profile_perusahaan/components/ubah_logo_perusahaan/ubah_foto_perusahaan_controller.dart';
import 'package:muatmuat/app/modules/profile_perusahaan/profile_perusahaan_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class UbahLogoPerusahaanView extends GetView<UbahLogoPerusahaanController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    if (!controller.onCreate.value) {
      controller.onCreate.value = true;
      var checkId = Get.arguments;
      log('CHECK ::::: $checkId');
      //::::: : 1 - Galeri | 2 - Foto
      if (checkId == '1') {
        controller.getFromGallery();
      } else if (checkId == '2') {
        controller.getFromCamera();
      }
    }
    print('build ubah foto shipper');

    return WillPopScope(
      onWillPop: () async {
        controller.cancel();
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(ListColor.colorBlue),
        extendBodyBehindAppBar: true,
        appBar: AppBarProfile(
          isWithBackgroundImage: true,
          isBlueMode: true,
          isCenter: false,
          onClickBack: () => controller.cancel(),
          title: 'Ubah Logo Perusahaan',
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    Container(
                      color: Color(ListColor.colorLightGrey22),
                      width: GlobalVariable.ratioWidth(Get.context) * 360,
                      height: GlobalVariable.ratioWidth(Get.context) * 360,
                      padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 30),
                      child: Obx(
                        () => Stack(
                          children: [
                            Positioned(
                              top: 0,
                              child: Container(
                                color: Colors.white,
                                width: GlobalVariable.ratioWidth(Get.context) * 300,
                                height: GlobalVariable.ratioWidth(Get.context) * 300,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 900),
                                child: Container(
                                    color: Colors.black.withOpacity(0.1),
                                    width: GlobalVariable.ratioWidth(Get.context) * 300,
                                    height: GlobalVariable.ratioWidth(Get.context) * 300,
                                    child: controller.file.value.path != ""
                                        ? Image.file(
                                            controller.file.value,
                                            fit: BoxFit.contain,
                                          )
                                        : SizedBox.shrink()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        fit: StackFit.expand,
                        // clipBehavior: Clip.hardEdge,
                        children: [
                          Container(
                            child: Image.asset(
                              'assets/ic_gelombang.png',
                              fit: BoxFit.fitWidth,
                              alignment: AlignmentDirectional.bottomCenter,
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () => controller.showUpload(),
                                child: Container(
                                  alignment: Alignment.center,
                                  // margin: EdgeInsets.fromLTRB(
                                  //   GlobalVariable.ratioWidth(Get.context) * 113,
                                  //   GlobalVariable.ratioWidth(Get.context) * 88,
                                  //   GlobalVariable.ratioWidth(Get.context) * 113,
                                  //   GlobalVariable.ratioWidth(Get.context) * 12,
                                  // ),
                                  // padding: EdgeInsets.symmetric(
                                  //   horizontal: GlobalVariable.ratioWidth(Get.context) * 24,
                                  //   vertical: GlobalVariable.ratioWidth(Get.context) * 8,
                                  // ),
                                  width: GlobalVariable.ratioWidth(Get.context) * 134,
                                  height: GlobalVariable.ratioWidth(Get.context) * 30,
                                  decoration: BoxDecoration(
                                      color: Color(ListColor.colorWhite),
                                      border: Border.all(
                                        width: 1,
                                        color: Color(ListColor.colorBlue),
                                      ),
                                      borderRadius: BorderRadius.circular(18)),
                                  child: CustomText(
                                    'Ubah Foto',
                                    color: Color(ListColor.colorBlue),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
                              CustomText(
                                "Max, size foto 5MB",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(ListColor.colorWhite),
                              ),
                              // Image.asset('assets/ic_gelombang.png'),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // BUTTON
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: GlobalVariable.ratioWidth(Get.context) * 68,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        blurRadius: GlobalVariable.ratioWidth(Get.context) * 55,
                        spreadRadius: 0,
                        offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * -3),
                      )
                    ],
                  ),
                  child: _button(
                    marginLeft: 16,
                    marginTop: 16,
                    marginRight: 16,
                    marginBottom: 16,
                    borderRadius: 18,
                    onTap: () => controller.simpanFoto(),
                    backgroundColor: Color(ListColor.colorBlue),
                    text: 'Simpan Foto',
                    color: Color(ListColor.colorWhite),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    useBorder: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(
      {double height,
      double width,
      bool maxWidth = false,
      double marginLeft = 0,
      double marginTop = 0,
      double marginRight = 0,
      double marginBottom = 0,
      double paddingLeft = 0,
      double paddingTop = 0,
      double paddingRight = 0,
      double paddingBottom = 0,
      bool useShadow = false,
      bool useBorder = true,
      double borderRadius = 18,
      double borderSize = 1,
      String text = "",
      @required Function onTap,
      FontWeight fontWeight = FontWeight.w600,
      double fontSize = 12,
      Color color = Colors.white,
      Color backgroundColor = Colors.white,
      Color borderColor,
      Widget customWidget}) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * marginLeft,
        GlobalVariable.ratioWidth(Get.context) * marginTop,
        GlobalVariable.ratioWidth(Get.context) * marginRight,
        GlobalVariable.ratioWidth(Get.context) * marginBottom,
      ),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(Get.context).size.width
              : null
          : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null ? null : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(GlobalVariable.ratioWidth(Get.context) * paddingLeft, GlobalVariable.ratioWidth(Get.context) * paddingTop,
                  GlobalVariable.ratioWidth(Get.context) * paddingRight, GlobalVariable.ratioWidth(Get.context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: color,
                    )
                  : customWidget,
            )),
      ),
    );
  }
}

class AppBarBlueShipperProfile extends PreferredSize {
  final String title;
  Widget bottom;
  Widget customBody;
  double heightAppBarOnly;
  final bool centerTitle;
  final int color;
  var controller = Get.find<UbahLogoPerusahaanController>();

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    heightAppBarOnly = heightAppBarOnly == null ? preferredSize.height : heightAppBarOnly;

    return SafeArea(
        child: Container(
      height: preferredSize.height,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: GlobalVariable.ratioWidth(Get.context) * 15,
            spreadRadius: 0,
            offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 4))
      ]),
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
                                Align(alignment: Alignment.centerLeft, child: _backButtonWidget()),
                                Align(alignment: Alignment.center, child: _titleProfileWidget())
                              ],
                            )
                          : Row(
                              children: [SizedBox(width: 12), _backButtonWidget(), SizedBox(width: 12), _titleProfileWidget()],
                            )
                      : customBody,
                )
              ])),
          bottom != null ? bottom : SizedBox.shrink(),
        ],
      ),
    ));
  }

  Widget _titleProfileWidget({double fontSize = 16, FontWeight fontWeight = FontWeight.w700}) {
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
                log('test');
                controller.cancel();
              },
              child: Container(
                width: GlobalVariable.ratioWidth(Get.context) * 24,
                height: GlobalVariable.ratioWidth(Get.context) * 24,
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 16, // 30 * 0.7,
                    color: Color(ListColor.color4),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBarBlueShipperProfile({
    this.preferredSize,
    this.title,
    this.bottom,
    this.heightAppBarOnly,
    this.customBody,
    this.centerTitle,
    this.color,
  });
}
