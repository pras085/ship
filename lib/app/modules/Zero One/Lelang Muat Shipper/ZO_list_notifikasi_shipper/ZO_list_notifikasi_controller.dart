import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_peserta_lelang/ZO_peserta_lelang_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/api_helper_zo.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/shared_preferences_helper_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

//
class ZoListNotifikasiShipperController extends GetxController {
  var listDataNotifikasi = [].obs;
  var strValue = "";
  var loginasval = "".obs;
  var data = [];
  var disabletopeserta = false.obs;

  @override
  void onInit() async {
    var dataList = List.from(Get.arguments[0]);
    data.clear();
    dataList.forEach((element) {
      if (element["type"] == "new_transporter") {
        strValue = "LelangMuatBuatLelangBuatLelangLabelTitleAda".tr +
            " ${element["amount"]} " +
            "LelangMuatBuatLelangBuatLelangLabelTitleTrasnporterBaruMengikuti"
                .tr +
            " ${element["bid_no"]}";
      }
      if (element["type"] == "start_nego") {
        strValue = "";
      }
      if (element["type"] == "nego_rejected") {
        strValue = "LelangMuatBuatLelangBuatLelangLabelTitleResponseNego".tr +
            " ${element["bid_no"]} " +
            "LelangMuatBuatLelangBuatLelangLabelTitleDari".tr +
            " ${element["transporter_name"]}: " +
            "LelangMuatBuatLelangBuatLelangLabelTitleTidakSetuju".tr;
      }
      if (element["type"] == "nego_accepted") {
        strValue = "LelangMuatBuatLelangBuatLelangLabelTitleResponseNego".tr +
            " ${element["bid_no"]} " +
            "LelangMuatBuatLelangBuatLelangLabelTitleDari".tr +
            " ${element["transporter_name"]}: " +
            "LelangMuatBuatLelangBuatLelangLabelTitleSetuju".tr;
      }
      if (element["type"] == "nego_new_price") {
        strValue = "LelangMuatBuatLelangBuatLelangLabelTitleResponseNego".tr +
            " ${element["bid_no"]} " +
            "LelangMuatBuatLelangBuatLelangLabelTitleDari".tr +
            " ${element["transporter_name"]}: " +
            "LelangMuatBuatLelangBuatLelangLabelTitlePenawaranBaru".tr +
            " ${element["new_price"]}";
      }
      if (element["type"] == "win_bid") {
        strValue = "";
      }
      if (element["type"] == "reminder") {
        strValue = "Lelang ${element["bid_no"]} (${element["route"]}) "
            "akan berakhir pada Tanggal ${element["end_date"]}, "
            "mohon segera tentukan pemenang";
      }
      data.add({
        "ID": element["ID"],
        "ID_notif": element["ID_notif"],
        "ket": strValue,
        "is_read": element["is_read"],
        "is_seen": element["is_seen"],
        "amount": element["amount"],
        "nego_ID": element["nego_ID"],
        "created": element["created"],
      });
    });
    listDataNotifikasi.value = data;

    var resLoginAs = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getUserShiper(GlobalVariable.role);

    if (resLoginAs["Message"]["Code"] == 200) {
      loginasval.value = resLoginAs["LoginAs"].toString();
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  getNotifikasiListData() async {
    var resNotif = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getListNotifikasi(loginasval.value, GlobalVariable.role);
    //resLoginAs["LoginAs"].toString()

    if (resNotif["Message"]["Code"] == 200) {
      listDataNotifikasi.clear();
      data.clear();
      (resNotif["Data"]["data"] as List).forEach((element) {
        if (element["type"] == "new_transporter") {
          strValue = "LelangMuatBuatLelangBuatLelangLabelTitleAda".tr +
              " ${element["amount"]} " +
              "LelangMuatBuatLelangBuatLelangLabelTitleTrasnporterBaruMengikuti"
                  .tr +
              " ${element["bid_no"]}";
        }
        if (element["type"] == "start_nego") {
          strValue = "";
        }
        if (element["type"] == "nego_rejected") {
          strValue = "LelangMuatBuatLelangBuatLelangLabelTitleResponseNego".tr +
              " ${element["bid_no"]} " +
              "LelangMuatBuatLelangBuatLelangLabelTitleDari".tr +
              " ${element["transporter_name"]}: " +
              "LelangMuatBuatLelangBuatLelangLabelTitleTidakSetuju".tr;
        }
        if (element["type"] == "nego_accepted") {
          strValue = "LelangMuatBuatLelangBuatLelangLabelTitleResponseNego".tr +
              " ${element["bid_no"]} " +
              "LelangMuatBuatLelangBuatLelangLabelTitleDari".tr +
              " ${element["transporter_name"]}: " +
              "LelangMuatBuatLelangBuatLelangLabelTitleSetuju".tr;
        }
        if (element["type"] == "nego_new_price") {
          strValue = "LelangMuatBuatLelangBuatLelangLabelTitleResponseNego".tr +
              " ${element["bid_no"]} " +
              "LelangMuatBuatLelangBuatLelangLabelTitleDari".tr +
              " ${element["transporter_name"]}: " +
              "LelangMuatBuatLelangBuatLelangLabelTitlePenawaranBaru".tr +
              " ${element["new_price"]}";
        }
        if (element["type"] == "win_bid") {
          strValue = "";
        }
        data.add({
          "ID": element["ID"],
          "ID_notif": element["ID_notif"],
          "ket": strValue,
          "is_read": element["is_read"],
          "is_seen": element["is_seen"],
          "amount": element["amount"],
          "nego_ID": element["nego_ID"],
          "created": element["created"],
        });
        listDataNotifikasi.value = data;
      });
    }
    // }
  }

  toPesertaLelang(String idNotif, String idPeserta) async {
    disabletopeserta.value = true;
    var resNotif = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .postReadNotifikasi(loginasval.value, idNotif);
    if (resNotif["Message"]["Code"] == 200) {
      disabletopeserta.value = false;
      var res = await GetToPage.toNamed<ZoPesertaLelangController>(
          Routes.ZO_PESERTA_LELANG,
          preventDuplicates: false,
          arguments: [idPeserta, "aktif"]);
      if (res != null) {
        getNotifikasiListData();
        // if (res) {
        //   getListLelangMuatan(type);
        // }
      }
    }
  }
}
