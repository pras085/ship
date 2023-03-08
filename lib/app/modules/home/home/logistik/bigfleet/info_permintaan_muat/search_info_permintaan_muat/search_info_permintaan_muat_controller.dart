import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/enum/type_list_info_permintaan_muat_enum.dart';
import 'package:muatmuat/app/core/models/history_search_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/search_result_info_permintaan_muat/search_result_info_permintaan_muat_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchInfoPermintaanMuatController extends GetxController {
  static final String typeListInfoPermintaanMuatKey =
      "typeListInfoPermintaanMuat";
  static final String searchValueKey = "searchValue";
  final listHistorySearch = [].obs;

  final isShowClearSearch = false.obs;

  final searchTextEditingController = TextEditingController().obs;

  String _searchText = "";

  bool _firstTimeBuildWidget = true;

  TypeListInfoPermintaanMuat _typeListInfoPermintaanMuat;

  var _listHistorySearchTemp = [];

  var _arguments;

  @override
  void onInit() {
    _arguments = Get.arguments;
    _typeListInfoPermintaanMuat = _arguments[typeListInfoPermintaanMuatKey];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void addTextSearchInfoPermintaanMuat(String value) {
    _searchText = value;
    isShowClearSearch.value = _searchText != "";
    listHistorySearch.clear();
    if (_searchText != "") {
      for (HistorySearchModel data in _listHistorySearchTemp) {
        if (data.name.toLowerCase().contains(_searchText.toLowerCase())) {
          listHistorySearch.add(data);
        }
      }
    } else {
      listHistorySearch.addAll(_listHistorySearchTemp);
    }
    listHistorySearch.refresh();
  }

  void onClickHistorySearch(int index) {
    HistorySearchModel data = listHistorySearch[index];
    _searchText = data.name;
    onSubmitSearch();
  }

  void onSubmitSearch() {
    _arguments[searchValueKey] = _searchText;
    SearchResultInfoPermintaanMuatController
        searchResultInfoPermintaanMuatController;
    try {
      searchResultInfoPermintaanMuatController = Get.find();
    } catch (err) {}
    if (searchResultInfoPermintaanMuatController != null)
      Get.back(result: _arguments);
    else
      Get.offNamed(Routes.SEARCH_RESULT_INFO_PERMINTAAN_MUAT,
          arguments: _arguments);
    _addToSharedPref();
  }

  void _addToSharedPref() {
    if (_listHistorySearchTemp.length > 0) {
      for (int i = 0; i < _listHistorySearchTemp.length; i++) {
        if (_listHistorySearchTemp[i].name.toLowerCase() ==
            _searchText.toLowerCase()) {
          _listHistorySearchTemp.removeAt(i);
          break;
        }
      }
    }
    _listHistorySearchTemp.insert(0, HistorySearchModel(name: _searchText));
    if (_listHistorySearchTemp.length > 3)
      _listHistorySearchTemp.removeAt(_listHistorySearchTemp.length - 1);
    SharedPreferencesHelper.setHistorySearchInfoPermintaanMuat(
        jsonEncode(_listHistorySearchTemp), _typeListInfoPermintaanMuat);
  }

  void onClearSearch() {
    searchTextEditingController.value.text = "";
    addTextSearchInfoPermintaanMuat("");
    searchTextEditingController.refresh();
  }

  Future _getListHistorySearch() async {
    try {
      var resultJson = jsonDecode(
          await SharedPreferencesHelper.getHistorySearchInfoPermintaanMuat(
              _typeListInfoPermintaanMuat)) as List;
      listHistorySearch.addAll(
          resultJson.map((data) => HistorySearchModel.fromJson(data)).toList());
      listHistorySearch.refresh();
      _listHistorySearchTemp.addAll(listHistorySearch);
    } catch (err) {}
  }

  void onCompleteBuildWidget() async {
    if (_firstTimeBuildWidget) {
      _firstTimeBuildWidget = false;
      await _getListHistorySearch();
      addTextSearchInfoPermintaanMuat(_arguments[searchValueKey] ?? "");
      searchTextEditingController.value.text = _searchText;
      if (_searchText.length > 0) {
        searchTextEditingController.value.selection =
            TextSelection.fromPosition(
                TextPosition(offset: _searchText.length));
      }
    }
  }

  void onClearAllHistorySearch() async {
    await SharedPreferencesHelper.setHistorySearchInfoPermintaanMuat(
        "", _typeListInfoPermintaanMuat);
    _listHistorySearchTemp.clear();
    listHistorySearch.clear();
    listHistorySearch.refresh();
  }

  void onClearOneItemHistorySearch(int index) {
    listHistorySearch.removeAt(index);
    SharedPreferencesHelper.setHistorySearchInfoPermintaanMuat(
        jsonEncode(listHistorySearch), _typeListInfoPermintaanMuat);
    listHistorySearch.refresh();
  }
}
