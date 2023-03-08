import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/mitra_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/search_result_list_transporter/search_result_list_transporter_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';

class CreateGroupTambahAnggotaController extends GetxController {
  var searchBar = TextEditingController();
  var search = "";
  var isShowClearSearch = false.obs;

  var listMitra = <MitraModel>[].obs;
  var tempListMitra = <MitraModel>[].obs;

  var selectedMitra = <MitraModel>[].obs;
  var tempSelectedMitra = <MitraModel>[].obs;

  @override
  void onInit() async {
    listMitra.addAll(await Get.arguments[0]);
    selectedMitra.addAll(await Get.arguments[1]);

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
}
