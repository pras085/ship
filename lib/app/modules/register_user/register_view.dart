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
import 'package:muatmuat/app/modules/login/login_controller.dart';
// import 'package:muatmuat/app/modules/login_and_register/syarat_dan_ketentuan/syarat_dan_ketentuan_controller.dart';
import 'package:muatmuat/app/modules/api_login_register.dart';
import 'package:muatmuat/app/modules/register_google/register_google_controller.dart';
import 'package:muatmuat/app/modules/terms_and_conditions_register/terms_and_conditions_register_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
// import 'package:muatmuat/app/modules/works_seller/login_seller/login_seller_controller.dart';
// import 'package:muatmuat/app/modules/works_seller/register_seller_google/register_seller_google_controller.dart';
// import 'package:muatmuat/app/modules/works_seller/success_register_seller/success_register_seller_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/change_language_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/test_form_field_widget2.dart';
import 'package:muatmuat/app/widgets/text_form_field_widget.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:validators/validators.dart' as validator;

import 'register_controller.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterView extends GetView<RegisterController> {
  GoogleSignInAccount get user => GlobalVariable.user;

  Future<void> googleLogin() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await GlobalVariable.googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
    }

    final googleUser = await GlobalVariable.googleSignIn.signIn();
    if (googleUser == null) return;
    GlobalVariable.user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    log(user.email);

    // PENYESUAIAN GOOGLE
    var parameter = {
      "Email": user.email,
      "Locale": GlobalVariable.languageType,
      "App": "1"
    };

    var response = await ApiLoginRegister(context: Get.context, isShowDialogError: true, isShowDialogLoading: true).registerByGoogle(parameter);
    // PENYESUAIAN GOOGLE
    GlobalVariable.emailLogin = response['Data']['Email'];
    GlobalVariable.tokenApp = response['Data']['Token'];
    GlobalVariable.docID = response['Data']['ID'].toString();
    if (response['Message']['Code'] == 200) {
      if (response['Data']['Name'].isNotEmpty && response['Data']['Phone'].isNotEmpty) {
        GlobalVariable.userModelGlobal = UserModel(
          docID: response["Data"]["ID"].toString(),
          name: response["Data"]["Name"],
          email: response["Data"]["Email"],
          phone: response["Data"]["Phone"],
          password: '',
          isVerifPhone: response["Data"]["IsVerifPhone"] == 1,
          code: response["Data"]["Code"].toString(),
          referralCode: response["Data"]["RefCode"].toString()
        );

        await SharedPreferencesHelper.setUserLogin(GlobalVariable.userModelGlobal);
        final checkUserRes = await ApiHelper(context: Get.context, isShowDialogLoading: true).fetchCheckUser();
        if (checkUserRes['Data'].isNotEmpty) {
          await SharedPreferencesHelper.setUserShipperID(checkUserRes["Data"]["ShipperID"].toString());
        }

        if (response["Data"]["IsVerifPhone"] == 1) {
          // Get.offAllNamed(Routes.HOME);
          Get.offAllNamed(Routes.AFTER_LOGIN_SUBUSER);
        } else {
          Get.offAllNamed(Routes.OTP_PHONE_REGISTER, arguments: GlobalVariable.userModelGlobal);
        }
      } else {
        GetToPage.offAllNamed<RegisterGoogleController>(Routes.REGISTER_GOOGLE);
      }
    } else if (response['Message']['Code'] == 204) {
      GetToPage.offAllNamed<RegisterGoogleController>(Routes.REGISTER_GOOGLE);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build register shipper');
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
                            margin: EdgeInsets.only(
                                top: GlobalVariable.ratioWidth(Get.context) * 24),
                            width: GlobalVariable.ratioWidth(Get.context) * 120,
                            height: GlobalVariable.ratioWidth(Get.context) * 33,
                            child: SvgPicture.asset(
                              'assets/ic_logo_muatmuat_putih.svg',
                              width: GlobalVariable.ratioWidth(Get.context) * 120,
                            )),
                        Container(
                          margin: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 20,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 20,
                          ),
                          width: GlobalVariable.ratioWidth(Get.context) * 120,
                          height: GlobalVariable.ratioWidth(Get.context) * 120,
                          child: SvgPicture.asset(
                            'assets/ic_logo_login_seller.svg',
                            width: GlobalVariable.ratioWidth(Get.context) * 120,
                          ),
                        ),
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
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                        GlobalVariable.ratioWidth(Get.context) * 16,
                                        GlobalVariable.ratioWidth(Get.context) * 24,
                                        GlobalVariable.ratioWidth(Get.context) * 16,
                                        GlobalVariable.ratioWidth(Get.context) * 0,
                                      ),
                                      child: CustomText(
                                        "GeneralLRRegisterLabelDaftar".tr,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                8),
                                        width:
                                            GlobalVariable.ratioWidth(Get.context) *
                                                120,
                                        height:
                                            GlobalVariable.ratioWidth(Get.context) *
                                                33,
                                        child: SvgPicture.asset(
                                          'assets/ic_logo_muatmuat.svg',
                                          width:
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  120,
                                        )),
                                    // button google
                                    _button(
                                        height: 42,
                                        marginLeft: 16,
                                        marginTop: 17.5,
                                        marginRight: 16,
                                        borderColor:
                                            Color(ListColor.colorLightGrey10),
                                        borderSize: 1,
                                        borderRadius: 66,
                                        customWidget: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image(
                                                image: AssetImage(
                                                    "assets/google_logo.png"),
                                                width: GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    16),
                                            SizedBox(
                                                width: GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    12),
                                            CustomText(
                                              "GeneralLRRegisterLabelDaftarDenganGoogle"
                                                  .tr,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            )
                                          ],
                                        ),
                                        onTap: () {
                                          print("DAFTAR DENGAN GOOGLE");
                                          googleLogin();
                                          // CustomToastTop.show(
                                          //     context: Get.context,
                                          //     message: "SUCCESS",
                                          //     isSuccess: 1);
                                        }),
                                    // atau
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal:
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  16,
                                          vertical:
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  18),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              child: SizedBox(
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                0.5,
                                            child: Container(
                                                color: Color(ListColor.colorStroke)),
                                          )),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    21),
                                            child: CustomText(
                                              "GeneralLRLoginLabelAtau".tr,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(ListColor.colorGrey3),
                                              height: 0.5,
                                            ),
                                          ),
                                          Expanded(
                                              child: SizedBox(
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                0.5,
                                            child: Container(
                                                color: Color(ListColor.colorStroke)),
                                          ))
                                        ],
                                      ),
                                    ),
                                    _formRegister(),
                                    // button masuk
                                    Obx(
                                      () => _button(
                                          height: 36,
                                          marginLeft: 16,
                                          marginRight: 16,
                                          useBorder: false,
                                          borderRadius: 18,
                                          text: "GeneralLRRegisterLabelDaftar".tr,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: !controller.isFilled.value
                                              ? Color(ListColor.colorLightGrey4)
                                              : Colors.white,
                                          backgroundColor: !controller.isFilled.value
                                              ? Color(ListColor.colorLightGrey2)
                                              : Color(ListColor.colorBlue),
                                          onTap: () async {
                                            print("DAFTAR");
                                            if (controller.isFilled.value) {
                                              String name =
                                                  controller.nameController.text;
                                              String phone =
                                                  controller.phoneController.text;
                                              String email =
                                                  controller.emailController.text;
                                              String password = base64.encode(
                                                  utf8.encode(controller
                                                      .passwordController.text));
                                              String confirmPassword = base64.encode(
                                                  utf8.encode(controller
                                                      .confirmPasswordController
                                                      .text));
                                              String referral =
                                                  controller.referralController.text;

                                              bool isValidAll = true;

                                              if (Utils.validateFormatName(name)
                                                  .isNotEmpty) {
                                                isValidAll = false;
                                                controller.isValid.value = false;
                                                CustomToastTop.show(
                                                    context: Get.context,
                                                    message: Utils.validateFormatName(
                                                        name),
                                                    isSuccess: 0);
                                                return;
                                              }

                                              if (phone.length < 8) {
                                                isValidAll = false;
                                                controller.isValidPhone.value = false;
                                                CustomToastTop.show(
                                                    context: Get.context,
                                                    message:
                                                        "GlobalValidationLabelNoWhatsappMinimal8"
                                                            .tr,
                                                    isSuccess: 0);
                                                return;
                                              }

                                              if (email != "" && Utils.validateFormatEmail(email).isNotEmpty) {
                                                isValidAll = false;
                                                controller.isValidEmail.value = false;
                                                CustomToastTop.show(context: Get.context, message: Utils.validateFormatEmail(email), isSuccess: 0);
                                                return;
                                              }

                                              if (password != confirmPassword) {
                                                isValidAll = false;
                                                controller.isValidPassword.value =
                                                    false;
                                                CustomToastTop.show(
                                                    context: Get.context,
                                                    message: "Password tidak sama!",
                                                    isSuccess: 0);
                                                return;
                                              }

                                              if (Utils.validateFormatPassword(
                                                      controller
                                                          .passwordController.text) !=
                                                  "") {
                                                isValidAll = false;
                                                controller.isValidPassword.value =
                                                    false;
                                                CustomToastTop.show(
                                                    context: Get.context,
                                                    message:
                                                        Utils.validateFormatPassword(
                                                            controller
                                                                .passwordController
                                                                .text),
                                                    isSuccess: 0);
                                                return;
                                              }

                                              if (referral.length < 8 &&
                                                  referral.isNotEmpty) {
                                                isValidAll = false;
                                                controller.isValidReferral.value =
                                                    false;
                                                CustomToastTop.show(
                                                    context: Get.context,
                                                    message:
                                                        'Referral Code harus 8 digit!',
                                                    isSuccess: 0);
                                                return;
                                              }

                                              if (isValidAll) {
                                                var parameter = {
                                                  "name": name,
                                                  "phone": phone,
                                                  "email": email,
                                                  "password": password,
                                                  "confirm_password": confirmPassword,
                                                  "referral_code": referral
                                                };
                                                var body = {
                                                  "user_data": jsonEncode(parameter)
                                                };

                                                print(body);

                                                var response = await ApiLoginRegister(
                                                  context: Get.context,
                                                  isShowDialogError: true,
                                                  isShowDialogLoading: true,
                                                ).doValidateRegisterFields(body);
                                                if (response != null) {
                                                  if (response["Message"]["Code"] ==
                                                      200) {
                                                    print(response["Data"]);
                                                    GlobalVariable.isGoogleRegister = false;
                                                    GetToPage.toNamed<
                                                            TermsAndConditionsRegisterController>(
                                                        Routes
                                                            .TERMS_AND_CONDITIONS_REGISTER,
                                                        arguments: UserModel(
                                                            name: name,
                                                            phone: phone,
                                                            email: email,
                                                            password: password,
                                                            referralCode: referral));
                                                  } else {
                                                    print(response["Data"]["Data"]);
                                                    String errorMessage =
                                                        response["Data"]["Data"]
                                                            ["Message"];
                                                    print(errorMessage);
                                                    String errorField =
                                                        response["Data"]["Data"]
                                                            ["Fields"][0];
                                                    print(errorField);
                                                    CustomToastTop.show(
                                                        context: Get.context,
                                                        message: errorMessage,
                                                        isSuccess: 0);
                                                    if (errorField == "phone") {
                                                      log("Error phone");
                                                      controller.isValidPhone.value =
                                                          false;
                                                    }
                                                    if (errorField == "email") {
                                                      log("Error email");
                                                      controller.isValidEmail.value =
                                                          false;
                                                    }
                                                    if (errorField == "password") {
                                                      log("Error password");
                                                      controller.isValidPassword
                                                          .value = false;
                                                    }
                                                    if (errorField == "referral") {
                                                      log("Error referral");
                                                      controller.isValidReferral
                                                          .value = false;
                                                    }
                                                  }
                                                }

                                                // GetToPage.offNamed<SuccessRegisterSellerController>(Routes.SUCCESS_REGISTER_SELLER);
                                              } else {
                                                CustomToastTop.show(
                                                    context: Get.context,
                                                    message:
                                                        "Ada field yang belum terisi!",
                                                    isSuccess: 0);
                                              }
                                            }
                                          }),
                                    ),
                                    // belum punya akun ?
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          GlobalVariable.ratioWidth(Get.context) * 0,
                                          GlobalVariable.ratioWidth(Get.context) * 18,
                                          GlobalVariable.ratioWidth(Get.context) * 0,
                                          GlobalVariable.ratioWidth(Get.context) *
                                              24),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            "GeneralLRRegisterLabelSudahPunyaAkun".tr,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              print("masuk");
                                              GetToPage.offNamed<LoginController>(
                                                  Routes.LOGIN);
                                            },
                                            child: CustomText(
                                              "GeneralLRLoginLabelMasuk".tr,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Color(ListColor.colorBlue),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
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

  Widget _formRegister() {
    return Column(
      children: [
        // field nama
        Obx(
          () => Container(
            margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 14,
            ),
            height: GlobalVariable.ratioWidth(Get.context) * 40,
            // TARUH BORDER TEXTFIELD DISINI
            decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: controller.isValid.value
                        ? Color(ListColor.colorLightGrey10)
                        : Color(ListColor.colorRed)),
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6)),
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
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(255)
                      ],
                      onChanged: (value) {
                        // controller.searchOnChange(value);
                        controller.isValid.value = true;
                        if (value.isNotEmpty ||
                            controller.phoneController.text.isNotEmpty ||
                            controller.emailController.text.isNotEmpty ||
                            controller.passwordController.text.isNotEmpty ||
                            controller
                                .confirmPasswordController.text.isNotEmpty ||
                            controller.referralController.text.isNotEmpty) {
                          controller.isFilled.value = true;
                        } else {
                          controller.isFilled.value = false;
                        }
                        print(
                            "Filled: " + controller.isFilled.value.toString());
                        print("Valid: " + controller.isValid.value.toString());
                      },
                      controller: controller.nameController,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.2,
                      ),
                      textSize: 14,
                      newInputDecoration: InputDecoration(
                        hintText: "GeneralLRRegisterLabelNamaLengkap".tr,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(ListColor.colorLightGrey2)),
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
                          GlobalVariable.ratioWidth(Get.context) * 11.5,
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
                      left: GlobalVariable.ratioWidth(Get.context) * 12),
                  child: SvgPicture.asset(
                    "assets/ic_username_seller.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 24,
                    height: GlobalVariable.ratioWidth(Get.context) * 24,
                  ),
                ),
              ],
            ),
          ),
        ),

        // field no wa
        Obx(
          () => Container(
            margin: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 0,
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 14),
            height: GlobalVariable.ratioWidth(Get.context) * 40,
            // TARUH BORDER TEXTFIELD DISINI
            decoration: BoxDecoration(
              border: Border.all(
                width: GlobalVariable.ratioWidth(Get.context) * 1,
                color: controller.isValidPhone.value
                    ? Color(ListColor.colorLightGrey10)
                    : Color(ListColor.colorRed),
              ),
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * 6),
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomTextFormField(
                      maxLength: 14,
                      isShowCounter: false,
                      context: Get.context,
                      autofocus: false,
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(14)
                      ],
                      onChanged: (value) {
                        // controller.searchOnChange(value);
                        controller.isValidPhone.value = true;
                        if (value.isNotEmpty ||
                            controller.nameController.text.isNotEmpty ||
                            controller.emailController.text.isNotEmpty ||
                            controller.passwordController.text.isNotEmpty ||
                            controller
                                .confirmPasswordController.text.isNotEmpty ||
                            controller.referralController.text.isNotEmpty) {
                          controller.isFilled.value = true;
                        } else {
                          controller.isFilled.value = false;
                        }
                        print(
                            "Filled: " + controller.isFilled.value.toString());
                        print("Valid: " +
                            controller.isValidPhone.value.toString());
                      },
                      controller: controller.phoneController,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.2,
                      ),
                      textSize: 14,
                      newInputDecoration: InputDecoration(
                        hintText: "GeneralLRRegisterLabelNoWhatsapp".tr,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(ListColor.colorLightGrey2)),
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
                          GlobalVariable.ratioWidth(Get.context) * 11.5,
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
                      left: GlobalVariable.ratioWidth(Get.context) * 12),
                  child: SvgPicture.asset(
                    "assets/ic_whatsapp_seller.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 24,
                    height: GlobalVariable.ratioWidth(Get.context) * 24,
                  ),
                ),
              ],
            ),
          ),
        ),

        // field email
        Obx(
          () => Container(
            margin: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 0,
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 14),
            height: GlobalVariable.ratioWidth(Get.context) * 40,
            // TARUH BORDER TEXTFIELD DISINI
            decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: controller.isValidEmail.value
                        ? Color(ListColor.colorLightGrey10)
                        : Color(ListColor.colorRed)),
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6)),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomTextFormField(
                      context: Get.context,
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        // controller.searchOnChange(value);
                        controller.isValidEmail.value = true;
                        if (value.isNotEmpty ||
                            controller.nameController.text.isNotEmpty ||
                            controller.phoneController.text.isNotEmpty ||
                            controller.passwordController.text.isNotEmpty ||
                            controller
                                .confirmPasswordController.text.isNotEmpty ||
                            controller.referralController.text.isNotEmpty) {
                          controller.isFilled.value = true;
                        } else {
                          controller.isFilled.value = false;
                        }
                        print(
                            "Filled: " + controller.isFilled.value.toString());
                        print("Valid: " +
                            controller.isValidEmail.value.toString());
                      },
                      controller: controller.emailController,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.2,
                      ),
                      textSize: 14,
                      newInputDecoration: InputDecoration(
                        hintText: "GeneralLRRegisterLabelEmail".tr,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(ListColor.colorLightGrey2)),
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
                          GlobalVariable.ratioWidth(Get.context) * 11.5,
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
                      left: GlobalVariable.ratioWidth(Get.context) * 12),
                  child: SvgPicture.asset(
                    "assets/ic_mail_seller.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 24,
                    height: GlobalVariable.ratioWidth(Get.context) * 24,
                  ),
                ),
              ],
            ),
          ),
        ),

        // field password
        Obx(
          () => Container(
            margin: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 0,
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 14),
            height: GlobalVariable.ratioWidth(Get.context) * 40,
            // TARUH BORDER TEXTFIELD DISINI
            decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: controller.isValidPassword.value
                        ? Color(ListColor.colorLightGrey10)
                        : Color(ListColor.colorRed)),
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6)),
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
                        controller.isValidPassword.value = true;
                        // if (value.isNotEmpty &&
                        //     controller
                        //         .confirmPasswordController.text.isNotEmpty) {
                        //   controller.isFilled.value = true;
                        // } else {
                        //   controller.isFilled.value = false;
                        // }
                        if (value.isNotEmpty ||
                            controller.nameController.text.isNotEmpty ||
                            controller.phoneController.text.isNotEmpty ||
                            controller.emailController.text.isNotEmpty ||
                            controller
                                .confirmPasswordController.text.isNotEmpty ||
                            controller.referralController.text.isNotEmpty) {
                          controller.isFilled.value = true;
                        } else {
                          controller.isFilled.value = false;
                        }
                        print(
                            "Filled: " + controller.isFilled.value.toString());
                        print("Valid: " +
                            controller.isValidPassword.value.toString());
                      },
                      controller: controller.passwordController,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.2,
                      ),
                      textSize: 14,
                      inputFormatters: [LengthLimitingTextInputFormatter(16)],
                      newInputDecoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(ListColor.colorLightGrey2)),
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
                          GlobalVariable.ratioWidth(Get.context) * 11.5,
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
                      left: GlobalVariable.ratioWidth(Get.context) * 12),
                  child: SvgPicture.asset(
                    "assets/ic_password_seller.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 24,
                    height: GlobalVariable.ratioWidth(Get.context) * 24,
                    color: Color(ListColor.colorOrange2),
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child:
                        // controller.isShowClearSearch.value ?
                        GestureDetector(
                            onTap: () {
                              controller.togglePassword();
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                    right:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12),
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  controller.isShowPassword.value
                                      ? "assets/ic_visible_password.svg"
                                      : "assets/ic_invisible_password.svg",
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
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

        // field confirm password
        Obx(
          () => Container(
            margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 14,
            ),
            height: GlobalVariable.ratioWidth(Get.context) * 40,
            // TARUH BORDER TEXTFIELD DISINI
            decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: controller.isValidPassword.value
                        ? Color(ListColor.colorLightGrey10)
                        : Color(ListColor.colorRed)),
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6)),
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
                      obscureText: !controller.isShowConfirmPassword.value,
                      obscuringCharacter: '\u2022',
                      onChanged: (value) {
                        // controller.searchOnChange(value);
                        controller.isValidPassword.value = true;
                        // if (value.isNotEmpty &&
                        //     controller.passwordController.text.isNotEmpty) {
                        //   controller.isFilled.value = true;
                        // } else {
                        //   controller.isFilled.value = false;
                        // }
                        if (value.isNotEmpty ||
                            controller.nameController.text.isNotEmpty ||
                            controller.phoneController.text.isNotEmpty ||
                            controller.emailController.text.isNotEmpty ||
                            controller.passwordController.text.isNotEmpty ||
                            controller.referralController.text.isNotEmpty) {
                          controller.isFilled.value = true;
                        } else {
                          controller.isFilled.value = false;
                        }
                        print(
                            "Filled: " + controller.isFilled.value.toString());
                        print("Valid: " +
                            controller.isValidPassword.value.toString());
                      },
                      controller: controller.confirmPasswordController,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.2,
                      ),
                      textSize: 14,
                      inputFormatters: [LengthLimitingTextInputFormatter(16)],
                      newInputDecoration: InputDecoration(
                        hintText: "GeneralLRRegisterLabelKonfirmasiPassword".tr,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(ListColor.colorLightGrey2)),
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
                          GlobalVariable.ratioWidth(Get.context) * 11.5,
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
                      left: GlobalVariable.ratioWidth(Get.context) * 12),
                  child: SvgPicture.asset(
                    "assets/ic_password_seller.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 24,
                    height: GlobalVariable.ratioWidth(Get.context) * 24,
                    color: Color(ListColor.colorOrange2),
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child:
                        // controller.isShowClearSearch.value ?
                        GestureDetector(
                            onTap: () {
                              controller.toggleConfirmPassword();
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                    right:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12),
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  controller.isShowConfirmPassword.value
                                      ? "assets/ic_visible_password.svg"
                                      : "assets/ic_invisible_password.svg",
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                )))
                    // : SizedBox.shrink(),
                    ),
              ],
            ),
          ),
        ),

        // field referral
        Obx(
          () => Container(
            margin: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 0,
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 32),
            height: GlobalVariable.ratioWidth(Get.context) * 40,
            // TARUH BORDER TEXTFIELD DISINI
            decoration: BoxDecoration(
                border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: controller.isValidReferral.value
                      ? Color(ListColor.colorLightGrey10)
                      : Color(ListColor.colorRed),
                ),
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6)),
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
                      inputFormatters: <TextInputFormatter>[
                        UpperCaseTextFormatter(),
                        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                        LengthLimitingTextInputFormatter(8)
                      ],
                      textCapitalization: TextCapitalization.characters,
                      onChanged: (value) {
                        // controller.searchOnChange(value);
                        controller.isValidReferral.value = true;
                        if (value.isNotEmpty ||
                            controller.nameController.text.isNotEmpty ||
                            controller.phoneController.text.isNotEmpty ||
                            controller.emailController.text.isNotEmpty ||
                            controller.passwordController.text.isNotEmpty ||
                            controller
                                .confirmPasswordController.text.isNotEmpty) {
                          controller.isFilled.value = true;
                        } else {
                          controller.isFilled.value = false;
                        }
                        print(
                            "Filled: " + controller.isFilled.value.toString());
                        print("Valid: " +
                            controller.isValidReferral.value.toString());
                      },
                      controller: controller.referralController,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.2,
                      ),
                      textSize: 14,
                      newInputDecoration: InputDecoration(
                        hintText: "GeneralLRRegisterLabelKodeReferral".tr,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(ListColor.colorLightGrey2)),
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
                          GlobalVariable.ratioWidth(Get.context) * 11.5,
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
                      left: GlobalVariable.ratioWidth(Get.context) * 12),
                  child: SvgPicture.asset(
                    "assets/ic_referral_seller.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 24,
                    height: GlobalVariable.ratioWidth(Get.context) * 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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

class UpperCaseTextFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}