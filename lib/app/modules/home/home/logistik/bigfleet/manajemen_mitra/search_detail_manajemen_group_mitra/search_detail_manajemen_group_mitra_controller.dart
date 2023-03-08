import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/mitra_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/search_result_list_transporter/search_result_list_transporter_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';

class SearchDetailManajemenGroupMitraController extends GetxController {
  var searchBar = TextEditingController();
  var search = "";
  var isShowClearSearch = false.obs;

  var groupID = "";
  var listMitra = <MitraModel>[].obs;
  var tempListMitra = <MitraModel>[].obs;

  var selectedMitra = <MitraModel>[].obs;
  var tempSelectedMitra = <MitraModel>[].obs;

  var loading = false.obs;
  var change = false;

  @override
  void onInit() async {
    listMitra.addAll(await Get.arguments[0]);
    // selectedMitra.addAll(await Get.arguments[1]);
    groupID = await Get.arguments[1];

    tempSelectedMitra.clear();
    tempListMitra.clear();
    tempListMitra.addAll(listMitra.value);
    tempSelectedMitra.addAll(selectedMitra.value);
    // searchBar.text = search;
    // isShowClearSearch.value = search.isNotEmpty;
    // searchOnChange(search);
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  void searchOnChange(String value) {
    search = value;
    isShowClearSearch.value = search.isNotEmpty;
    tempListMitra.clear();
    tempListMitra
        .addAll(List<MitraModel>.from(listMitra.value).where((element) {
      return element.name
          .toString()
          .toLowerCase()
          .contains(value.toLowerCase());
    }));
  }

  void onClearSearch() {
    searchBar.text = "";
    searchOnChange("");
  }

  void hapusMitra(MitraModel mitra) {
    GlobalAlertDialog.showAlertDialogCustom(
      title: "PartnerManagementLabelTitleRemovePartner".tr,
      message: "PartnerManagementRemoveQuestion".tr,
      context: Get.context,
      labelButtonPriority1: "PartnerManagementLabelCancel".tr,
      onTapPriority2: () async {
        loading.value = true;
        var response =
            await ApiHelper(context: Get.context, isShowDialogLoading: false)
                .removeMitraFromGroup(mitra.docID);

        var message = MessageFromUrlModel.fromJson(response['Message']);
        if (message.code == 200) {
          await getListMitraOnGroup();
          searchOnChange(search);
          change = true;
          loading.value = false;
          CustomToast.show(
              context: Get.context,
              message: "PartnerManagementHasBeenRemoved".tr);
        } else {
          loading.value = false;
          CustomToast.show(
              context: Get.context, message: response["Data"]["Message"]);
        }
      },
      labelButtonPriority2: "PartnerManagementLabelRemove".tr,
    );
  }

  Future<void> getListMitraOnGroup() async {
    var response =
        await ApiHelper(context: Get.context, isShowDialogLoading: true)
            .fetchListPartnerInGroup(groupID);

    List<dynamic> getListMitra = response["Data"];
    if (listMitra.value != null) {
      listMitra.clear();
    } else {
      listMitra.value = [];
    }
    getListMitra.forEach((element) {
      listMitra.add(MitraModel.fromJson(element));
    });
  }
}
