import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/home/profile/model/model_pengaturan_akun.dart';
import 'package:muatmuat/app/modules/home/profile/model/model_syarat_profil.dart';
import 'package:muatmuat/app/network/api_helper.dart';

class PengaturanAkunController extends GetxController {
  var isInit = true;
  var isLoading = true.obs;
  var isError = false.obs;
  var isChange = false.obs;
  ModelPengaturanAkun akun = ModelPengaturanAkun();
  ModelSyaratProfil syarat = ModelSyaratProfil();
  Map<String, ModelSyaratProfil> listSyarat  = {};

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
      getInit();
      isInit = false;
    }
  }

  Future<void> getInit() async {
    isLoading.value = true;
    try {
      await getDataAkun();
      await getSyaratDanKetentuan();
      await getKebijakanPrivasi();
    } catch (error) {
      print("ERROR :: $error");
    }
    isLoading.value = false;
  }

  Future<void> getDataAkun({bool showLoading = false}) async {
    try {
      var response = await ApiProfile(context: Get.context, isShowDialogLoading: showLoading).getUsersMuat({});
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          // sukses
          // convert json to object
          akun = ModelPengaturanAkun.fromJson(response["Data"]);
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

  Future<void> getSyaratDanKetentuan({bool showLoading = false}) async {
    try {
      var response = await ApiProfile(context: Get.context, isShowDialogLoading: showLoading).termsConditionType({});
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          // sukses
          // convert json to object
          for(int i = 0; i < response["Data"].length; i++){
            syarat = ModelSyaratProfil.fromJson(response["Data"][i]);
            if(syarat.type == "register_tm") {
              //Transport Market Subscription
              listSyarat["register_tm"] = syarat;
            } else if(syarat.type == "register_bf") {
              //Big Fleets Subscription
              listSyarat["register_bf"] = syarat;
            } else if(syarat.type == "tm") {
              //Transport Market
              listSyarat["tm"] = syarat;
            } else if(syarat.type == "general") {
              //Pengguna MuatMuat
              listSyarat["general"] = syarat;
            } else if(syarat.type == "bf") {
              //Big Fleets
              listSyarat["bf"] = syarat;
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

  Future<void> getKebijakanPrivasi({bool showLoading = false}) async {
    try {
      var response = await ApiHelper(context: Get.context, isShowDialogLoading: showLoading).fetchPrivacyPolicy();
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          // sukses
          listSyarat["kebijakan"] = ModelSyaratProfil(
            title: "Kebijakan Privasi", 
            type: "kebijakan", 
            contentId: response["Data"][0]["Content"]
          );
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

  void onWillPop() {
    Get.back(result: isChange.value /* isChange */);
  }
}
