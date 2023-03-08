import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/login/login_controller.dart';
import 'package:muatmuat/app/modules/terms_and_conditions_register/terms_and_conditions_register_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import '../api_login_register.dart';
import 'register_google_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterGoogleView extends GetView<RegisterGoogleController> {
  GoogleSignInAccount get user => GlobalVariable.user;

  Future<void> googleLogin() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await GlobalVariable.googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
    }

    final googleUser = await GlobalVariable.googleSignIn.signIn();
    if(googleUser == null) return;
    GlobalVariable.user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

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
        controller.emailGoogle.value = GlobalVariable.user.email;
        controller.nameController.text = GlobalVariable.user.displayName;
        controller.isFilled.value = false;
      }
    } else if (response['Message']['Code'] == 204) {
      controller.emailGoogle.value = GlobalVariable.user.email;
      controller.nameController.text = GlobalVariable.user.displayName;
      controller.isFilled.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build register seller google');

    Get.put(RegisterGoogleController());

    if(!controller.onCreate.value){
      if(GlobalVariable.user != null){
        controller.emailGoogle.value = GlobalVariable.user.email;
        controller.nameController.text = GlobalVariable.user.displayName;
        controller.isFilled.value = false;
      }
      controller.onCreate.value = true;
    }

    return WillPopScope(
      onWillPop: () async {
        GetToPage.offNamed<LoginController>(Routes.LOGIN);
        return false;
      },
      child: Container(
        color: Color(ListColor.color4),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
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
                        top: GlobalVariable.ratioWidth(Get.context) * 24
                      ),
                      width: GlobalVariable.ratioWidth(Get.context) * 120,
                      height: GlobalVariable.ratioWidth(Get.context) * 33,
                      child: SvgPicture.asset(
                        'assets/ic_logo_muatmuat_putih.svg',
                        width: GlobalVariable.ratioWidth(Get.context) * 120,
                      )
                    ),
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
                                    "RegisterGoogleLabelDaftar".tr,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: GlobalVariable.ratioWidth(Get.context) * 8
                                  ),
                                  width: GlobalVariable.ratioWidth(Get.context) * 120,
                                  height: GlobalVariable.ratioWidth(Get.context) * 33,
                                  child: SvgPicture.asset(
                                    'assets/ic_logo_muatmuat.svg',
                                    width: GlobalVariable.ratioWidth(Get.context) * 120,
                                  )
                                ),
                                // button google
                                Obx(() => _button(
                                  height: 42,
                                  marginLeft: 16,
                                  marginTop: 18,
                                  marginRight: 16,
                                  marginBottom: 18,
                                  borderColor: Color(ListColor.colorLightGrey10),
                                  borderSize: 1,
                                  borderRadius: 66,
                                  customWidget: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: AssetImage("assets/google_logo.png"),
                                        width: GlobalVariable.ratioWidth(Get.context) * 16
                                      ),
                                      SizedBox(
                                        width: GlobalVariable.ratioWidth(Get.context) * 12
                                      ),
                                      CustomText(
                                        controller.emailGoogle.value,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    print("UBAH AKUN GOOGLE");
                                    googleLogin();
                                    // CustomToastTop.show(
                                    //     context: Get.context,
                                    //     message: "SUCCESS",
                                    //     isSuccess: 1);
                                  }
                                )),
                                _formRegisterGoogle(),
                                // button masuk
                                Obx(() => _button(
                                  height: 36,
                                  marginLeft: 16,
                                  marginRight: 16,
                                  useBorder: false,
                                  borderRadius: 18,
                                  text: "RegisterGoogleLabelDaftar".tr,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: !controller.isFilled.value
                                    ? Color(ListColor.colorLightGrey4)
                                    : Colors.white,
                                  backgroundColor: !controller.isFilled.value
                                    ? Color(ListColor.colorLightGrey2)
                                    : Color(ListColor.colorBlue),
                                  onTap: () async {
                                    if (controller.isFilled.value) {
                                      String name = controller.nameController.text;
                                      String phone = controller.phoneController.text;
                                      String referral = controller.referralController.text;

                                      var parameter = {
                                        "name": name,
                                        "phone": phone,
                                        "referral_code": referral
                                      };

                                      var body = {
                                        "user_data": jsonEncode(parameter)
                                      };

                                      print(body); 

                                      bool isValid = true;

                                      if (Utils.validateFormatName(name).isNotEmpty) {
                                        isValid = false;
                                        controller.isValid.value = false;
                                        CustomToastTop.show(context: Get.context, message: Utils.validateFormatName(name), isSuccess: 0);
                                        return;
                                      }

                                      if (phone.length < 8) {
                                        isValid = false;
                                        controller.isValidPhone.value = false;
                                        CustomToastTop.show(context: Get.context, message: 'GlobalValidationLabelNoWhatsappMinimal8'.tr, isSuccess: 0);
                                        return;
                                      }

                                      if (referral.length < 8 && referral.isNotEmpty) {
                                        isValid = false;
                                        controller.isValidReferral.value = false;
                                        CustomToastTop.show(context: Get.context, message: 'Referral Code harus 8 digit!', isSuccess: 0);
                                        return;
                                      }

                                      if (isValid) {
                                        var response = await ApiLoginRegister(context: Get.context, isShowDialogError: true, isShowDialogLoading: false).doValidateNamePhoneRefCode(body);
                                        if(response != null){
                                          if (response["Message"]["Code"] == 200) {
                                            GlobalVariable.isGoogleRegister = true;
                                            GetToPage.toNamed<TermsAndConditionsRegisterController>(
                                              Routes.TERMS_AND_CONDITIONS_REGISTER,
                                              arguments: UserModel(
                                                name: name,
                                                phone: phone,
                                                email: controller.emailGoogle.value,
                                                password: "",
                                                referralCode: referral
                                              )
                                            );
                                          } else{
                                            print(response["Data"]["Data"]);
                                            String errorMessage = response["Data"]["Data"]["Message"];
                                            String errorField = response["Data"]["Data"]["Fields"][0];
                                            print(errorMessage);
                                            print(errorField);
                                            CustomToastTop.show(context: Get.context, message: errorMessage, isSuccess: 0);
                                            if(errorField == "phone"){
                                              log("Error phone");
                                              controller.isValidPhone.value = false;
                                            }
                                            if(errorField == "referral_code"){
                                              log("Error referral");
                                              controller.isValidReferral.value = false;
                                            }
                                          }
                                        }

                                        // GetToPage.offNamed<SuccessRegisterSellerController>(Routes.SUCCESS_REGISTER_SELLER);
                                      }
                                    }
                                  }
                                )),
                                // belum punya akun ?
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                    GlobalVariable.ratioWidth(Get.context) * 0,
                                    GlobalVariable.ratioWidth(Get.context) * 18,
                                    GlobalVariable.ratioWidth(Get.context) * 0,
                                    GlobalVariable.ratioWidth(Get.context) * 50
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        "RegisterGoogleLabelSudahPunyaAkunMuatmuat".tr,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          print("masuk");
                                          GetToPage.offNamed<LoginController>(Routes.LOGIN);
                                        },
                                        child: CustomText(
                                          "RegisterGoogleLabelMasuk".tr,
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
        child: Image(image: AssetImage("assets/google_logo.png"), height: 20.0)
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      onPressed: () {
        controller.signInWithGoogle(context);
      },
    ));
  }

  Widget _formRegisterGoogle() {
    return Column(
      children: [
        // field nama
        Obx(() => Container(
          margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 0,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 14
          ),
          height: GlobalVariable.ratioWidth(Get.context) * 40,
          // TARUH BORDER TEXTFIELD DISINI
          decoration: BoxDecoration(
            border: Border.all(
              width: GlobalVariable.ratioWidth(Get.context) * 1,
              color: controller.isValid.value
                ? Color(ListColor.colorLightGrey10)
                : Color(ListColor.colorRed)
            ),
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)
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
                    onChanged: (value) {
                      // controller.searchOnChange(value);
                      controller.isValid.value = true;
                      if (value.isNotEmpty && controller.nameController.text.isNotEmpty && controller.phoneController.text.isNotEmpty) {
                        controller.isFilled.value = true;
                      } else {
                        controller.isFilled.value = false;
                      }
                      print("Filled: " + controller.isFilled.value.toString());
                      print("Valid: " + controller.isValid.value.toString());
                    },
                    controller: controller.nameController,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                    textSize: 14,
                    inputFormatters: [LengthLimitingTextInputFormatter(255)],
                    newInputDecoration: InputDecoration(
                      hintText: "RegisterGoogleLabelNamaLengkap".tr,
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
                        GlobalVariable.ratioWidth(Get.context) * 11.5,
                        GlobalVariable.ratioWidth(Get.context) * 10,
                        GlobalVariable.ratioWidth(Get.context) * 0
                      )
                    )
                  ),
                ],
              ),
              // TARUH ICON DISINI
              Container(
                margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 12),
                child: SvgPicture.asset(
                  "assets/ic_username_seller.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 24,
                  height: GlobalVariable.ratioWidth(Get.context) * 24,
                ),
              ),
            ],
          ),
        )),

        // field no wa
        Obx(() => Container(
          margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 0,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 14
          ),
          height: GlobalVariable.ratioWidth(Get.context) * 40,
          // TARUH BORDER TEXTFIELD DISINI
          decoration: BoxDecoration(
            border: Border.all(
              width: GlobalVariable.ratioWidth(Get.context) * 1,
              color: controller.isValidPhone.value
                ? Color(ListColor.colorLightGrey10)
                : Color(ListColor.colorRed)
            ),
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomTextFormField(
                    context: Get.context,
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly, 
                      LengthLimitingTextInputFormatter(14)
                    ],
                    onChanged: (value) {
                      // controller.searchOnChange(value);
                      controller.isValidPhone.value = true;
                      if (value.isNotEmpty && controller.nameController.text.isNotEmpty && controller.phoneController.text.isNotEmpty) {
                        controller.isFilled.value = true;
                      } else {
                        controller.isFilled.value = false;
                      }
                      print("Filled: " + controller.isFilled.value.toString());
                      print("Valid: " + controller.isValidPhone.value.toString());
                    },
                    controller: controller.phoneController,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                    textSize: 14,
                    newInputDecoration: InputDecoration(
                      hintText: "RegisterGoogleLabelNoWhatsapp".tr,
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
                        GlobalVariable.ratioWidth(Get.context) * 11.5,
                        GlobalVariable.ratioWidth(Get.context) * 10,
                        GlobalVariable.ratioWidth(Get.context) * 0
                      )
                    )
                  ),
                ],
              ),
              // TARUH ICON DISINI
              Container(
                margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 12),
                child: SvgPicture.asset(
                  "assets/ic_whatsapp_seller.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 24,
                  height: GlobalVariable.ratioWidth(Get.context) * 24,
                ),
              ),
            ],
          ),
        )),
        // field referral
        Obx(() => Container(
          margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 0,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 32
          ),
          height: GlobalVariable.ratioWidth(Get.context) * 40,
          // TARUH BORDER TEXTFIELD DISINI
          decoration: BoxDecoration(
            border: Border.all(
              width: GlobalVariable.ratioWidth(Get.context) * 1,
              color: controller.isValidReferral.value
                ? Color(ListColor.colorLightGrey10)
                : Color(ListColor.colorRed)
            ),
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)
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
                    inputFormatters: <TextInputFormatter>[
                      UpperCaseTextFormatter(),
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                      LengthLimitingTextInputFormatter(8),
                    ],
                    textCapitalization: TextCapitalization.characters,
                    onChanged: (value) {
                      // controller.searchOnChange(value);
                      controller.isValidReferral.value = true;
                      print("Filled: " + controller.isFilled.value.toString());
                      print("Valid: " + controller.isValidReferral.value.toString());
                    },
                    controller: controller.referralController,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                    textSize: 14,
                    newInputDecoration: InputDecoration(
                      hintText: "RegisterGoogleLabelReferralCode".tr,
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
                        GlobalVariable.ratioWidth(Get.context) * 11.5,
                        GlobalVariable.ratioWidth(Get.context) * 10,
                        GlobalVariable.ratioWidth(Get.context) * 0
                      )
                    )
                  ),
                ],
              ),
              // TARUH ICON DISINI
              Container(
                margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 12),
                child: SvgPicture.asset(
                  "assets/ic_referral_seller.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 24,
                  height: GlobalVariable.ratioWidth(Get.context) * 24,
                ),
              ),
            ],
          ),
        )),
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