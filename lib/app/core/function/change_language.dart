import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/database/database_helper.dart';
import 'package:muatmuat/app/core/models/language_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:quiver/collection.dart';
import 'package:quiver/testing/src/equality/equality.dart';

class ChangeLanguage {
  final BuildContext context;

  ChangeLanguage(this.context);

  Future getLanguage({checkAPI = true}) async {
    if (checkAPI) {
      var responseBody = await ApiHelper(
              context: context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .fetchLanguage();
      Map languageMap;
      if (responseBody != null && responseBody is Map && (responseBody).isNotEmpty) {
        languageMap = await ChangeLanguageResponseModel().fromJson(context, responseBody);
        await setLanguage(map: Map<String, String>.from(languageMap));
        Get.forceAppUpdate();
      } else {
        GlobalAlertDialog.showAlertDialogCustom(
          context: context,
          title: "Error",
          message: "Error when getting language",
          isDismissible: false,
          isShowCloseButton: false,
          labelButtonPriority1: "Retry",
          onTapPriority1: () async {
            await getLanguage(checkAPI: true);
          });
      }
    } else {
      await setLanguage();
      Get.forceAppUpdate();
    }
  }

  Future setLanguage({Map<String, String> map}) async {
    try{
      if(map != null)
        Get.appendTranslations({
          GlobalVariable.languageCode: map
        });
      else {
        var box = await Hive.openBox("MyBox");
        var language = box.get("language");
        box.close();
        var languageMap = Map<String, String>.from(jsonDecode(language));
        Get.appendTranslations({
          GlobalVariable.languageCode: languageMap
        });
      }
    } catch(eror){
      GlobalAlertDialog.showAlertDialogCustom(
        context: context,
        title: "Error",
        message: "Error when setup language",
        isDismissible: false,
        isShowCloseButton: false,
        labelButtonPriority1: "Retry",
        onTapPriority1: () async {
          await setLanguage(map: map != null ? map : null);
        });
    }
  }
}

class ChangeLanguageResponseModel {
  MessageFromUrlModel message;
  List<dynamic> listData;
  ChangeLanguageResponseModel({this.message});

  Future<Map> fromJson(BuildContext context, Map<String, dynamic> json) async {
    listData = json['Data'];
    var unescape = HtmlUnescape();
    await SharedPreferencesHelper.getLanguage();
    await DatabaseHelper.instance.deleteLanguage();

    var languageMap = {};
    for (var data in listData) {
      Map<String, dynamic> content = data["Content"];
      for (var key in content.keys) {
        if(key.isNotEmpty && content[key] != null && (content[key] as String).isNotEmpty)
        languageMap[key] = unescape.convert(content[key] ?? "");
      }
    }
    await savingLanguage(context, languageMap);
    return languageMap;
  }

  Future savingLanguage(BuildContext context, Map languageMap) async {
    try{
      var box = await Hive.openBox("MyBox");
      await box.put("language", jsonEncode(languageMap));
      box.close();
    } catch(error) {
      GlobalAlertDialog.showAlertDialogCustom(
        context: context,
        title: "Error",
        message: "Error when saving language",
        isDismissible: false,
        isShowCloseButton: false,
        labelButtonPriority1: "Retry",
        onTapPriority1: () async {
          await savingLanguage(context, languageMap);
        });
    }
  }
}
