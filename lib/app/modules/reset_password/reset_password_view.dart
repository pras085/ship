import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/reset_password/reset_password_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/background_stack_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/test_form_field_widget2.dart';
import 'package:muatmuat/app/widgets/text_form_field_widget.dart';
import 'package:validators/validators.dart' as validator;

class ResetPasswordView extends GetView<ResetPasswordController> {
  double widthContent(BuildContext context) =>
      MediaQuery.of(context).size.width - 40;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ListColor.colorBack1),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(ListColor.color4),
        child: Stack(children: [
          Positioned(
            top: -30,
            right: -30,
            child: Image(
              image: AssetImage("assets/supergraphics3_icon.png"),
              width: 200,
              fit: BoxFit.fitWidth,
            ),
          ),
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: ClipOval(
                                      child: Material(
                                          shape: CircleBorder(),
                                          color: Colors.white,
                                          child: InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  child: Center(
                                                      child: Icon(
                                                    Icons
                                                        .arrow_back_ios_rounded,
                                                    size: 30 * 0.7,
                                                    color:
                                                        Color(ListColor.color4),
                                                  ))))),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  CustomText(
                                    'ResetPasswordLabelTitle'.tr,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ]),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              margin: EdgeInsets.only(left: 10),
                              child: CustomText(
                                'ResetPasswordLabelSubTitle'.tr,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.white),
                        child: Form(
                            onChanged: () {
                              if (controller.isCheckValidateOnChange.value) {
                                controller.validateForm();
                              }
                            },
                            key: controller.formKey.value,
                            child: Obx(
                              () => controller.isSuccess.value
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomText(
                                          'ResetPasswordLabelSuccessSentPassword'
                                              .tr,
                                          textAlign: TextAlign.center,
                                          color: Color(ListColor.color2),
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            margin: EdgeInsets.only(top: 10),
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Color(
                                                    ListColor.colorYellow)),
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.transparent,
                                              child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Center(
                                                      child: CustomText(
                                                          'ResetPasswordButtonOK'
                                                              .tr,
                                                          color: Color(
                                                              ListColor.color4),
                                                          fontWeight: FontWeight
                                                              .w800))),
                                            ))
                                      ],
                                    )
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: 20),
                                        TextFormFieldWidget(
                                          errorColor: Colors.red,
                                          isCustomTitle: true,
                                          titleWidget: CustomText(
                                              'ResetPasswordLabelEdtEmail'
                                                  .tr, //'ResetPasswordLabelEdtEmail'.tr
                                              color: Color(
                                                  ListColor.colorDarkGrey),
                                              fontWeight: FontWeight.w600),
                                          validator: (String value) {
                                            if (value.isEmpty)
                                              return 'ResetPasswordLabelEdtValidatorEmailEmpty'
                                                  .tr;
                                            else if (!validator.isEmail(value))
                                              return 'ResetPasswordLabelEdtValidatorEmailFalseFormat'
                                                  .tr;
                                          },
                                          width: widthContent(context),
                                          isPassword: false,
                                          isEmail: true,
                                          isPhoneNumber: false,
                                          textEditingController:
                                              controller.emailController.value,
                                          isNextEditText: false,
                                          focusedBorderColor:
                                              Color(ListColor.color4),
                                          fillColor:
                                              Color(ListColor.colorLightGrey3),
                                          hintTextStyle: TextStyle(
                                              color: Color(
                                                  ListColor.colorLightGrey2),
                                              fontWeight: FontWeight.w600),
                                          hintText:
                                              'ResetPasswordLabelHintEdtEmail'
                                                  .tr,
                                          enableBorderColor:
                                              Color(ListColor.colorLightGrey),
                                        ),
                                        SizedBox(height: 60),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Color(
                                                    ListColor.colorYellow)),
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.transparent,
                                              child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  onTap: () {
                                                    controller.onResetButton();
                                                  },
                                                  child: Center(
                                                      child: CustomText(
                                                          'ResetPasswordButtonResetPassword'
                                                              .tr,
                                                          color: Color(
                                                              ListColor.color4),
                                                          fontWeight: FontWeight
                                                              .w600))),
                                            ))
                                      ],
                                    ),
                            )),
                      ),
                    )
                  ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _textFormField(
      String title,
      Function validator,
      TextEditingController textEditingController,
      String hintText,
      bool isMultiline,
      bool isNumber) {
    return TextFormFieldWidget(
      title: title,
      validator: validator,
      width: widthContent(Get.context),
      isPassword: false,
      isEmail: false,
      isPhoneNumber: false,
      isNumber: isNumber,
      textEditingController: textEditingController,
      isShort: false,
      titleColor: Color(ListColor.colorBlack),
      errorColor: Colors.red,
      focusedBorderColor: Color(ListColor.color4),
      fillColor: Color(ListColor.colorLightGrey3),
      hintTextStyle: TextStyle(
          color: Color(ListColor.colorLightGrey2), fontWeight: FontWeight.w600),
      hintText: hintText,
      titleTextStyle:
          TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      contentTextStyle: TextStyle(
          fontSize: 14,
          color: Color(ListColor.colorLightGrey4),
          fontWeight: FontWeight.w600),
      isMultiLine: isMultiline,
    );
  }
}
