import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/change_language.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/home/profile/model/model_pengaturan_akun.dart';
import 'package:muatmuat/app/modules/home/profile/model/model_status_subscribe.dart';
import 'package:muatmuat/app/modules/home/profile/model/model_user_profile.dart';
import 'package:muatmuat/app/modules/home/profile/model/model_user_status.dart';
import 'package:muatmuat/app/modules/home/profile/model/model_zona_waktu_dan_bahasa.dart';
import 'package:muatmuat/app/modules/profile_perusahaan/profile_perusahaan_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class ZonaWaktuDanBahasaController extends GetxController {
  var isInit = true;
  var isLoading = true.obs;
  var loadChangeLanguage = false.obs;
  var isError = false.obs;
  var isChange = false.obs;
  var listDataWaktuBahasa = <ModelZonaWaktuDanBahasa>[].obs;
  var selectedListDataWaktu = ModelZonaWaktuDanBahasa().obs;
  var selected = {}.obs;
  final _keyDialog = new GlobalKey<State>();
  // WAKTU_BAHASA tipe;
  var tipe = Rxn<WAKTU_BAHASA>();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) => onCompleteBuildWidget());
  }

  @override 
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onCompleteBuildWidget() async {
    if (isInit) {
      tipe.value = await Get.arguments[0];
      selected.value["value"] = await Get.arguments[1];
      selected.value["i"] = -1;
      getInit();
      isInit = false;
    }
  }

  Future<void> getInit() async {
    isLoading.value = true;
    try {
      await getData();
    } catch (error) {
      print("ERROR :: $error");
    }
    isLoading.value = false;
  }

  void selectData(int i,ModelZonaWaktuDanBahasa model) {
    // selected.remove("i");
    // selected.remove("value");
    selected.value["i"] = i;
    selected.value["value"] = model;
    selected.refresh();
  }

  Future<void> getData({bool showLoading = false}) async {
    try {
      bool waktu = tipe.value == WAKTU_BAHASA.WAKTU;
      var response = 
      waktu
      ? await ApiProfile(context: Get.context, isShowDialogLoading: showLoading).getListTimezone({
        "UsersID" : GlobalVariable.docID
      })
      : await ApiProfile(context: Get.context, isShowDialogLoading: showLoading).getListLanguage({});
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          if(waktu){
            if(selected.value["value"].id != response["SupportingData"]["Used"]) {
              isChange.value = true;
              selected.value["value"].id = response["SupportingData"]["Used"];
            }
          }
          // sukses
          // convert json 
          listDataWaktuBahasa.clear();
          for(int i = 0; i < response["Data"].length; i++) {
            listDataWaktuBahasa.add(ModelZonaWaktuDanBahasa.fromJson(response["Data"][i]));
            if((selected.value["value"].id) == listDataWaktuBahasa[i].id) {
              selected.value["i"] = i;
            }
          }
        } else {
          // error
        }
      } else {
        // error
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
    }
  }
  
  Future<void> saveData({bool showLoading = false}) async{
    try {
      bool waktu = tipe.value == WAKTU_BAHASA.WAKTU;
      var response;
      if(waktu) {
        response = await ApiProfile(context: Get.context, isShowDialogLoading: showLoading).doUpdateTimeZoneUser({
          "TimezoneID" : selected.value["value"].id.toString()
        });
        if (response != null) {
          if (response["Message"]["Code"] == 200) {
            isChange.value = true;
            onWillPop();
          } else {
            // error
          }
        } else {
          // error
        }
      }
      else {
        changeLanguage(selected["value"].urlSegment, selected["value"].locale, selected["value"].alias);
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
    }
  }

  Future changeLanguage(String idLanguage, String typeLanguage, String nameLanguage) async {
    loadChangeLanguage.value = true;
    showDialog(
      context: Get.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            key: _keyDialog,
            backgroundColor: Colors.black54,
            children: <Widget>[
              Center(
                child: Column(children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText('GlobalLabelDialogLoading'.tr,
                      color: Colors.blueAccent)
                ]),
              )
            ]));
      });
    var response = await ApiProfile(context: Get.context, isShowDialogLoading: false).setUserLanguage({
      "Locale" : typeLanguage
    });
    if (response != null) {
      if (response["Message"]["Code"] == 200) {
        var locale = Locale(idLanguage);
        await SharedPreferencesHelper.setLanguage(idLanguage, typeLanguage, nameLanguage);
        await ChangeLanguage(Get.context).getLanguage();
        Get.updateLocale(locale);
        Get.back();
        loadChangeLanguage.value = false;
        isChange.value = true;
        // onWillPop();
        Get.offAllNamed(Routes.BAHASA_PLACEHOLDER);
      } else {
        Get.back();
        // error
      }
    } else {
      Get.back();
    }
    
  }

  void onWillPop() {
    Get.back(result: isChange.value);
  }
}
