import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/search_result_list_transporter/search_result_list_transporter_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';

class SearchListTransporterController extends GetxController {
  var lastSearch = [].obs;
  var lastSearchTemp = [];
  var limitLastSearch = 3;
  var searchBar = TextEditingController();
  var search = "";
  var isShowClearSearch = false.obs;
  var sortShipper = Map().obs;

  @override
  void onInit() async {
    search = Get.arguments[0] as String;
    searchBar.text = search;
    sortShipper.value = Get.arguments[1];
    isShowClearSearch.value = search.isNotEmpty;
    await getHistory();
    searchOnChange(search);
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  Future<void> getHistory() async {
    try {
      var resultJson =
          jsonDecode(await SharedPreferencesHelper.getHistoryTransporter())
              as List;
      lastSearch.addAll(resultJson);
      lastSearchTemp.addAll(resultJson);
    } catch (err) {}
  }

  void updateHistory() {
    if ((lastSearchTemp.length + 1) > limitLastSearch) lastSearchTemp.removeAt(0);
    lastSearchTemp.add(searchBar.text);
    SharedPreferencesHelper.setHistoryTransporter(
        jsonEncode(List.from(lastSearchTemp)));
  }

  void removeAllHistory() {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: "Peringatan",
        message: "Apakah anda yakin untuk menghapus semua pencarian terakhir?",
        labelButtonPriority1: "Batal",
        labelButtonPriority2: "Yakin",
        onTapPriority2: () {
          lastSearch.clear();
          lastSearchTemp.clear();
          SharedPreferencesHelper.setHistoryTransporter("");
        });
  }

  void removeHistory(int index) {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: "Peringatan",
        message: "Apakah anda yakin untuk menghapus '${lastSearch[index]}'?",
        labelButtonPriority1: "Batal",
        labelButtonPriority2: "Yakin",
        onTapPriority2: () {
          lastSearch.removeAt(index);
          lastSearchTemp.removeAt(index);
          SharedPreferencesHelper.setHistoryTransporter(
              jsonEncode(List.from(lastSearch)));
        });
  }

  void searchOnChange(String value) {
    search = value;
    isShowClearSearch.value = search.isNotEmpty;
    lastSearch.clear();
    if (search.isNotEmpty) {
      for (String name in lastSearchTemp) {
        if (name.toLowerCase().contains(search.toLowerCase())) {
          lastSearch.add(name);
        }
      }
    } else {
      lastSearch.addAll(lastSearchTemp);
    }
  }

  void onSubmitSearch() {
    updateHistory();
    SearchResultListTransporterController
        searchResultShipperWatchlistController;
    try {
      searchResultShipperWatchlistController = Get.find();
    } catch (err) {}
    if (searchResultShipperWatchlistController != null)
      Get.back(result: search);
    else
      Get.offNamed(Routes.SEARCH_RESULT_LIST_TRANSPORTER,
          arguments: [search, sortShipper]);
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
