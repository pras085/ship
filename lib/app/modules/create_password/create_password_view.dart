import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/success_create_password/success_create_password_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import '../api_login_register.dart';
import 'create_password_controller.dart';

class CreatePasswordView extends GetView<CreatePasswordController> {
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
    return Container(
      color: Color(ListColor.color4),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body:
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
                      child: Image.asset("assets/meteor_putih.png", 
                        width: GlobalVariable.ratioWidth(Get.context) * 91, 
                        height: GlobalVariable.ratioWidth(Get.context) * 91,),
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
                              CustomBackButton(
                                  context: Get.context,
                                  onTap: () {
                                    Get.back();
                                  }),
                              Container(
                                  width: GlobalVariable.ratioWidth(Get.context) * 120,
                                  height: GlobalVariable.ratioWidth(Get.context) * 33,
                                  child: SvgPicture.asset(
                                    'assets/ic_logo_muatmuat_putih.svg',
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) * 120,
                                  )),
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
                              bottom: GlobalVariable.ratioWidth(Get.context) * 20,
                            ),
                            width: GlobalVariable.ratioWidth(Get.context) * 120,
                            height: GlobalVariable.ratioWidth(Get.context) * 120,
                            child: SvgPicture.asset(
                              'assets/ic_logo_create_password.svg',
                              width: GlobalVariable.ratioWidth(Get.context) * 120,
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
                                            GlobalVariable.ratioWidth(Get.context) *
                                                16,
                                            GlobalVariable.ratioWidth(Get.context) *
                                                24,
                                            GlobalVariable.ratioWidth(Get.context) *
                                                16,
                                            GlobalVariable.ratioWidth(Get.context) *
                                                24),
                                        child: CustomText(
                                          "Buat Password Baru",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Obx(
                                        () => Container(
                                          margin: EdgeInsets.fromLTRB(
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  16,
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  0,
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  16,
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  16),
                                          height:
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  40,
                                          // TARUH BORDER TEXTFIELD DISINI
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      1,
                                                  color: controller.isValid.value
                                                      ? Color(
                                                          ListColor.colorLightGrey10)
                                                      : Color(ListColor.colorRed)),
                                              borderRadius: BorderRadius.circular(
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      6)),
                                          child: Stack(
                                            alignment: Alignment.centerLeft,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  CustomTextFormField(
                                                    context: Get.context,
                                                    autofocus: false,
                                                    keyboardType: TextInputType.text,
                                                    obscureText: !controller
                                                        .isShowPassword.value,
                                                    obscuringCharacter: '\u2022',
                                                    onChanged: (value) {
                                                      // controller.searchOnChange(value);
                                                      controller.isValid.value = true;
                                                      if (value.isNotEmpty &&
                                                          controller
                                                              .confirmPasswordController
                                                              .text
                                                              .isNotEmpty) {
                                                        controller.isFilled.value =
                                                            true;
                                                        controller.field1.value = value;
                                                      } else {
                                                        controller.isFilled.value =
                                                            false;
                                                        controller.field1.value = value;
                                                      }
                                                      print("Filled: " +
                                                          controller.isFilled.value
                                                              .toString());
                                                      print("Valid: " +
                                                          controller.isValid.value
                                                              .toString());
                                                    },
                                                    controller:
                                                        controller.passwordController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black,
                                                      height: 1.2,
                                                    ),
                                                    textSize: 14,
                                                    newInputDecoration:
                                                        InputDecoration(
                                                      hintText:
                                                          "Masukkan Password Baru",
                                                      hintStyle: TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          color: Color(ListColor
                                                              .colorLightGrey2)),
                                                      fillColor: Colors.transparent,
                                                      filled: true,
                                                      isDense: true,
                                                      isCollapsed: true,
                                                      focusedBorder: InputBorder.none,
                                                      enabledBorder: InputBorder.none,
                                                      border: InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            46,
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            13,
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            48,
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // TARUH ICON DISINI
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        12),
                                                child: SvgPicture.asset(
                                                  "assets/ic_password_seller.svg",
                                                  width: GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      24,
                                                  height: GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      24,
                                                ),
                                              ),
                                              Align(
                                                  alignment: Alignment.centerRight,
                                                  child:
                                                      // controller.isShowClearSearch.value ?
                                                      GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .togglePassword();
                                                          },
                                                          child: Container(
                                                              margin: EdgeInsets.only(
                                                                  right: GlobalVariable
                                                                          .ratioWidth(Get
                                                                              .context) *
                                                                      12),
                                                              height: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  24,
                                                              width: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  24,
                                                              alignment:
                                                                  Alignment.center,
                                                              child: SvgPicture.asset(
                                                                controller
                                                                        .isShowPassword
                                                                        .value
                                                                    ? "assets/ic_visible_password.svg"
                                                                    : "assets/ic_invisible_password.svg",
                                                                width: GlobalVariable
                                                                        .ratioWidth(Get
                                                                            .context) *
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
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  16,
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  0,
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  16,
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  32),
                                          height:
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  40,
                                          // TARUH BORDER TEXTFIELD DISINI
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      1,
                                                  color: controller.isValid.value
                                                      ? Color(
                                                          ListColor.colorLightGrey10)
                                                      : Color(ListColor.colorRed)),
                                              borderRadius: BorderRadius.circular(
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      6)),
                                          child: Stack(
                                            alignment: Alignment.centerLeft,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  CustomTextFormField(
                                                    context: Get.context,
                                                    autofocus: false,
                                                    keyboardType: TextInputType.text,
                                                    obscureText: !controller
                                                        .isShowConfirmPassword.value,
                                                    obscuringCharacter: '\u2022',
                                                    onChanged: (value) {
                                                      // controller.searchOnChange(value);
                                                      controller.isValid.value = true;
                                                      if (value.isNotEmpty &&
                                                          controller
                                                              .passwordController
                                                              .text
                                                              .isNotEmpty) {
                                                        controller.isFilled.value =
                                                            true;
                                                            controller.field2.value = value;
                                                      } else {
                                                        controller.isFilled.value =
                                                            false;
                                                        controller.field2.value = value;
                                                      }
                                                      print("Filled: " +
                                                          controller.isFilled.value
                                                              .toString());
                                                      print("Valid: " +
                                                          controller.isValid.value
                                                              .toString());
                                                    },
                                                    controller: controller
                                                        .confirmPasswordController,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black,
                                                      height: 1.2,
                                                    ),
                                                    textSize: 14,
                                                    newInputDecoration:
                                                        InputDecoration(
                                                      hintText:
                                                          "Konfirmasi Password Baru",
                                                      hintStyle: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        color: Color(
                                                          ListColor.colorLightGrey2,
                                                        ),
                                                      ),
                                                      fillColor: Colors.transparent,
                                                      filled: true,
                                                      isDense: true,
                                                      isCollapsed: true,
                                                      focusedBorder: InputBorder.none,
                                                      enabledBorder: InputBorder.none,
                                                      border: InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            46,
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            13,
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            48,
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // TARUH ICON DISINI
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        12),
                                                child: SvgPicture.asset(
                                                  "assets/ic_password_seller.svg",
                                                  width: GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      24,
                                                  height: GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      24,
                                                ),
                                              ),
                                              Align(
                                                  alignment: Alignment.centerRight,
                                                  child:
                                                      // controller.isShowClearSearch.value ?
                                                      GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .toggleConfirmPassword();
                                                          },
                                                          child: Container(
                                                              margin: EdgeInsets.only(
                                                                  right: GlobalVariable
                                                                          .ratioWidth(Get
                                                                              .context) *
                                                                      12),
                                                              height: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  24,
                                                              width: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  24,
                                                              alignment:
                                                                  Alignment.center,
                                                              child: SvgPicture.asset(
                                                                controller
                                                                        .isShowConfirmPassword
                                                                        .value
                                                                    ? "assets/ic_visible_password.svg"
                                                                    : "assets/ic_invisible_password.svg",
                                                                width: GlobalVariable
                                                                        .ratioWidth(Get
                                                                            .context) *
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
                                            text: "Ubah Password",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: !controller.isFilled.value
                                                ? Color(ListColor.colorLightGrey4)
                                                : Colors.white,
                                            backgroundColor:
                                                !controller.isFilled.value
                                                    ? Color(ListColor.colorLightGrey2)
                                                    : Color(ListColor.colorBlue),
                                            onTap: () async {
                                              print("UBAH PASSWORD");
                                              String password = "";
                                              password = base64.encode(
                                                utf8.encode(
                                                  controller.passwordController.text,
                                                ),
                                              );
                                              final validatorPassword =
                                                  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])');
                                              
                                              if (controller.isFilled.value) {
                                                if(controller.field1.value == controller.field2.value){
                                                if(!validatorPassword.hasMatch(controller.field1.value) && controller.field1.value.length < 8){
                                                   CustomToastTop.show(
                                                    context: Get.context,
                                                    message: "Password harus terdapat huruf kecil, kapital, dan angka. Minimal 8 karakter!",
                                                    isSuccess: 0,
                                                  );
                                                }
                                                else 
                                                if(validatorPassword.hasMatch(controller.field1.value)){
                                                if (controller
                                                        .passwordController.text ==
                                                    controller
                                                        .confirmPasswordController
                                                        .text) {
                                                if(controller.field1.value.length < 8 || controller.field1.value.length < 8){
                                                  CustomToastTop.show(
                                                    context: Get.context,
                                                    message: "Password minimal terdapat 8 karakter!",
                                                    isSuccess: 0,
                                                  );
                                                  controller.isValid.value = false;
                                                }
                                                else{
                                                  var parameter = {
                                                    "Token": "${controller.token}",
                                                    "Phone": controller.phone,
                                                    "App": "1",
                                                    "Password": password
                                                  };

                                                  var response =
                                                      await ApiLoginRegister(
                                                    context: Get.context,
                                                    isShowDialogError: true,
                                                    isShowDialogLoading: true,
                                                  ).resetPassword(parameter);
                                                  if (kDebugMode)
                                                    print(
                                                        "RESPONSE CREATE NEW PASSWORD :: $response");
                                                  if (response != null) {
                                                    if (response["Message"]["Code"] ==
                                                        200) {
                                                      var result = await GetToPage.toNamed<
                                                              SuccessCreatePasswordController>(
                                                          Routes
                                                              .SUCCESS_CREATE_PASSWORD);
                                                      if (result != null) {
                                                        if (result) {
                                                          Get.back(result: true);
                                                        }
                                                      }
                                                    } else {
                                                      controller.isValid.value =
                                                          false;
                                                      String errorMessage =
                                                          response["Data"];
                                                      
                                                      print(errorMessage);
                                                      if(errorMessage.contains('sama')){
                                                        CustomToastTop.show(
                                                        context: Get.context,
                                                        message: 'Password Tidak Boleh Sama dengan yang\nLama!',
                                                        isSuccess: 0,
                                                      );
                                                      }else {
                                                        CustomToastTop.show(
                                                        context: Get.context,
                                                        message: errorMessage,
                                                        isSuccess: 0,
                                                      );
                                                      }
                                                    }
                                                  }
                                                }
                                                } else {
                                                  CustomToastTop.show(
                                                    context: Get.context,
                                                    message: "Password tidak sama!",
                                                    isSuccess: 0,
                                                  );
                                                  controller.isValid.value = false;
                                                }
                                                }
                                                else{
                                                   CustomToastTop.show(
                                                    context: Get.context,
                                                    message: "Password harus terdapat huruf kecil, kapital, dan angka!",
                                                    isSuccess: 0,
                                                  );
                                                  controller.isValid.value = false;
                                                }
                                              }
                                              else{
                                                CustomToastTop.show(
                                                    context: Get.context,
                                                    message: "Password tidak sama!",
                                                    isSuccess: 0,
                                                  );
                                                  controller.isValid.value = false;
                                              }
                                               
                                              }
                                            }),
                                      ),
                                      SizedBox(height: 30,),
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
    );
  }

  // Widget buttonCircular(Widget child, double height) {
  Widget buttonCircular(Widget child) {
    return Container(
      // height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
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

  Widget _signInButton(BuildContext context) {
    return buttonCircular(FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      // minWidth: 72,
      // height: 36,
      color: Colors.white,
      child: Center(
          child:
              Image(image: AssetImage("assets/google_logo.png"), height: 20.0)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      onPressed: () {
        controller.signInWithGoogle(context);
      },
    )
        // ,40
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


// Container(
                              //   margin: EdgeInsets.only(
                              //       top:
                              //           GlobalVariable.ratioWidth(Get.context) *
                              //               17.5),
                              //   width: GlobalVariable.ratioWidth(Get.context) *
                              //       328,
                              //   height:
                              //       GlobalVariable.ratioWidth(Get.context) * 42,
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(
                              //           GlobalVariable.ratioWidth(Get.context) *
                              //               66),
                              //       border: Border.all(
                              //           width: GlobalVariable.ratioWidth(
                              //                   Get.context) *
                              //               1,
                              //           color:
                              //               Color(ListColor.colorLightGrey10))),
                              //   child: Material(
                              //     color: Colors.transparent,
                              //     borderRadius: BorderRadius.circular(
                              //         GlobalVariable.ratioWidth(Get.context) *
                              //             66),
                              //     child: InkWell(
                              //       customBorder: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(
                              //               GlobalVariable.ratioWidth(
                              //                       Get.context) *
                              //                   66)),
                              //       onTap: () {
                              //         print("MASUK DENGAN GOOGLE");
                              //       },
                              //       child: Container(
                              //         child: Row(
                              //           mainAxisSize: MainAxisSize.max,
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.center,
                              //           children: [
                              //             Image(
                              //                 image: AssetImage(
                              //                     "assets/google_logo.png"),
                              //                 width: GlobalVariable.ratioWidth(
                              //                         Get.context) *
                              //                     16),
                              //             // SvgPicture.asset(
                              //             //   'assets/ic_info_grey.svg',
                              //             //   width: GlobalVariable.ratioWidth(
                              //             //           Get.context) *
                              //             //       16,
                              //             // ),
                              //             SizedBox(
                              //                 width: GlobalVariable.ratioWidth(
                              //                         Get.context) *
                              //                     12),
                              //             CustomText(
                              //               "Masuk dengan Google",
                              //               fontSize: 14,
                              //               fontWeight: FontWeight.w600,
                              //               color: Colors.black,
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),

// Container(
//                                 alignment: Alignment.center,
//                                 width: GlobalVariable.ratioWidth(Get.context) *
//                                     328,
//                                 height:
//                                     GlobalVariable.ratioWidth(Get.context) * 36,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(
//                                         GlobalVariable.ratioWidth(Get.context) *
//                                             18),
//                                     color: Color(ListColor.colorStroke)),
//                                 child: Material(
//                                   color: Colors.transparent,
//                                   borderRadius: BorderRadius.circular(
//                                       GlobalVariable.ratioWidth(Get.context) *
//                                           18),
//                                   child: InkWell(
//                                     customBorder: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(
//                                             GlobalVariable.ratioWidth(
//                                                     Get.context) *
//                                                 18)),
//                                     onTap: () {
//                                       print("MASUK");
//                                     },
//                                     child: CustomText(
//                                       "Masuk",
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       color: Color(ListColor.colorLightGrey4),
//                                     ),
//                                   ),
//                                 ),
//                               ),