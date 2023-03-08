import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:muatmuat/app/core/function/change_language.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/core/models/language_model.dart';
import 'package:muatmuat/app/database/database_helper.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';

import '../../../global_variable.dart';

class SettingController extends GetxController {
  var listLanguage = List<ListLanguageData>().obs;
  var loadLanguage = false.obs;
  var loadChangeLanguage = false.obs;

  @override
  void onInit() async {}

  @override
  void onReady() {}

  @override
  void onClose() {}

  void signOut() async {
    LoginFunction().signOut();
  }

  Future changeLanguage(
      String idLanguage, String typeLanguage, String nameLanguage) async {
    loadChangeLanguage.value = true;
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (context) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: AlertDialog(
              actions: [],
              backgroundColor: Colors.transparent,
              content: Container(
                alignment: Alignment.center,
                child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator())),
              ),
            ),
          );
        });
    var locale = Locale(idLanguage);
    await SharedPreferencesHelper.setLanguage(
        idLanguage, typeLanguage, nameLanguage);
    await ChangeLanguage(Get.context).getLanguage();
    Get.updateLocale(locale);
    Get.back();
    loadChangeLanguage.value = false;
  }

  Future getListLanguage(BuildContext context) async {
    var list = await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchListLanguage();
    List<dynamic> data = list['Data'];
    var newListLanguage = List<ListLanguageData>().obs;
    DatabaseHelper.instance.deleteListLanguage();
    data.forEach((element) async {
      var languageData = ListLanguageData(
          title: element["Title"],
          locale: element["Locale"],
          urlSegment: element["URLSegment"]);
      DatabaseHelper.instance.insertListLanguage(languageData);
      newListLanguage.add(languageData);
    });
    listLanguage.clear();
    listLanguage.assignAll(newListLanguage);
  }
}
