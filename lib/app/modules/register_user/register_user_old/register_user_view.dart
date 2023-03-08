import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/change_format_number_function.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/validator/phoine_number_validator.dart';
import 'package:muatmuat/app/core/function/validator/referral_code_validator.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/api_login_register.dart';
import 'package:muatmuat/app/modules/register_user/register_user_old/register_user_controller.dart';
import 'package:muatmuat/app/modules/terms_and_conditions_register/terms_and_conditions_register_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/text_form_field_widget.dart';
import 'package:validators/validators.dart' as validator;

class RegisterUserView extends GetView<RegisterUserController> {
  double widthContent(BuildContext context) =>
      MediaQuery.of(context).size.width - 40;
  double panjangIsiButton(BuildContext context) =>
      (MediaQuery.of(context).size.width - 20) * 4 / 5;
  double _marginBottomEachTextFormField = 24;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    //controller.checkIsGoogle();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(ListColor.colorBlue),
      body: SafeArea(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Color(ListColor.color4),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 34),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlatButton(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(0.0),
                            minWidth: 0,
                            child: Image(
                              image: AssetImage("assets/back_button.png"),
                              width: 30,
                              height: 30,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 10, top: 6),
                                  child: CustomText('RegisterLabelTitle'.tr,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24))),
                        ],
                      ),
                    ),
                    Obx(
                      () => Form(
                        key: controller.formKey.value,
                        onChanged: () {
                          if (controller.isValidateOnChange.value)
                            controller.validateAll();
                          print("onchange");
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            (controller.validatorMessage.value != ""
                                ? Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                    margin: EdgeInsets.only(bottom: 24),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Color(ListColor.colorLightBlue2),
                                      // border:
                                      //     Border.all(width: 3, color: Colors.red),
                                    ),
                                    child: CustomText(
                                        controller.validatorMessage.value,
                                        textAlign: TextAlign.center,
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600),
                                  )
                                : Container()),
                            TextFormFieldWidget(
                              hintTextStyle: _hintTextStyle(),
                              contentTextStyle: _contentTextStyle(),
                              isShowError: false,
                              marginBottom: _marginBottomEachTextFormField,
                              isSetTitleToHint: true,
                              title: 'RegisterLabelEdtFullName'.tr,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  String message =
                                      'RegisterLabelEdtValidatorFullNameEmpty'
                                          .tr;
                                  controller.addValidatorMessage(message);
                                  return message;
                                }
                                return null;
                              },
                              width: widthContent(context),
                              isPassword: false,
                              isEmail: false,
                              isPhoneNumber: false,
                              isName: true,
                              textEditingController:
                                  controller.fullNameController.value,
                            ),
                            controller.userModelTemp.value.isGoogle
                                ? Container()
                                : TextFormFieldWidget(
                                    hintTextStyle: _hintTextStyle(),
                                    contentTextStyle: _contentTextStyle(),
                                    isShowError: false,
                                    marginBottom:
                                        _marginBottomEachTextFormField,
                                    isSetTitleToHint: true,
                                    title: 'RegisterLabelEdtEmail'.tr,
                                    validator: (String value) {
                                      String message = "";
                                      if (controller
                                              .isDuplicateAccountEmail.value &&
                                          controller.emailDuplicate.value ==
                                              value) {
                                        message =
                                            'RegisterLabelEdtValidatorDuplicateEmail'
                                                .tr;
                                      } else if (value.isEmpty) {
                                        message =
                                            'RegisterLabelEdtValidatorEmailEmpty'
                                                .tr;
                                      } else if (!validator.isEmail(value)) {
                                        message =
                                            'RegisterLabelEdtValidatorEmailFalseFormat'
                                                .tr;
                                      }
                                      if (message != "") {
                                        controller.addValidatorMessage(message);
                                        return message;
                                      }
                                      return null;
                                    },
                                    width: widthContent(context),
                                    isPassword: false,
                                    isEmail: true,
                                    isPhoneNumber: false,
                                    textEditingController:
                                        controller.emailController.value,
                                    isEnable: !controller
                                        .userModelTemp.value.isGoogle,
                                  ),
                            TextFormFieldWidget(
                              hintTextStyle: _hintTextStyle(),
                              contentTextStyle: _contentTextStyle(),
                              isShowError: false,
                              marginBottom: _marginBottomEachTextFormField,
                              isSetTitleToHint: true,
                              title: 'RegisterLabelEdtPhoneNumber'.tr,
                              validator: (String value) {
                                String message = "";
                                if (controller
                                        .isDuplicateAccountPhoneNumber.value &&
                                    controller.phoneDuplicate.value ==
                                        controller.convertPhoneNumber(value))
                                  message =
                                      'RegisterLabelEdtValidatorDuplicatePhoneNumber'
                                          .tr;
                                else
                                  message = PhoneNumberValidator.validate(
                                          value: value,
                                          warningIfEmpty:
                                              'RegisterLabelEdtValidatorPhoneNumberEmpty'
                                                  .tr,
                                          warningIfFormatNotMatch:
                                              'RegisterLabelEdtValidatorPhoneNumberFalseFormat'
                                                  .tr,
                                          minLength: 9) ??
                                      "";
                                // else if (value.isEmpty)
                                //   message =
                                //       'RegisterLabelEdtValidatorPhoneNumberEmpty'
                                //           .tr;
                                // else if (value.length < 9)
                                //   message =
                                //       'RegisterLabelEdtValidatorPhoneNumberFalseFormat'
                                //           .tr;
                                if (message != "") {
                                  controller.addValidatorMessage(message);
                                  return message;
                                }
                                return null;
                              },
                              width: widthContent(context),
                              isPassword: false,
                              isEmail: false,
                              isPhoneNumber: true,
                              textEditingController:
                                  controller.phoneController.value,
                            ),
                            controller.userModelTemp.value.isGoogle
                                ? Container()
                                : TextFormFieldWidget(
                                    hintTextStyle: _hintTextStyle(),
                                    contentTextStyle: _contentTextStyle(),
                                    isShowError: false,
                                    marginBottom:
                                        _marginBottomEachTextFormField,
                                    isSetTitleToHint: true,
                                    title: 'RegisterLabelEdtPassword'.tr,
                                    validator: (String value) {
                                      String message = "";
                                      if (value.isEmpty)
                                        message =
                                            'RegisterLabelEdtValidatorPasswordEmpty'
                                                .tr;
                                      else {
                                        final validatorAngka =
                                            RegExp(".*[0-9].*");
                                        final validatorHurufKapital =
                                            RegExp(".*[A-Z].*");
                                        final validatorHurufKecil =
                                            RegExp(".*[a-z].*");

                                        if (value.length < 8) {
                                          message =
                                              'RegisterLabelEdtValidatorPasswordMinChar'
                                                  .tr;
                                        } else if (!validatorAngka
                                                .hasMatch(value) ||
                                            !validatorHurufKapital
                                                .hasMatch(value) ||
                                            !validatorHurufKecil
                                                .hasMatch(value)) {
                                          message =
                                              'RegisterLabelEdtValidatorPasswordFalseFormat'
                                                  .tr;
                                        }
                                      }
                                      if (message != "") {
                                        controller.addValidatorMessage(message);
                                        return message;
                                      }
                                      return null;
                                    },
                                    width: widthContent(context),
                                    isPassword: true,
                                    isEmail: false,
                                    isPhoneNumber: false,
                                    textEditingController:
                                        controller.passwordController.value,
                                    isShowPassword:
                                        controller.isShowPassword.value,
                                    onClickShowButton: (value) {
                                      controller.setIsShowPassword(value);
                                    },
                                  ),
                            controller.userModelTemp.value.isGoogle
                                ? Container()
                                : TextFormFieldWidget(
                                    hintTextStyle: _hintTextStyle(),
                                    contentTextStyle: _contentTextStyle(),
                                    isShowError: false,
                                    marginBottom:
                                        _marginBottomEachTextFormField,
                                    isSetTitleToHint: true,
                                    title: 'RegisterLabelEdtConfirmPassword'.tr,
                                    validator: (String value) {
                                      String message = "";
                                      if (value.isEmpty)
                                        message =
                                            'RegisterLabelEdtValidatorConfirmPasswordEmpty'
                                                .tr;
                                      else if (value !=
                                          controller
                                              .passwordController.value.text)
                                        message =
                                            'RegisterLabelEdtValidatorConfirmPasswordNotSame'
                                                .tr;
                                      if (message != "") {
                                        controller.addValidatorMessage(message);
                                        return message;
                                      }
                                      return null;
                                    },
                                    width: widthContent(context),
                                    isPassword: true,
                                    isEmail: false,
                                    isPhoneNumber: false,
                                    textEditingController: controller
                                        .retypePasswordController.value,
                                    isShowPassword:
                                        controller.isShowConfirmPassword.value,
                                    onClickShowButton: (value) {
                                      controller
                                          .setIsShowConfirmPassword(value);
                                    },
                                  ),
                            TextFormFieldWidget(
                              hintTextStyle: _hintTextStyle(),
                              contentTextStyle: _contentTextStyle(),
                              marginBottom: _marginBottomEachTextFormField,
                              isSetTitleToHint: true,
                              maxLength: 8,
                              // isAllCapital: true,
                              title: 'RegisterLabelEdtReferralCode'.tr,
                              validator: (String value) {
                                String message = ReferralCodeValidator.validate(
                                    value: value);
                                if (message != null)
                                  controller.addValidatorMessage(message);
                                return message;
                              },
                              width: widthContent(context),
                              isPassword: false,
                              isEmail: false,
                              isPhoneNumber: false,
                              textEditingController:
                                  controller.referralCodeController.value,
                              isNextEditText: false,
                              isShort: true,
                              isShowError: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    //_registerbutton(context),
                  ],
                ),
              ),
            ),
          ),
          _registerbutton(context),
          SizedBox(
            height: 20,
          )
        ]),
      ),
    );
  }

  TextStyle _contentTextStyle() {
    return TextStyle(
        fontWeight: FontWeight.w600, color: Color(ListColor.colorLightGrey4));
  }

  TextStyle _hintTextStyle() {
    return TextStyle(
        fontWeight: FontWeight.w600, color: Color(ListColor.colorLightGrey2));
  }

  Widget _registerbutton(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        color: Color(ListColor.color5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        onPressed: () async {
                          // controller.onSaving();
                          String name =
                              controller.fullNameController.value.text;
                          String phone = controller.phoneController.value.text;
                          String email = controller.emailController.value.text;
                          String password = base64.encode(utf8.encode(
                              controller.passwordController.value.text));
                          String confirmPassword = base64.encode(utf8.encode(
                              controller.retypePasswordController.value.text));
                          String referral =
                              controller.referralCodeController.value.text;

                          // PENGECEKAN SEMENTARA
                          bool isValidAll = true;
                          if (name == "") {
                            isValidAll = false;
                          }
                          if (phone == "") {
                            isValidAll = false;
                          }
                          if (password == "" || confirmPassword == "") {
                            isValidAll = false;
                          }

                          if (isValidAll) {
                            var parameter = {
                              "name": name,
                              "phone":
                                  ChangeFormatNumberFunction.convertPhoneNumber(
                                      phone),
                              "email": email,
                              "password": password,
                              "confirm_password": confirmPassword,
                              "referral_code": referral
                            };
                            var body = {"user_data": jsonEncode(parameter)};

                            print(body);

                            var response = await ApiLoginRegister(
                              context: Get.context,
                              isShowDialogError: true,
                              isShowDialogLoading: true,
                            ).doValidateRegisterFields(body);

                            if (response != null) {
                              if (response["Message"]["Code"] == 200) {
                                GetToPage.toNamed<
                                        TermsAndConditionsRegisterController>(
                                    Routes.TERMS_AND_CONDITIONS_REGISTER,
                                    arguments: UserModel(
                                        name: name,
                                        phone: ChangeFormatNumberFunction
                                            .convertPhoneNumber(phone),
                                        email: email,
                                        password: password,
                                        referralCode: referral));
                              } else {
                                String errorMessage =
                                    response["Data"]["Data"]["Message"];
                                String errorField =
                                    response["Data"]["Data"]["Fields"][0];
                                CustomToastTop.show(
                                    context: Get.context,
                                    message: errorMessage,
                                    isSuccess: 0);
                                if (errorField == "phone") {
                                  log("Error phone");
                                }
                                if (errorField == "email") {
                                  log("Error email");
                                }
                                if (errorField == "password") {
                                  log("Error password");
                                }
                                if (errorField == "referral") {
                                  log("Error referral");
                                }
                              }
                            }
                          } else {
                            CustomToastTop.show(
                                context: Get.context,
                                message: "Ada field yang belum terisi!",
                                isSuccess: 0);
                          }
                        },
                        child: CustomText('RegisterButtonSignUp'.tr,
                            fontSize: 14,
                            color: Color(ListColor.color4),
                            fontWeight: FontWeight.w600)),
                  ),
                  controller.userModelTemp.value.isGoogle
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: CustomText('RegisterLabelOr'.tr,
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            _signInButton(context)
                          ],
                        )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText('RegisterLabelAlreadyHaveAccount'.tr,
                      color: Colors.white),
                  GestureDetector(
                    onTap: () {
                      Get.offNamed(Routes.LOGIN);
                    },
                    child: CustomText(' ' + 'RegisterButtonLogin'.tr,
                        color: Color(ListColor.colorYellow),
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget _signInButton(BuildContext context) {
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
      child: FlatButton(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        // minWidth: 72,
        // height: 36,
        color: Colors.white,
        child: Center(
            child: Image(
                image: AssetImage("assets/google_logo.png"), height: 20.0)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        onPressed: () {
          controller.signInGoogle(context);
        },
      ),
    );
  }
}
