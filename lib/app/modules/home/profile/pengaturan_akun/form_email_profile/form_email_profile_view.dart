import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/form_email_profile/form_email_profile_controller.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/otp_email_profile/otp_email_profile_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class FormEmailProfileView extends GetView<FormEmailProfileController> {
  @override
  Widget build(BuildContext context) {
    print('build form email profile');
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
                  child: Image.asset(
                    'assets/meteor_putih.png',
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
                        'assets/ic_input_email_profile.svg',
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
                                      "Masukkan email baru",
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
                                      "Pastikan email Anda aktif karena kami akan mengirim kode verifikasi ke email ini",
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
                                        GlobalVariable.ratioWidth(Get.context) * 32
                                      ),
                                      // TARUH BORDER TEXTFIELD DISINI
                                      decoration: BoxDecoration(
                                        border: Border.all(width: GlobalVariable.ratioWidth(Get.context) * 1,
                                          color: controller.isValid.value
                                            ? Color(
                                                ListColor.colorLightGrey10)
                                            : Color(ListColor.colorRed),
                                        ),
                                        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) *6)
                                      ),
                                      padding: EdgeInsets.fromLTRB(
                                        GlobalVariable.ratioWidth(Get.context) * 12,
                                        GlobalVariable.ratioWidth(Get.context) * 8,
                                        GlobalVariable.ratioWidth(Get.context) * 10,
                                        GlobalVariable.ratioWidth(Get.context) * 8,
                                      ),
                                      child: Row(
                                        children: [
                                          // TARUH ICON DISINI
                                          Container(
                                            margin: EdgeInsets.only(
                                              right: GlobalVariable.ratioWidth(Get.context) * 10,
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/ic_mail_seller.svg",
                                              width: GlobalVariable.ratioWidth(Get.context) * 24,
                                              height: GlobalVariable.ratioWidth(Get.context) * 24,
                                            ),
                                          ),
                                          Expanded(
                                            child: CustomTextFormField(
                                              isShowCounter: false,
                                              maxLength: 255,
                                              context: Get.context,
                                              autofocus: false,
                                              onChanged: (value) {
                                                // controller.searchOnChange(value);
                                                controller.isValid.value = true;
                                                if (value.isNotEmpty) {
                                                  controller.isFilled.value = true;
                                                  controller.email.value = value;
                                                } 
                                                else {
                                                  controller.isFilled.value = false;
                                                }
                                              },
                                              controller: controller.emailController,
                                              textInputAction: TextInputAction.done,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                height: 1.2,
                                              ),
                                              textSize: 14,
                                              keyboardType: TextInputType.emailAddress,
                                              // inputFormatters: [
                                              //   FilteringTextInputFormatter.allow(
                                              //       RegExp("[0-9]")),
                                              //   LengthLimitingTextInputFormatter(
                                              //       14),
                                              // ],
                                              newInputDecoration: InputDecoration(
                                                hintText: "Masukkan email",
                                                hintStyle: TextStyle(
                                                  fontSize: 14,
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
                                                contentPadding: EdgeInsets.only(
                                                  top: GlobalVariable.ratioWidth(Get.context) * 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // button cari akun
                                  Obx(() => 
                                    _button(
                                      height: 36,
                                      marginLeft: 16,
                                      marginRight: 16,
                                      useBorder: false,
                                      borderRadius: 18,
                                      text: "Verifikasi Email",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: !controller.isFilled.value
                                        ? Color(ListColor.colorLightGrey4)
                                        : Colors.white,
                                      backgroundColor: !controller.isFilled.value
                                        ? Color(ListColor.colorStroke)
                                        : Color(ListColor.colorBlue),
                                      onTap: () async {                                            
                                        if (controller.isFilled.value) {
                                          if(controller.checkRegex()){
                                            // SUCCESS
                                            // CustomToastTop.show(
                                            //   context: context, 
                                            //   message: "SUCCESS",
                                            //   isSuccess: 1
                                            // );

                                            // GetToPage.toNamed<OtpEmailProfileController>(Routes.OTP_EMAIL_PROFILE, arguments: controller.emailController.text);

                                            MessageFromUrlModel message;
                                            
                                            var body = {
                                              "Email_baru": controller.emailController.text,
                                              "Token": controller.tokenFromOtp.value
                                            };

                                            var response = await ApiProfile(
                                              context: Get.context,
                                              isShowDialogLoading: true,
                                              isShowDialogError: true,
                                              isDebugGetResponse: true,
                                            ).otpEmailUsers(body);

                                            message = response['Message'] != null
                                              ? MessageFromUrlModel.fromJson(response['Message'])
                                              : null;
                                            if (message != null && message.code == 200) {
                                              GetToPage.offNamed<OtpEmailProfileController>(
                                                Routes.OTP_EMAIL_PROFILE, 
                                                arguments: {
                                                  "email": controller.emailController.text,
                                                  "token": controller.tokenFromOtp.value
                                                }
                                              );
                                            } 
                                            else {
                                              CustomToastTop.show(
                                                message: response['Data']['Message'],
                                                context: Get.context,
                                                isSuccess: 0,
                                              );
                                            }
                                          }
                                          else{
                                            CustomToastTop.show(context: Get.context, message: "Penulisan email salah!", isSuccess: 0);
                                          }
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