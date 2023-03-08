import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/search_result_list_management_lokasi/search_result_list_management_lokasi_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';

class SearchListManagementLokasiController extends GetxController {
  var lastSearch = [].obs;
  var lastSearchTemp = [];
  var limitLastSearch = 7;
  var searchBar = TextEditingController();
  var search = "";
  var isShowClearSearch = false.obs;
  // var filterTransporter = Map<String, dynamic>().obs;
  // var sortShipper = Map().obs;

  @override
  void onInit() async {
    search = Get.arguments[0] as String;
    searchBar.text = search;
    // filterTransporter = Get.arguments[1];
    // sortShipper = Get.arguments[2];
    isShowClearSearch.value = search.isNotEmpty;
    await getHistory();
    // searchOnChange(search);
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  Future<void> getHistory() async {
    print('Debug: ' + "getHistory");
    try {
      var resultJson =
          jsonDecode(await SharedPreferencesHelper.getHistoryManagementLokasi())
              as List;
      lastSearch.addAll(List.from(resultJson).reversed.toList());
      lastSearchTemp.addAll(resultJson);
    } catch (err) {}
  }

  void updateHistory() async {
    if (lastSearchTemp.any((element) => element == searchBar.text)) {
      lastSearchTemp.removeWhere((element) => element == searchBar.text);
    }
    if ((lastSearchTemp.length + 1) > limitLastSearch)
      lastSearchTemp.removeAt(0);
    lastSearchTemp.add(searchBar.text);
    await SharedPreferencesHelper.setHistoryManagementLokasi(
        jsonEncode(List.from(lastSearchTemp)));
  }

  void removeAllHistory() async {
    // GlobalAlertDialog.showAlertDialogCustom(
    //     context: Get.context,
    //     title: "LocationManagementAlertWarning".tr,
    //     message: "LocationManagementAlertDeleteSearchHistoryAll".tr,
    //     labelButtonPriority1: GlobalAlertDialog.noLabelButton,
    //     labelButtonPriority2: GlobalAlertDialog.yesLabelButton,
    //     onTapPriority2: () async {
    await SharedPreferencesHelper.setHistoryManagementLokasi("");
    lastSearch.clear();
    lastSearchTemp.clear();
    // });
  }

  void removeHistory(int index) async {
    // GlobalAlertDialog.showAlertDialogCustom(
    //     context: Get.context,
    //     title: "LocationManagementAlertWarning".tr,
    //     message: "LocationManagementAlertDeleteSearchHistory".tr +
    //         " '${lastSearch[index]}'?",
    //     labelButtonPriority1: GlobalAlertDialog.noLabelButton,
    //     labelButtonPriority2: GlobalAlertDialog.yesLabelButton,
    //     onTapPriority2: () async {
    lastSearchTemp.removeWhere((element) => element == lastSearch[index]);
    await SharedPreferencesHelper.setHistoryManagementLokasi(
        jsonEncode(List.from(lastSearchTemp)));
    lastSearch.removeAt(index);
    // });
  }

  void searchOnChange(String value) {
    search = value;
    isShowClearSearch.value = search.isNotEmpty;
    lastSearch.clear();
    if (search.isNotEmpty) {
      for (String name in List.from(lastSearchTemp).reversed.toList()) {
        if (name.toLowerCase().contains(search.toLowerCase())) {
          lastSearch.add(name);
        }
      }
    } else {
      lastSearch.addAll(List.from(lastSearchTemp).reversed.toList());
    }
  }

  void onSubmitSearch() {
    updateHistory();
    SearchResultListManagementLokasiController
        searchResultListManagementLokasiController;
    try {
      searchResultListManagementLokasiController = Get.find();
    } catch (err) {}
    if (searchResultListManagementLokasiController != null)
      Get.back(result: search);
    else
      Get.offNamed(Routes.SEARCH_RESULT_LIST_MANAGEMENT_LOKASI, arguments: [
        search
        // , filterTransporter
        // , sortShipper
      ]);
  }

  void onClearSearch() {
    searchBar.text = "";
    searchOnChange("");
  }

  void onClickHistorySearch(int index) {
    search = lastSearch[index];
    searchBar.text = lastSearch[index];
    onSubmitSearch();
  }
}
