import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/change_language.dart';
import 'package:muatmuat/app/core/function/firebase_function.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/core/models/get_setting_response_model.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/api_login_register.dart';
import 'package:muatmuat/app/modules/home/before_login/beforeLoginUser_controller.dart';
import 'package:muatmuat/app/modules/intro_shipper/intro_model.dart';
import 'package:muatmuat/app/modules/login/login_controller.dart';
import 'package:muatmuat/app/modules/otp_phone/otp_phone_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:open_appstore/open_appstore.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class IntroShipperController extends GetxController {
  //TODO: Implement IntroController

  var listSlides = <IntroModelShipper>[].obs;
  var slideIndex = 0.obs;
  var isLogged = false.obs;
  
  SnappingSheetController snapcontroller = SnappingSheetController();

  var loadingSplash = true.obs;
  var loadingText = "".obs;
  RxBool show = false.obs;
  RxBool chglan = false.obs;
  RxString indo = 'true'.obs;
  RxString eng = 'false'.obs;
  RxString selectedLang = 'true'.obs;

  var _initial = false;
  var getLang = false;
  var langVersion = "";

  @override
  void onInit() async {
    super.onInit();
    await FirebaseCloudMessaging.firebaseInit();
    if (show.value == true) {
      showlan();
    }
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void setSlideNext() {
    slideIndex.value++;
  }

  void setSlidePrev() {
    slideIndex.value--;
  }

  showlan() {
    if (show.value == false) {
      show.value = true;
    } else {
      show.value = false;
    }
    return '';
  }

  void setSlideByIndex(int index) {
    slideIndex.value = index;
  }

  Future<void> setStatusIntro() async {
    await SharedPreferencesHelper.setStatusIntro(false);
  }

  Future _checkUserLogin() async {
    if (isLogged.value) {
      var body = {
        "App": "1",
        "Token": GlobalVariable.tokenApp,
      };
      var response = await ApiLoginRegister(
        context: Get.context,
        isShowDialogLoading: false,
      ).checkStatusAccount(body);
      if (response["Message"]["Code"] == 200) {
        if (response["Data"].length != 0) {
          if (response["Data"]["VerifPhone"] == 0) {
            await GetToPage.offAllNamed<OtpPhoneController>(Routes.OTP_PHONE_REGISTER,
                arguments: GlobalVariable.userModelGlobal);
          } else if (response["Data"]["ID"] == 0) {
            //pergi ke pilih user
            // await GetToPage.offAllNamed<LoginController>(Routes.LOGIN);
            GetToPage.offAllNamed<BeforeLoginUserController>(Routes.BEFORE_LOGIN_USER);
          } else {
            //masuk ke home
            // await GetToPage.offAllNamed<LoginController>(Routes.LOGIN);
            // Get.offAllNamed(Routes.FAKE_HOME);
            Get.offAllNamed(Routes.AFTER_LOGIN_SUBUSER);
          }
        } else {
          LoginFunction().signOut2();
        }
      } else {
        //pop up kesalahan inet
      }
    }
  }

  clearslide() {
    listSlides.clear();
  }

  Future _getAllSlide() async {
    // "Initialize";
    loadingText.value = "Fetching Data";
    listSlides.clear();
    selectedLang.value = GlobalVariable.languageType == "id_ID" ? "true" : "false";
    var response =
        await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .getOnBoard();
    if (response != null) {
      final message = MessageFromUrlModel.fromJson(response["Message"]);
      if (message != null && message.code == 200) {
        for (var data in response["Data"]) {
          listSlides.add(
            IntroModelShipper(
              data['Title'],
              data['Description'],
              data['Icon'],
            ),
          );
        }
      } else {
        // TODO (ERROR HERE!)
      }
    }
  }

  Future _getLanguage() async {
    // "Retrieving local language";
    loadingText.value = "Retrieving Local Language";
    if(getLang){
      try {
        await ChangeLanguage(Get.context).getLanguage();
        await SharedPreferencesHelper.setLangVersion(langVersion);
      } catch (e) {
        print(
            "Failed to get Language, used langauge from database" + e.toString());
        await ChangeLanguage(Get.context).setLanguage();
      }
    }
    else{
      await ChangeLanguage(Get.context).setLanguage();
    }
  }

  Future _getStatusLogin() async {
    // "Prepairing up";
    loadingText.value = "Prepairing Up";
    final isStatusIntro = await SharedPreferencesHelper.getStatusIntro();
    isLogged.value = await SharedPreferencesHelper.getUserLogin(() async {
      await _getStatusLogin();
    });
    print("STATUS : $isStatusIntro - ${isLogged.value}");
    if (isLogged.value != null && isLogged.value) {
      await _checkUserLogin();
    } else if (isStatusIntro != null && !isStatusIntro) {
      GetToPage.offAllNamed<BeforeLoginUserController>(Routes.BEFORE_LOGIN_USER);
    } else {
      loadingSplash.value = false;
      await Utils.initDynamicLinks();
    }
  }

  Future _getSetting() async {
    // "Retrieving Information";
    loadingText.value = "Retrieving Information";
    try {
      var response =
          await ApiHelper(context: Get.context, isShowDialogLoading: false)
              .fetchSetting();
      if (response != null) {
        GetSettingResponseModel getSettingResponseModel =
            GetSettingResponseModel.fromJson(response);
        GlobalVariable.timeoutToken = getSettingResponseModel.timeoutToken;
        langVersion = await SharedPreferencesHelper.getLangVersion();
        getLang = (langVersion.isEmpty || langVersion != getSettingResponseModel.langVersion);
        if(getLang)
          langVersion = getSettingResponseModel.langVersion;
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String buildNumber = packageInfo.buildNumber;
        print(response);
        print("<-------------- Build $buildNumber : ${getSettingResponseModel.transporterVersion} -------------->");
        if(getSettingResponseModel.shipperVersion != null && buildNumber != getSettingResponseModel.shipperVersion) {
          showPopupUpdate();
        } else await afterGetSetting();
      }
    } catch (err) {
      print("Can't get setting from API: " + err.toString());
    }
  }

  Future showPopupUpdate() async {
    GlobalAlertDialog.showAlertDialogCustom(
      context: Get.context, 
      title: "Versi terbaru tersedia",
      message: "Segera perbarui aplikasi muatmuat untuk mendapatkan fitur terbaru",
      barrierColor: Colors.transparent,
      labelButtonPriority1: "Nanti",
      labelButtonPriority2: "Perbarui",
      positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2,
      isShowCloseButton: false,
      disableGetBack: true,
      isDismissible: false,
      onTapPriority1: () async {
        Get.back();
        afterGetSetting();
      },
      onTapPriority2: (){
        OpenAppstore.launch(androidAppId: "com.sonyericsson.music", iOSAppId: "");
        afterGetSetting();
      });
  }

  Future afterGetSetting() async {
    print("START GET LANGUAGE");
    await _getLanguage();

    Future.delayed(Duration(
      seconds: 1,
    ), () {
      print("START GET STATUS LOGIN");
      _getStatusLogin();
    });
  }

  Future onCompleteBuild() async {
    if (!_initial) {
      loadingSplash.value = true;
      _initial = true;

      print("START GET ALL SLIDE");
      await _getAllSlide();

      print("START GET SETTING");
      await _getSetting();
    }
  }
}
