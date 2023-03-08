import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/fake_home/fake_home.dart';
import 'package:muatmuat/app/modules/fake_home/fake_home_controller.dart';
import 'package:muatmuat/app/modules/forgot_password/forgot_password_controller.dart';
import 'package:muatmuat/app/modules/login/model_data.dart';
import 'package:muatmuat/app/modules/register_google/register_google_controller.dart';
import 'package:muatmuat/app/modules/register_shipper_bf_tm/register_shipper_bf_tm_controller.dart';
import 'package:muatmuat/app/modules/register_user/register_user_old/register_user_controller.dart';
import 'package:muatmuat/app/modules/register_user/register_controller.dart';
import 'package:muatmuat/app/modules/shipment_capacity_validation/shipment_capacity_validation_controller.dart';
import 'package:muatmuat/app/modules/terms_and_conditions_bftm/terms_and_conditions_bftm_controller.dart';
import 'package:muatmuat/app/modules/upload_legalitas/upload_legalitas_controller.dart';
import 'package:muatmuat/app/modules/upload_picture/upload_picture_controller.dart';
import 'package:muatmuat/app/modules/success_create_password/success_create_password_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/widgets/double_tappable_interactive_viewer.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import '../api_login_register.dart';
import 'login_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginView extends GetView<LoginController> {
  double angka1(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 8;
  double panjangIsiButton(BuildContext context) =>
      (MediaQuery.of(context).size.width - 20) * 4 / 5;
  double widthContent(BuildContext context) =>
      MediaQuery.of(context).size.width - 40;

  DateTime currentBackPressTime;

  //LoginController _controller = Get.put(LoginController());

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

    var parameter = {
      "Email": user.email,
      "Locale": GlobalVariable.languageType,
      "App": "1"
    };

    var response = await ApiLoginRegister(context: Get.context, isShowDialogError: true, isShowDialogLoading: true).registerByGoogle(parameter);
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

        try {
          await ApiProfile(context: Get.context, isShowDialogLoading: false).setUserLanguage({"Locale" : GlobalVariable.languageType});
        } catch (e) {}

        if (response["Data"]["IsVerifPhone"] == 1) {
          // Get.offAllNamed(Routes.HOME);
          Get.offAllNamed(Routes.AFTER_LOGIN_SUBUSER);
        } else {
          Get.offAllNamed(Routes.OTP_PHONE_REGISTER, arguments: GlobalVariable.userModelGlobal);
        }
      } else {
        String errorMessage = response["Message"]["Text"];
        print(errorMessage);
        GetToPage.offAllNamed<RegisterGoogleController>(Routes.REGISTER_GOOGLE);
        CustomToastTop.show(context: Get.context, message: 'RegisterGoogleLabelAndaBelumMemilikiAkunMuatmuat'.tr, isSuccess: 0);
      }
    } else if (response['Message']['Code'] == 204) {
      String errorMessage = response["Message"]["Text"];
      print(errorMessage);
      GetToPage.offAllNamed<RegisterGoogleController>(Routes.REGISTER_GOOGLE);
      CustomToastTop.show(context: Get.context, message: 'RegisterGoogleLabelAndaBelumMemilikiAkunMuatmuat'.tr, isSuccess: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build login shipper');
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
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // Get.toNamed(Routes.SUCCESS_REGISTER_BFTM);
                        //     GetToPage.toNamed<RegisterShipperBfTmController>(
                        //       Routes.REGISTER_SHIPPER_BF_TM,
                        //       // arguments: TipeModul.TM
                        //     );
                        //     // GetToPage.toNamed<TermsAndConditionsBFTMController>(
                        //     //   Routes.TERMS_AND_CONDITIONS_BFTM,
                        //     //   arguments: TipeModul.TM
                        //     // );
                        //   },
                        //   child: Text('tes')
                        // ),
                        GestureDetector(
                          onDoubleTap: (){
                            Get.toNamed(Routes.FAKE_HOME);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                top: GlobalVariable.ratioWidth(Get.context) * 24),
                            width: GlobalVariable.ratioWidth(Get.context) * 120,
                            height: GlobalVariable.ratioWidth(Get.context) * 21,
                            child: SvgPicture.asset(
                              'assets/ic_logo_muatmuat_putih.svg',
                              width: GlobalVariable.ratioWidth(Get.context) * 120,
                            ),
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
                              'assets/ic_logo_login_seller.svg',
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
                                          "GeneralLRLoginLabelMasuk".tr,
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
                                                  21,
                                          child: SvgPicture.asset(
                                            'assets/ic_logo_muatmuat.svg',
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    "assets/google_logo.png"),
                                                width: GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    16,
                                                height: GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    16,
                                              ),
                                              SizedBox(
                                                  width: GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      12),
                                              CustomText(
                                                "GeneralLRLoginLabelMasukDenganGoogle".tr,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            print("MASUK DENGAN GOOGLE");
                                            googleLogin();
                                            // CustomToastTop.show(
                                            //     context: Get.context,
                                            //     message: "Success",
                                            //     isSuccess: 1);
                                          }),
                                      // atau
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            vertical: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                18),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  0.5,
                                              child: Container(
                                                  color:
                                                      Color(ListColor.colorStroke)),
                                            )),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      GlobalVariable.ratioWidth(
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
                                                  color:
                                                      Color(ListColor.colorStroke)),
                                            ))
                                          ],
                                        ),
                                      ),
                                      _formLogin(),
                                      // text lupa password
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
                                          onTap: () {
                                            print("lupa password");
                                            GetToPage.toNamed<
                                                    ForgotPasswordController>(
                                                Routes.FORGOT_PASSWORD);
                                          },
                                          child: CustomText(
                                            "GeneralLRLoginLabelLupaPassword".tr,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(ListColor.colorBlue),
                                          ),
                                        ),
                                      ),
                                      // button masuk
                                      Obx(
                                        () => _button(
                                            height: 36,
                                            marginLeft: 16,
                                            marginRight: 16,
                                            useBorder: false,
                                            borderRadius: 18,
                                            text: "GeneralLRLoginLabelMasuk".tr,
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
                                              print("MASUK");
                                              if (controller.isFilled.value) {
                                                if (!controller.checkRegex()) {
                                                  controller.inputtype.value ?
                                                    CustomToastTop.show(
                                                      context: Get.context,
                                                      message: "GeneralLRLoginLabelEmailPasswordSalah".tr,
                                                      isSuccess: 0
                                                    ) : 
                                                    CustomToastTop.show(
                                                      context: Get.context,
                                                      message: "GeneralLRLoginLabelNoWaPasswordSalah".tr,
                                                      isSuccess: 0
                                                    );
                                                  controller.isValid.value = false;
                                                } else {
                                                  // SUCCESS
                                                  String username = controller.emailController.text;
                                                  String password = base64.encode(utf8.encode(controller.passwordController.text));

                                                  var parameter = {
                                                    "email": controller.typeLogin == 1 ? username : "",
                                                    "phone": controller.typeLogin == 2 ? username : "",
                                                    "password": password,
                                                    "app": "1",
                                                  };

                                                  var response = await ApiLoginRegister(
                                                    context: Get.context,
                                                    isShowDialogError: true,
                                                    isShowDialogLoading: true,
                                                  ).doLoginUser(parameter);
                                                  if (response != null) {
                                                    if (response["Message"]["Code"] == 200) {
                                                      GlobalVariable.userModelGlobal = UserModel(
                                                        docID: response["Data"]["ID"].toString(),
                                                        name: response["Data"]["Name"],
                                                        email: response["Data"]["Email"],
                                                        phone: response["Data"]["Phone"],
                                                        password: password,
                                                        isVerifPhone: response["Data"]["IsVerifPhone"] == "0" ? false : true,
                                                        code: response["Data"]["Code"].toString(),
                                                        referralCode: response["Data"]["RefCode"].toString(),
                                                        isSubUser: response["Data"]["IsSubUser"],
                                                      );
                                                      GlobalVariable.tokenApp = response["Data"]["Token"];
                                                      log("Token: " + GlobalVariable.tokenApp);

                                                      // save user session
                                                      await SharedPreferencesHelper.setUserLogin(GlobalVariable.userModelGlobal);                                                
                                                      final checkUserRes = await ApiHelper(context: Get.context, isShowDialogLoading: true).fetchCheckUser();
                                                      if (checkUserRes["Data"].isNotEmpty) {
                                                        await SharedPreferencesHelper.setUserShipperID(checkUserRes["Data"]["ShipperID"].toString());
                                                      }

                                                      log("Response : ${response['Data']}");

                                                      if ("${response["Data"]["IsVerifPhone"]}" == "1") {
                                                        SharedPreferencesHelper.setUserLogin(GlobalVariable.userModelGlobal);
                                                        try {
                                                          await ApiProfile(context: Get.context, isShowDialogLoading: false).setUserLanguage({"Locale" : GlobalVariable.languageType});
                                                        } catch (e) {}
                                                        
                                                        // Get.offAllNamed(Routes.HOME);
                                                        // GetToPage.offAllNamed<FakeHomeController>(Routes.FAKE_HOME);
                                                        Get.offAllNamed(Routes.AFTER_LOGIN_SUBUSER);
                                                        // CustomToastTop.show(
                                                        //   context: Get.context,
                                                        //   message: "Welcome, " + user.displayName,
                                                        //   isSuccess: 1
                                                        // );

                                                        //   String sellerID = await SharedPreferencesHelper.getUserSellerID();
                                                        //     if (sellerID == "" || sellerID == "0") {
                                                        //       Get.offAllNamed(Routes.CHOOSE_USER_TYPE);
                                                        //     } else {
                                                        //       Get.offAllNamed(Routes.HOME);
                                                        //     }
                                                      } else {
                                                        Get.offAllNamed(Routes.OTP_PHONE_REGISTER, arguments: GlobalVariable.userModelGlobal);
                                                      }
                                                    } else {
                                                      controller.isValid.value = false;
                                                      // String errorMessage = response["Data"]["Message"];
                                                      controller.inputtype.value ?
                                                        CustomToastTop.show(
                                                          context: Get.context,
                                                          message: "GeneralLRLoginLabelEmailPasswordSalah".tr,
                                                          isSuccess: 0
                                                        ) : 
                                                        CustomToastTop.show(
                                                          context: Get.context,
                                                          message: "GeneralLRLoginLabelNoWaPasswordSalah".tr,
                                                          isSuccess: 0
                                                        );
                                                    }
                                                  }
                                                }
                                              }
                                            }),
                                      ),
                                      // belum punya akun ?
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            GlobalVariable.ratioWidth(Get.context) *
                                                0,
                                            GlobalVariable.ratioWidth(Get.context) *
                                                18,
                                            GlobalVariable.ratioWidth(Get.context) *
                                                0,
                                            GlobalVariable.ratioWidth(Get.context) *
                                                17.5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              "GeneralLRLoginLabelBelumPunyaAkunMuatmuat".tr,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                print("daftar");
                                                GetToPage.offNamed<
                                                        RegisterUserController>(
                                                    Routes.REGISTER_USER);
                                              },
                                              child: CustomText(
                                                "GeneralLRRegisterLabelDaftar".tr,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: Color(ListColor.colorBlue),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      // learn more
                                      // Container(
                                      //   margin: EdgeInsets.fromLTRB(
                                      //       GlobalVariable.ratioWidth(Get.context) *
                                      //           0,
                                      //       GlobalVariable.ratioWidth(Get.context) *
                                      //           0,
                                      //       GlobalVariable.ratioWidth(Get.context) *
                                      //           0,
                                      //       GlobalVariable.ratioWidth(Get.context) *
                                      //           58),
                                      //   child: Column(
                                      //     mainAxisSize: MainAxisSize.max,
                                      //     crossAxisAlignment:
                                      //         CrossAxisAlignment.center,
                                      //     children: [
                                      //       CustomText(
                                      //         "Learn more about",
                                      //         fontSize: 12,
                                      //         fontWeight: FontWeight.w500,
                                      //         color: Color(ListColor.colorGrey3),
                                      //       ),
                                      //       GestureDetector(
                                      //         onTap: () {
                                      //           print("learn more");
                                      //         },
                                      //         child: CustomText(
                                      //           "muatmuat Seller / Partner",
                                      //           fontSize: 12,
                                      //           fontWeight: FontWeight.w700,
                                      //           color: Color(ListColor.colorBlue),
                                      //         ),
                                      //       )
                                      //     ],
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

  Widget _formLogin() {
    return Column(
      children: [
        // FIELD EMAIL / NO HP BEGIN
        Obx(
          () => Container(
            margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 18),
            height: GlobalVariable.ratioWidth(Get.context) * 40,
            // TARUH BORDER TEXTFIELD DISINI
            decoration: BoxDecoration(
              border: Border.all(
                width: GlobalVariable.ratioWidth(Get.context) * 1,
                color: controller.isValid.value
                    ? Color(ListColor.colorLightGrey10)
                    : Color(ListColor.colorRed)
              ),
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * 6)
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomTextFormField(
                      key: controller.useremailph.value,
                      context: Get.context,
                      autofocus: false,
                      onChanged: (value) {
                        controller.isValid.value = true;
                        if (value.isNotEmpty &&
                            controller.passwordController.text.isNotEmpty) {
                          controller.isFilled.value = true;
                        } else {
                          controller.isFilled.value = false;
                        }
                        print("Filled: " + controller.isFilled.value.toString());
                        print("Valid: " + controller.isValid.value.toString());
                      },
                      controller: controller.emailController,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.2,
                      ),
                      textSize: 14,
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.allow(
                      //       RegExp("[a-zA-Z0-9\@\.\]")),
                      // ],
                      keyboardType: TextInputType.emailAddress,
                      newInputDecoration: InputDecoration(
                        hintText: "GeneralLRLoginLabelEmailAtauNoWhatsapp".tr,
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
                    color: Color(ListColor.colorLightGrey2),
                  ),
                ),
              ],
            ),

            // child: Row(
            //   children: [
            //     // TARUH ICON DISINI
            //     Container(
            //       margin: EdgeInsets.only(
            //         right: GlobalVariable.ratioWidth(Get.context) * 10,
            //       ),
            //       child: SvgPicture.asset(
            //         "assets/ic_username_seller.svg",
            //         width: GlobalVariable.ratioWidth(Get.context) * 24,
            //         height: GlobalVariable.ratioWidth(Get.context) * 24,
            //         color: Color(ListColor.colorLightGrey2),
            //       ),
            //     ),
            //     Expanded(
            //       child: CustomTextFormField(
            //         context: Get.context,
            //         autofocus: false,
            //         onChanged: (value) {
            //           controller.isValid.value = true;
            //           if (value.isNotEmpty &&
            //               controller.passwordController.text.isNotEmpty) {
            //             controller.isFilled.value = true;
            //           } else {
            //             controller.isFilled.value = false;
            //           }
            //           print("Filled: " + controller.isFilled.value.toString());
            //           print("Valid: " + controller.isValid.value.toString());
            //         },
            //         controller: controller.emailController,
            //         textInputAction: TextInputAction.next,
            //         style: TextStyle(
            //           fontWeight: FontWeight.w500,
            //           color: Colors.black,
            //           height: 1.2,
            //         ),
            //         textSize: 14,
            //         inputFormatters: [
            //           FilteringTextInputFormatter.allow(
            //               RegExp("[a-zA-Z0-9\@\.\]")),
            //         ],
            //         keyboardType: TextInputType.emailAddress,
            //         newInputDecoration: InputDecoration(
            //           hintText: "Email atau No Whatsapp",
            //           hintStyle: TextStyle(
            //               fontWeight: FontWeight.w500,
            //               color: Color(ListColor.colorLightGrey2)),
            //           fillColor: Colors.transparent,
            //           filled: true,
            //           isDense: true,
            //           isCollapsed: true,
            //           focusedBorder: InputBorder.none,
            //           enabledBorder: InputBorder.none,
            //           border: InputBorder.none,
            //           disabledBorder: InputBorder.none,
            //           contentPadding: EdgeInsets.only(
            //             top: GlobalVariable.ratioWidth(Get.context) * 2,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ),

        // FIELD PASSWORD BEGIN
        Obx(
          () => Container(
            margin: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 0,
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 12),
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
                      key: Key('password-login'),
                      context: Get.context,
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      obscureText: !controller.isShowPassword.value,
                      obscuringCharacter: '\u2022',
                      onChanged: (value) {
                        // controller.searchOnChange(value);
                        controller.isValid.value = true;
                        if (value.isNotEmpty &&
                            controller.emailController.text.isNotEmpty) {
                          controller.isFilled.value = true;
                        } else {
                          controller.isFilled.value = false;
                        }
                        print("Filled: " + controller.isFilled.value.toString());
                        print("Valid: " + controller.isValid.value.toString());
                      },
                      controller: controller.passwordController,
                      textInputAction: TextInputAction.done,
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
                    color: Color(ListColor.colorLightGrey2),
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
                                  color: Color(ListColor.colorLightGrey2),
                                ))
                            )
                    ),
              ],
            ),

            // child: Row(
            //   children: [
            //     // TARUH ICON DISINI
            //     Container(
            //       margin: EdgeInsets.only(
            //         right: GlobalVariable.ratioWidth(Get.context) * 10,
            //       ),
            //       child: SvgPicture.asset(
            //         "assets/ic_password_seller.svg",
            //         width: GlobalVariable.ratioWidth(Get.context) * 24,
            //         height: GlobalVariable.ratioWidth(Get.context) * 24,
            //         color: Color(ListColor.colorLightGrey2),
            //       ),
            //     ),
            //     Expanded(
            //       child: CustomTextFormField(
            //         context: Get.context,
            //         autofocus: false,
            //         keyboardType: TextInputType.text,
            //         obscureText: !controller.isShowPassword.value,
            //         obscuringCharacter: '\u2022',
            //         onChanged: (value) {
            //           // controller.searchOnChange(value);
            //           controller.isValid.value = true;
            //           if (value.isNotEmpty &&
            //               controller.emailController.text.isNotEmpty) {
            //             controller.isFilled.value = true;
            //           } else {
            //             controller.isFilled.value = false;
            //           }
            //           print("Filled: " + controller.isFilled.value.toString());
            //           print("Valid: " + controller.isValid.value.toString());
            //         },
            //         controller: controller.passwordController,
            //         textInputAction: TextInputAction.done,
            //         style: TextStyle(
            //           fontWeight: FontWeight.w500,
            //           color: Colors.black,
            //           height: 1.2,
            //         ),
            //         textSize: 14,
            //         newInputDecoration: InputDecoration(
            //           hintText: "Password",
            //           hintStyle: TextStyle(
            //               fontWeight: FontWeight.w500,
            //               color: Color(ListColor.colorLightGrey2)),
            //           fillColor: Colors.transparent,
            //           filled: true,
            //           isDense: true,
            //           isCollapsed: true,
            //           focusedBorder: InputBorder.none,
            //           enabledBorder: InputBorder.none,
            //           border: InputBorder.none,
            //           disabledBorder: InputBorder.none,
            //           contentPadding: EdgeInsets.only(
            //             top: GlobalVariable.ratioWidth(Get.context) * 2,
            //           ),
            //         ),
            //       ),
            //     ),
            //     InkWell(
            //       onTap: () {
            //         controller.togglePassword();
            //       },
            //       child: Container(
            //         margin: EdgeInsets.only(
            //           left: GlobalVariable.ratioWidth(Get.context) * 12,
            //         ),
            //         height: GlobalVariable.ratioWidth(Get.context) * 24,
            //         width: GlobalVariable.ratioWidth(Get.context) * 24,
            //         alignment: Alignment.center,
            //         child: SvgPicture.asset(
            //           controller.isShowPassword.value
            //               ? "assets/ic_visible_password.svg"
            //               : "assets/ic_invisible_password.svg",
            //           color: Color(ListColor.colorLightGrey2),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
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
