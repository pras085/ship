import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/create_password_subuser/create_password_subuser_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/text_form_field_widget.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'dart:math' as math;
import 'package:validators/validators.dart' as validator;

class CreatePasswordSubUserView
    extends GetView<CreatePasswordSubUserController> {
  double angka1(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 8;
  double panjangIsiButton(BuildContext context) =>
      (MediaQuery.of(context).size.width - 20) * 4 / 5;
  double widthContent(BuildContext context) =>
      MediaQuery.of(context).size.width - 40;

  DateTime currentBackPressTime;

  //LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    print('build create password seller');
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Color(ListColor.colorBlue),
          statusBarIconBrightness: Brightness.light),
      child: Container(
        color: Color(ListColor.color4),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child:
                    // WillPopScope(
                    //   onWillPop: controller.isFromIntro2.value ? null : onWillPop,
                    // child:
                    Stack(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      color: Color(ListColor.colorBlue),
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.asset(
                        GlobalVariable.imagePath + "meteor_putih.png",
                        width: GlobalVariable.ratioWidth(Get.context) * 91,
                        height: GlobalVariable.ratioWidth(Get.context) * 91,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              GlobalVariable.ratioWidth(Get.context) * 16,
                              GlobalVariable.ratioWidth(Get.context) * 24,
                              GlobalVariable.ratioWidth(Get.context) * 16,
                              GlobalVariable.ratioWidth(Get.context) * 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                              ),
                              // Container(
                              //     child: GestureDetector(
                              //         onTap: () {
                              //           Get.back();
                              //         },
                              //         child: SvgPicture.asset(
                              //             GlobalVariable.imagePath + "ic_back_button.svg",
                              //             width: GlobalVariable.ratioWidth(
                              //                     Get.context) *
                              //                 24,
                              //             height: GlobalVariable.ratioWidth(
                              //                     Get.context) *
                              //                 24,
                              //             color: GlobalVariable
                              //                 .tabDetailAcessoriesMainColor))),
                              Column(children: [
                                Container(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            120,
                                    // height:
                                    //     GlobalVariable.ratioWidth(Get.context) * 33,
                                    child: SvgPicture.asset(
                                      'assets/muatmuat logo.svg',
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          120,
                                    )),
                                // CustomText(
                                //   "ManajemenUserBuatPasswordSellerPartner".tr,
                                //   fontSize: 10,
                                //   fontWeight: FontWeight.w600,
                                //   color: Colors.white,
                                // ),
                              ]),
                              Container(
                                height: GlobalVariable.ratioWidth(context) * 32,
                                width: GlobalVariable.ratioWidth(context) * 32,
                              )
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 20,
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 20,
                            ),
                            width: GlobalVariable.ratioWidth(Get.context) * 120,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 120,
                            child: SvgPicture.asset(
                              'assets/Ilustrasi Buat Password.svg',
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 120,
                            )),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 20),
                              topRight: Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 20),
                            ),
                            child: Container(
                              color: Colors.white,
                              width: double.infinity,
                              child: SingleChildScrollView(
                                child: Form(
                                  key: controller.formKey.value,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                24,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                23),
                                        child: CustomText(
                                          "ManajemenUserBuatPasswordCreatePassword"
                                              .tr,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            0,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                24),
                                        child: CustomText(
                                          "ManajemenUserBuatPasswordEmailUserAndaBerhasilDidaftarkan"
                                              .tr,
                                          fontSize: 14,
                                          height: 1.4,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color(ListColor.colorLightGrey4),
                                        ),
                                      ),
                                      Obx(
                                        () => Container(
                                          margin: EdgeInsets.fromLTRB(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  0,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16),
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              40,
                                          // TARUH BORDER TEXTFIELD DISINI
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          1,
                                                  color: controller
                                                          .isValid.value
                                                      ? Color(ListColor
                                                          .colorLightGrey10)
                                                      : Color(
                                                          ListColor.colorRed)),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          6)),
                                          child: Stack(
                                            alignment: Alignment.centerLeft,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  CustomTextField(
                                                      context: Get.context,
                                                      autofocus: true,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      obscureText: !controller
                                                          .isShowPassword.value,
                                                      obscuringCharacter:
                                                          '\u2022',
                                                      onChanged: (value) {
                                                        controller
                                                            .checkFilledAll();
                                                      },
                                                      controller: controller
                                                          .passwordController
                                                          .value,
                                                      textSize: 14,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      newInputDecoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        isCollapsed: true,
                                                        hintText:
                                                            "ManajemenUserBuatPasswordMasukkanPasswordBaru"
                                                                .tr, // Cari User
                                                        fillColor: Colors.white,
                                                        hintStyle: TextStyle(
                                                          color: Color(ListColor
                                                              .colorLightGrey2),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        filled: true,
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                          left: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              46,
                                                          right: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              48,
                                                          top: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              11.5,
                                                          bottom: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              0,
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  // color: Color(ListColor
                                                                  //     .colorLightGrey7),
                                                                  color: Colors
                                                                      .white,
                                                                  width: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      1),
                                                          borderRadius: BorderRadius
                                                              .circular(GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  7),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  // color: Color(ListColor
                                                                  //     .colorLightGrey7),

                                                                  color: Colors
                                                                      .white,
                                                                  width: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      1),
                                                          borderRadius: BorderRadius
                                                              .circular(GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  7),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  // color: Color(
                                                                  //     ListColor.color4),

                                                                  color: Colors
                                                                      .white,
                                                                  width: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      1),
                                                          borderRadius: BorderRadius
                                                              .circular(GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  7),
                                                        ),
                                                      ))
                                                ],
                                              ),
                                              // TARUH ICON DISINI
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12),
                                                child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      "Lock.svg",
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24,
                                                ),
                                              ),
                                              Align(
                                                  alignment: Alignment
                                                      .centerRight,
                                                  child:
                                                      // controller.isShowClearSearch.value ?
                                                      GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .togglePassword();
                                                          },
                                                          child: Container(
                                                              margin: EdgeInsets.only(
                                                                  right:
                                                                      GlobalVariable.ratioWidth(Get.context) *
                                                                          12),
                                                              height: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get
                                                                              .context) *
                                                                  24,
                                                              width: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  24,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: SvgPicture
                                                                  .asset(
                                                                controller
                                                                        .isShowPassword
                                                                        .value
                                                                    ? GlobalVariable
                                                                            .imagePath +
                                                                        "Eye opened orange.svg"
                                                                    : GlobalVariable
                                                                            .imagePath +
                                                                        "Eyes closed grey.svg",
                                                                width: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    24,
                                                              ))
                                                          // Container(
                                                          //   margin: EdgeInsets.only(right: 10),
                                                          //   child: Icon(
                                                          //     Icons.close_rounded,
                                                          //     color:
                                                          //         Color(ListColor.colorLightGrey14),
                                                          //     size: 20,
                                                          //   ),
                                                          // ),
                                                          )
                                                  // : SizedBox.shrink(),
                                                  ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => Container(
                                          margin: EdgeInsets.fromLTRB(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  0,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  32),
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              40,
                                          // TARUH BORDER TEXTFIELD DISINI
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          1,
                                                  color: controller
                                                          .isValid.value
                                                      ? Color(ListColor
                                                          .colorLightGrey10)
                                                      : Color(
                                                          ListColor.colorRed)),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          6)),
                                          child: Stack(
                                            alignment: Alignment.centerLeft,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  CustomTextField(
                                                      context: Get.context,
                                                      autofocus: true,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      obscureText: !controller
                                                          .isShowConfirmPassword
                                                          .value,
                                                      obscuringCharacter:
                                                          '\u2022',
                                                      onChanged: (value) {
                                                        controller
                                                            .checkFilledAll();
                                                      },
                                                      controller: controller
                                                          .confirmPasswordController
                                                          .value,
                                                      textSize: 14,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      newInputDecoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        isCollapsed: true,
                                                        hintText:
                                                            "ManajemenUserBuatPasswordKonfirmasiPasswordBaru"
                                                                .tr, // Cari User
                                                        fillColor: Colors.white,
                                                        hintStyle: TextStyle(
                                                          color: Color(ListColor
                                                              .colorLightGrey2),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        filled: true,
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                          left: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              46,
                                                          right: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              48,
                                                          top: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              11.5,
                                                          bottom: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              0,
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  // color: Color(ListColor
                                                                  //     .colorLightGrey7),
                                                                  color: Colors
                                                                      .white,
                                                                  width: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      1),
                                                          borderRadius: BorderRadius
                                                              .circular(GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  7),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  // color: Color(
                                                                  // ListColor
                                                                  //     .colorLightGrey7),

                                                                  color: Colors
                                                                      .white,
                                                                  width: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      1),
                                                          borderRadius: BorderRadius
                                                              .circular(GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  7),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  // color: Color(
                                                                  //     ListColor
                                                                  //         .color4),

                                                                  color: Colors
                                                                      .white,
                                                                  width: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      1),
                                                          borderRadius: BorderRadius
                                                              .circular(GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  7),
                                                        ),
                                                      ))
                                                ],
                                              ),
                                              // TARUH ICON DISINI
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12),
                                                child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      "Lock.svg",
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24,
                                                ),
                                              ),
                                              Align(
                                                  alignment: Alignment
                                                      .centerRight,
                                                  child:
                                                      // controller.isShowClearSearch.value ?
                                                      GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .toggleConfirmPassword();
                                                          },
                                                          child: Container(
                                                              margin: EdgeInsets.only(
                                                                  right:
                                                                      GlobalVariable.ratioWidth(Get.context) *
                                                                          12),
                                                              height: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get
                                                                              .context) *
                                                                  24,
                                                              width: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  24,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: SvgPicture
                                                                  .asset(
                                                                controller
                                                                        .isShowConfirmPassword
                                                                        .value
                                                                    ? GlobalVariable
                                                                            .imagePath +
                                                                        "Eye opened orange.svg"
                                                                    : GlobalVariable
                                                                            .imagePath +
                                                                        "Eyes closed grey.svg",
                                                                width: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    24,
                                                              ))
                                                          // Container(
                                                          //   margin: EdgeInsets.only(right: 10),
                                                          //   child: Icon(
                                                          //     Icons.close_rounded,
                                                          //     color:
                                                          //         Color(ListColor.colorLightGrey14),
                                                          //     size: 20,
                                                          //   ),
                                                          // ),
                                                          )
                                                  // : SizedBox.shrink(),
                                                  ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // button cari akun
                                      Obx(
                                        () => _button(
                                            height: 36,
                                            marginLeft: 16,
                                            marginRight: 16,
                                            useBorder: false,
                                            borderRadius: 18,
                                            text:
                                                "ManajemenUserBuatPasswordLanjutkan"
                                                    .tr,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: !controller.isFilledAll.value
                                                ? Color(
                                                    ListColor.colorLightGrey4)
                                                : Colors.white,
                                            backgroundColor: !controller
                                                    .isFilledAll.value
                                                ? Color(
                                                    ListColor.colorLightGrey2)
                                                : Color(ListColor.colorBlue),
                                            onTap: () async {
                                              controller.onSubmit();
                                            }),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      // GestureDetector(
                                      //   onTap: () async{
                                      //     var result = await GetToPage.toNamed<
                                      //                         SuccessCreatePasswordController>(
                                      //                     Routes
                                      //                         .SUCCESS_CREATE_PASSWORD);
                                      //                 if (result != null) {
                                      //                   if (result) {
                                      //                     Get.back(result: true);
                                      //                   }
                                      //                 }
                                      //   },
                                      //   child: Container(
                                      //     height: 40,
                                      //     width: 80,
                                      //     child: Center(child: Text('Klik Disini', style: TextStyle(color: Colors.white,))),
                                      //     color: Colors.blueAccent,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                // ),
                ),
          ),
        ),
      ),
    );
  }

  // Widget buttonCircular(Widget child, double height) {
  Widget buttonCircular(Widget child) {
    return Container(
      // height: height,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 40),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(ListColor.shadowColor4),
            blurRadius: 2,
            offset: Offset(0, 30 / 5),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _button({
    bool maxWidth = false,
    double width = 0,
    double height = 0,
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
    Color borderColor,
    double borderSize,
    double borderRadius,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 12,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: maxWidth ? double.infinity : null,
      height: GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorLightGrey).withOpacity(0.3),
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                  color: borderColor,
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
            onTap: onTap == null
                ? null
                : () {
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
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * borderRadius)),
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
