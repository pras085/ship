import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/global_variable.dart';

import 'global_alert_dialog.dart';

class CekSubUserDanHakAkses {

  Future<bool> cekSubUserDanHakAksesWithShowDialog({
    @required BuildContext context, 
    @required String menuId,
    bool showDialog = true,
  }) async {
    if (GlobalVariable.userModelGlobal.isSubUser) {
      var response = await ApiHelper(context: context,isShowDialogLoading: showDialog).getHakAkses(menuId);
      log("RESPONSE GET HAK AKSES => " + response["Data"]["Message"].toString());
      if (response["Data"]["Message"] is bool && response["Data"]["Message"] ) {
        // kalau sub user dan punya hak akses
        log("RUNNN => sub user dan punya hak akses");
        return true;
      }
      else {
        // kalau sub user dan tidak punya hak akses
        log("RUNNN => sub user dan tidak punya hak akses");
        if (showDialog) {
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
        }
        return false;
      }
    }
    else {
      // bukan sub user
      log("RUNNN => bukan sub user");
      return true;
    }
  }

}
