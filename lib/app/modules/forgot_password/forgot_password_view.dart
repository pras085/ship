import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/otp_forget_password/otp_forget_password_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import '../api_login_register.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
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
    print('build forgot password seller');
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
                              CustomBackButton2(
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
                              'assets/ic_logo_forgot_password.svg',
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
                                                0),
                                        child: CustomText(
                                          "Temukan Akun Anda",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            GlobalVariable.ratioWidth(Get.context) *
                                                16,
                                            GlobalVariable.ratioWidth(Get.context) *
                                                8,
                                            GlobalVariable.ratioWidth(Get.context) *
                                                16,
                                            GlobalVariable.ratioWidth(Get.context) *
                                                24),
                                        child: CustomText(
                                          "Masukkan No. Whatsapp yang telah terhubung dengan akun muatmuat",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(ListColor.colorLightGrey4),
                                          height: 1.2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Obx(
                                        () => Container(
                                          height:
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  40,
                                          margin: EdgeInsets.fromLTRB(
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  16,
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  0,
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  16,
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  34),
                                          // TARUH BORDER TEXTFIELD DISINI
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                width: GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    1,
                                                color: controller.isValid.value
                                                    ? Color(
                                                        ListColor.colorLightGrey10)
                                                    : Color(ListColor.colorRed),
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      6)),
                                          padding: EdgeInsets.fromLTRB(
                                            GlobalVariable.ratioWidth(Get.context) *
                                                12,
                                            GlobalVariable.ratioWidth(Get.context) *
                                                8,
                                            GlobalVariable.ratioWidth(Get.context) *
                                                37,
                                            GlobalVariable.ratioWidth(Get.context) *
                                                8,
                                          ),
                                          child: Row(
                                            children: [
                                              // TARUH ICON DISINI
                                              Container(
                                                margin: EdgeInsets.only(
                                                  right: GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      8,
                                                ),
                                                child: SvgPicture.asset(
                                                  "assets/ic_whatsapp_seller.svg",
                                                  width: GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      24,
                                                  height: GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      24,
                                                ),
                                              ),
                                              Expanded(
                                                child: CustomTextFormField(
                                                  isShowCounter: false,
                                                  maxLength: 14,
                                                  context: Get.context,
                                                  autofocus: false,
                                                  onChanged: (value) {
                                                    // controller.searchOnChange(value);
                                                    controller.isValid.value = true;
                                                    if (value.isNotEmpty) {
                                                      controller.isFilled.value =
                                                          true;
                                                    } else {
                                                      controller.isFilled.value =
                                                          false;
                                                    }
                                                  },
                                                  controller:
                                                      controller.phoneController,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    height: 1.2,
                                                  ),
                                                  textSize: 14,
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.allow(
                                                        RegExp("[0-9]")),
                                                    LengthLimitingTextInputFormatter(
                                                        14),
                                                  ],
                                                  newInputDecoration: InputDecoration(
                                                    hintText:
                                                        "Masukkan nomor Whatsapp",
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
                                                    disabledBorder: InputBorder.none,
                                                    contentPadding: EdgeInsets.only(
                                                      top: GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          2,
                                                    ),
                                                  ),
                                                ),
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
                                            text: "Cari Akun",
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
                                              print("CARI AKUN");
                                              if (controller.isFilled.value) {
                                                if (!controller.checkRegex()) {
                                                  CustomToastTop.show(
                                                      context: Get.context,
                                                      message:
                                                          "Akun tidak ditemukan. Coba lagi dengan No. Handphone Lain",
                                                      isSuccess: 0);
                                                  controller.isValid.value = false;
                                                } else {
                                                  // SUCCESS
                                                  String phone =
                                                      controller.phoneController.text;

                                                  var parameter = {
                                                    "Phone": phone,
                                                    "App": "1"
                                                  };

                                                  var response =
                                                      await ApiLoginRegister(
                                                    context: Get.context,
                                                    isShowDialogError: true,
                                                    isShowDialogLoading: true,
                                                  ).forgotPassword(parameter);
                                                  if (response != null) {
                                                    if (response["Message"]["Code"] ==
                                                        200) {
                                                      var result = await GetToPage.toNamed<
                                                              OtpForgetPasswordController>(
                                                          Routes.OTP_FORGET_PASSWORD,
                                                          arguments: phone);
                                                      //     CreatePasswordSellerController>(
                                                      // Routes.CREATE_PASSWORD_SELLER);
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
                                                      print('errornya $errorMessage');
                                                      CustomToastTop.show(
                                                          context: Get.context,
                                                          message: errorMessage,
                                                          isSuccess: 0);
                                                    }
                                                  }

                                                  // var result = await GetToPage.toNamed<
                                                  //         CreatePasswordSellerController>(
                                                  //     Routes.CREATE_PASSWORD_SELLER);
                                                  // if (result != null) {
                                                  //   if (result) {
                                                  //     Get.back(result: true);
                                                  //   }
                                                  // }
                                                }
                                              }
                                            }),
                                      ),
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
