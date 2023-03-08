import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/global_variable.dart';

import 'global_alert_dialog.dart';

class CekSubUserDanHakAkses {

  Future<bool> cekSubUserDanHakAkses(BuildContext context, String menuId) async {
    if (GlobalVariable.userModelGlobal.isSubUser) {
      var response = await ApiHelper(context: Get.context, isShowDialogLoading: true).getHakAkses(menuId);
      if (response["Data"]["Message"]) {
        // kalau sub user dan punya hak akses
        return true;
      }
      else {
        // kalau sub user dan tidak punya hak akses
        GlobalAlertDialog.showAlertDialogCustom(
          context: context,
          message: "Maaf, Anda belum memiliki akses.",
          isDismissible: false,
          isShowCloseButton: false,
          labelButtonPriority1: "OK",
          onTapPriority1: () {
            print("RUNNN");
          },
          widthButton1: 104,
          heightButton1: 36,
          borderRadiusButton1: 18,
        );
        return false;
      }
    }
    else {
      // bukan sub user
      return true;
    }
  }

}
