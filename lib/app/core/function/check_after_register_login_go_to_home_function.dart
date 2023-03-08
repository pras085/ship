import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/google_sign_in_function.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/global_variable.dart';

class CheckAfterRegisterLoginGoToHome {
  static Future checkGoToHome() async {
    String shipperID = await SharedPreferencesHelper.getUserShipperID();
    if (shipperID == "" || shipperID == "0") {
      Get.offAllNamed(Routes.CHOOSE_USER_TYPE);
    } else {
      // Get.offAllNamed(Routes.HOME);
      Get.offAllNamed(Routes.AFTER_LOGIN_SUBUSER);
    }
  }
}
