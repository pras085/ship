import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/api_login_register.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/forgot_password/forgot_password_controller.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/form_password_profile/form_password_profile_controller.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/otp_profile/otp_profile_controller.dart';
import 'package:muatmuat/app/modules/login/model_data.dart';
import 'package:muatmuat/app/modules/otp_forget_password/otp_forget_password_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class FormPasswordProfileView extends GetView<FormPasswordProfileController> {
  @override
  Widget build(BuildContext context) {
    print('build form password profile');
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
                        GlobalVariable.ratioWidth(Get.context) * 0
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomBackButton2(
                            context: Get.context,
                            onTap: () {
                              Get.back();
                            }
                          ),
                          Container(
                            width: GlobalVariable.ratioWidth(Get.context) * 120,
                            height: GlobalVariable.ratioWidth(Get.context) * 33,
                            child: SvgPicture.asset(
                              'assets/ic_logo_muatmuat_putih.svg',
                              width: GlobalVariable.ratioWidth(Get.context) * 120,
                            )
                          ),
                          Container(
                            height: GlobalVariable.ratioWidth(context) * 32,
                            width: GlobalVariable.ratioWidth(context) * 32,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 32,
                        bottom: GlobalVariable.ratioWidth(Get.context) * 24,
                      ),
                      width: GlobalVariable.ratioWidth(Get.context) * 120,
                      height: GlobalVariable.ratioWidth(Get.context) * 120,
                      child: SvgPicture.asset(
                        'assets/ic_input_password_profile.svg',
                        width: GlobalVariable.ratioWidth(Get.context) * 120,
                      )
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
                          topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
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
                                      GlobalVariable.ratioWidth(Get.context) * 16,
                                      GlobalVariable.ratioWidth(Get.context) * 24,
                                      GlobalVariable.ratioWidth(Get.context) * 16,
                                      GlobalVariable.ratioWidth(Get.context) * 0
                                    ),
                                    child: CustomText(
                                      "Masukkan Password Lama",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                      GlobalVariable.ratioWidth(Get.context) * 35,
                                      GlobalVariable.ratioWidth(Get.context) * 10,
                                      GlobalVariable.ratioWidth(Get.context) * 35,
                                      GlobalVariable.ratioWidth(Get.context) * 24
                                    ),
                                    child: CustomText(
                                      "Untuk mengganti password, Anda perlu memasukkan password lama Anda terlebih dahulu",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      height: 1.2,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Obx(() => 
                                    Container(
                                      height: GlobalVariable.ratioWidth(Get.context) * 40,
                                      margin: EdgeInsets.fromLTRB(
                                        GlobalVariable.ratioWidth(Get.context) * 16,
                                        GlobalVariable.ratioWidth(Get.context) * 0,
                                        GlobalVariable.ratioWidth(Get.context) * 16,
                                        GlobalVariable.ratioWidth(Get.context) * 12
                                      ),
                                      // TARUH BORDER TEXTFIELD DISINI
                                      decoration: BoxDecoration(
                                        border: Border.all(width: GlobalVariable.ratioWidth(Get.context) * 1,
                                          color: controller.isValid.value
                                            ? Color(ListColor.colorLightGrey10)
                                            : Color(ListColor.colorRed)
                                        ),
                                        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) *6)
                                      ),
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
                                                obscureText: !controller.isShowPassword.value,
                                                obscuringCharacter: '\u2022',
                                                onChanged: (value) {
                                                  // controller.searchOnChange(value);
                                                  controller.isValid.value = true;
                                                  if (value.isNotEmpty) {
                                                    controller.isFilled.value = true;
                                                    controller.field1.value = value;
                                                  } 
                                                  else {
                                                    controller.isFilled.value = false;
                                                    controller.field1.value = value;
                                                  }
                                                  print("Filled: " + controller.isFilled.value.toString());
                                                  print("Valid: " + controller.isValid.value.toString());
                                                },
                                                controller: controller.passwordController,
                                                textInputAction: TextInputAction.next,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                  height: 1.2,
                                                ),
                                                textSize: 14,
                                                newInputDecoration: InputDecoration(
                                                  hintText: "Password Lama",
                                                  hintStyle: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(ListColor.colorLightGrey2)
                                                  ),
                                                  fillColor: Colors.transparent,
                                                  filled: true,
                                                  isDense: true,
                                                  isCollapsed: true,
                                                  focusedBorder: InputBorder.none,
                                                  enabledBorder: InputBorder.none,
                                                  border: InputBorder.none,
                                                  disabledBorder: InputBorder.none,
                                                  contentPadding: EdgeInsets.fromLTRB(
                                                    GlobalVariable.ratioWidth(Get.context) * 46,
                                                    GlobalVariable.ratioWidth(Get.context) * 13,
                                                    GlobalVariable.ratioWidth(Get.context) * 48,
                                                    GlobalVariable.ratioWidth(Get.context) * 0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // TARUH ICON DISINI
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(Get.context) * 12
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/ic_password_seller.svg",
                                              width: GlobalVariable.ratioWidth(Get.context) * 24,
                                              height: GlobalVariable.ratioWidth(Get.context) * 24,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                controller.togglePassword();
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  right: GlobalVariable.ratioWidth(Get.context) * 12
                                                ),
                                                height: GlobalVariable.ratioWidth(Get.context) * 24,
                                                width: GlobalVariable.ratioWidth(Get.context) * 24,
                                                alignment: Alignment.center,
                                                child: SvgPicture.asset(
                                                  controller.isShowPassword.value
                                                    ? "assets/ic_visible_password.svg"
                                                    : "assets/ic_invisible_password.svg",
                                                  width: GlobalVariable.ratioWidth(Get.context) * 24,
                                                )
                                              )
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ), 
                                  Container(
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.fromLTRB(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                        GlobalVariable.ratioWidth(Get.context) *
                                            0,
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                        GlobalVariable.ratioWidth(Get.context) *
                                            32),
                                    child: GestureDetector(
                                      onTap: () async {
                                        print("lupa password");
                                        // GetToPage.toNamed<ForgotPasswordController>(Routes.FORGOT_PASSWORD);

                                        var response = await ApiLoginRegister(
                                          context: Get.context,
                                          isShowDialogError: true,
                                          isShowDialogLoading: true,
                                        ).forgotPassword({
                                          "Phone": GlobalVariable.userModelGlobal.phone,
                                          "App": "1"
                                        });
                                        
                                        if (response != null) {
                                          if (response["Message"]["Code"] == 200) {
                                            var result = await GetToPage.toNamed<OtpForgetPasswordController>(
                                              Routes.OTP_FORGET_PASSWORD,
                                              arguments: GlobalVariable.userModelGlobal.phone,
                                            );
                                            
                                            if (result != null) {
                                              if (result) {
                                                Get.back(result: true);
                                              }
                                            }
                                          } 
                                          else {
                                            controller.isValid.value = false;
                                            String errorMessage = response["Data"];
                                            print('errornya $errorMessage');
                                            CustomToastTop.show(
                                              context: Get.context,
                                              message: errorMessage,
                                              isSuccess: 0
                                            );
                                          }
                                        }
                                      },
                                      child: CustomText(
                                        "GeneralLRLoginLabelLupaPassword".tr,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(ListColor.colorBlue),
                                      ),
                                    ),
                                  ),                               
                                  Obx(() => 
                                    _button(
                                      height: 36,
                                      marginLeft: 16,
                                      marginRight: 16,
                                      useBorder: false,
                                      borderRadius: 18,
                                      text: "Selanjutnya",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: !controller.isFilled.value
                                        ? Color(ListColor.colorLightGrey4)
                                        : Colors.white,
                                      backgroundColor: !controller.isFilled.value
                                        ? Color(ListColor.colorLightGrey2)
                                        : Color(ListColor.colorBlue),
                                      onTap: () async {
                                        String password = controller.passwordController.text;
                                        String passwordBase64 = base64.encode(utf8.encode(password));
                                        final validatorPassword = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])');
                                        
                                        if (controller.isFilled.value) {
                                          if(Utils.validateFormatPassword(password) != ""){
                                            CustomToastTop.show(
                                              context: context, 
                                              message: Utils.validateFormatPassword(password),
                                              isSuccess: 0
                                            );
                                            controller.isValid.value = false;
                                            return;
                                          }
                                          
                                          MessageFromUrlModel message;
                                          
                                          var body = {
                                            "password_lama": passwordBase64
                                          };

                                          var response = await ApiProfile(
                                            context: Get.context,
                                            isShowDialogLoading: true,
                                            isShowDialogError: true,
                                            isDebugGetResponse: true,
                                          ).doCheckPasswordUsers(body);

                                          message = response['Message'] != null
                                            ? MessageFromUrlModel.fromJson(response['Message'])
                                            : null;
                                          if (message != null && message.code == 200) {
                                            var param = {
                                              "phone": GlobalVariable.userModelGlobal.phone,
                                              "otp": TipeOtpProfil.PASSWORD
                                            };

                                            GetToPage.offNamed<OtpProfileController>(
                                              Routes.OTP_PROFILE,
                                              arguments: param
                                            );
                                          } 
                                          else {
                                            CustomToastTop.show(
                                              message: response['Data']['Message'],
                                              context: Get.context,
                                              isSuccess: 0,
                                            );
                                          }

                                          // GetToPage.toNamed<OtpProfileController>(Routes.OTP_PROFILE, arguments: "085103382834");
                                        }
                                      }
                                    ),
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