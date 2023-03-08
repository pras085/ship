import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/form_pendaftaran_bf/form_pendaftaran_bf_controller.dart';
import 'package:muatmuat/app/modules/login/login_controller.dart';
// import 'package:muatmuat/app/modules/login_and_register/syarat_dan_ketentuan/syarat_dan_ketentuan_controller.dart';
import 'package:muatmuat/app/modules/api_login_register.dart';
import 'package:muatmuat/app/modules/register_google/register_google_controller.dart';
import 'package:muatmuat/app/modules/register_shipper_bf_tm/register_shipper_bf_tm_controller.dart';
import 'package:muatmuat/app/modules/terms_and_conditions_register/terms_and_conditions_register_controller.dart';
// import 'package:muatmuat/app/modules/works_seller/login_seller/login_seller_controller.dart';
// import 'package:muatmuat/app/modules/works_seller/register_seller_google/register_seller_google_controller.dart';
// import 'package:muatmuat/app/modules/works_seller/success_register_seller/success_register_seller_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/change_language_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/test_form_field_widget2.dart';
import 'package:muatmuat/app/widgets/text_form_field_widget.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:validators/validators.dart' as validator;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'upload_picture_controller.dart';

class UploadPictureView extends GetView<UploadPictureController> {
  @override
  Widget build(BuildContext context) {
    if (!controller.onCreate.value) {
      controller.onCreate.value = true;
      controller.getFromGallery();
    }
    print('build upload picture shipper');
    return Container(
      color: Color(ListColor.color4),
      child: SafeArea(
        top: true,
        child: Scaffold(
          extendBody: true,
          appBar: _AppBar(
            preferredSize: Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
          ),
          backgroundColor: Colors.white,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: Color(ListColor.colorLightGrey22),
                        width: GlobalVariable.ratioWidth(Get.context) * 360,
                        height: GlobalVariable.ratioWidth(Get.context) * 360,
                        padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 30),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              child: Container(
                                color: Color(ListColor.colorGreyWithOpacity),
                                width: GlobalVariable.ratioWidth(Get.context) * 300,
                                height: GlobalVariable.ratioWidth(Get.context) * 300,
                              ),
                            ),
                            Obx(() => 
                              Positioned(
                                top: 0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(Get.context) * 900
                                  ),
                                  child: Container(
                                    color: Colors.white,
                                    width: GlobalVariable.ratioWidth(Get.context) * 300,
                                    height: GlobalVariable.ratioWidth(Get.context) * 300,
                                    child: Image.file(controller.file.value),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(
                      //     GlobalVariable.ratioWidth(Get.context) * 0,
                      //     GlobalVariable.ratioWidth(Get.context) * 24,
                      //     GlobalVariable.ratioWidth(Get.context) * 0,
                      //     GlobalVariable.ratioWidth(Get.context) * 0
                      //   ),
                      //   width: GlobalVariable.ratioWidth(Get.context) * 32,
                      //   height: GlobalVariable.ratioWidth(Get.context) * 32,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 24),
                      //     color: Color(ListColor.colorLightGrey12)
                      //   ),
                      //   alignment: Alignment.center,
                      //   child: SvgPicture.asset(
                      //     'assets/ic_rotate.svg',
                      //     width: GlobalVariable.ratioWidth(Get.context) * 16,
                      //     height: GlobalVariable.ratioWidth(Get.context) * 16,
                      //   ),
                      // ),
                      _button(
                        width: 134,
                        height: 30,
                        marginLeft: 0,
                        marginTop: 32,
                        marginRight: 0,
                        marginBottom: 12,
                        useBorder: true,
                        backgroundColor: Colors.white,
                        color: Color(ListColor.colorBlue),
                        borderColor: Color(ListColor.colorBlue),
                        borderRadius: 18,
                        borderSize: 1,
                        text: "Ubah Foto",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        onTap: () {
                          controller.getFromGallery();
                        }
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: GlobalVariable.ratioWidth(Get.context) * 32
                        ),
                        child: CustomText(
                          "Max. size foto 5MB",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(ListColor.colorLightGrey4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() => 
                Container(
                  // margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 24),
                  // height: GlobalVariable.ratioWidth(Get.context) * 64,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: GlobalVariable.ratioWidth(Get.context) * 0.5,
                        color: Color(ListColor.colorLightGrey10)
                      )
                    ),
                    color: Colors.white
                  ),
                  child: _button(
                    marginLeft: 16,
                    marginTop: 16,
                    marginRight: 16,
                    marginBottom: 16,
                    maxWidth: true,
                    height: 32,
                    backgroundColor: Color(controller.canSave.value ? ListColor.colorBlue : ListColor.colorLightGrey2),
                    color: controller.canSave.value ? Colors.white : Color(ListColor.colorLightGrey4),
                    useBorder: false,
                    borderRadius: 18,
                    text: "Simpan Foto",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    onTap: () {
                      if(controller.canSave.value){
                        RegisterShipperBfTmController registerShipperBfTmController = Get.find();
                        if (controller.file.value != null) {
                          registerShipperBfTmController.filelogo.value = controller.file.value;
                          registerShipperBfTmController.picturefilllogo.value = true;
                        }
                        Get.back();
                      }
                    }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button({
    double height,
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
    bool useBorder = false,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(Get.context).size.width
              : null
          : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * paddingLeft,
                  GlobalVariable.ratioWidth(Get.context) * paddingTop,
                  GlobalVariable.ratioWidth(Get.context) * paddingRight,
                  GlobalVariable.ratioWidth(Get.context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text ?? "",
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

class _AppBar extends PreferredSize {
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    // var controller = Get.find<FormPendaftaranIndividuController>();
    return SafeArea(
        child: Container(
            height: preferredSize.height,
            color: Color(ListColor.colorBlue),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image(
                    image: AssetImage("assets/fallin_star_3_icon.png"),
                    height: GlobalVariable.ratioWidth(Get.context) * 67,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  width: MediaQuery.of(Get.context).size.width,
                  padding: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 16,
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                  ),
                  child: Row(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomBackButton(
                          context: Get.context,
                          onTap: () {
                            Get.back();
                          }),
                      // _CustomBackButton(
                      //     context: Get.context,
                      //     backgroundColor: Color(ListColor.color4),
                      //     iconColor: Color(ListColor.colorWhite),
                      //     onTap: () {
                      //       Get.back();
                      //     }),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: GlobalVariable.ratioWidth(Get.context) * 8),
                          child: CustomText(
                            'Upload Logo Perusahaan',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }

  _AppBar({this.preferredSize});
}

class _CustomBackButton extends StatelessWidget {
  final BuildContext context;
  final Function onTap;
  final Color iconColor;
  final Color backgroundColor;
  _CustomBackButton(
      {@required this.context,
      @required this.onTap,
      this.iconColor,
      this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    double radius = 25;
    return Container(
      height: GlobalVariable.ratioWidth(context) * 24,
      width: GlobalVariable.ratioWidth(context) * 24,
      decoration: BoxDecoration(
        color: backgroundColor ?? Color(ListColor.colorWhite),
        borderRadius:
            BorderRadius.circular(GlobalVariable.ratioWidth(context) * radius),
      ),
      child: Material(
        borderRadius:
            BorderRadius.circular(GlobalVariable.ratioWidth(context) * radius),
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                GlobalVariable.ratioWidth(context) * radius),
          ),
          onTap: () {
            onTap();
          },
          child: Container(
            child: SvgPicture.asset(
              "assets/ic_back_seller.svg",
              color: iconColor ?? Color(ListColor.colorBlue),
              width: GlobalVariable.ratioWidth(Get.context) * 24,
              height: GlobalVariable.ratioWidth(Get.context) * 24,
            ),
          ),
        ),
      ),
    );
  }
}
