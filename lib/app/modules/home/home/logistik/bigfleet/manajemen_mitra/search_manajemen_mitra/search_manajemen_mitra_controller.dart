import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/history_search_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_type_enum.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/search_result_manajemen_mitra/search_result_manajemen_mitra_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/search_result_manajemen_mitra/search_result_manajemen_mitra_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';

class SearchManajemenMitraController extends GetxController {
  static final searchValueArgsKey = "SearchValue";
  static final typeMitraArgsKey = "TypeMitra";
  static final listDataListSortingModelArgsKey = "ListSorting";

  final searchTextEditingController = TextEditingController().obs;

  final isShowClearSearch = false.obs;

  final listHistorySearch = [].obs;

  ManajemenMitraController _manajemenMitraController = Get.find();

  SearchResultManajemenMitraController _searchResultManajemenMitraController;

  var _args;

  String _textSearch = "";

  bool _firstTimeBuildWidget = true;
  bool _callAfterSearchManajemenMitraController = false;

  var _listHistorySearchTemp = [];

  TypeMitra typeMitra;

  @override
  void onInit() {
    _args = Get.arguments;
    typeMitra = _args[typeMitraArgsKey];
    searchTextEditingController.value.text = _args[searchValueArgsKey];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    if (_callAfterSearchManajemenMitraController) {
      _manajemenMitraController.afterFromSearch();
    }
  }

  void onChangeText(String textSearch) {
    _textSearch = textSearch;
    isShowClearSearch.value = _textSearch != "";
  }

  void onClearSearch() {
    searchTextEditingController.value.text = "";
    onChangeText("");
  }

  void onSearch(String textSearch) {
    _args[searchValueArgsKey] = textSearch;
    if (_searchResultManajemenMitraController != null)
      Get.back(result: _args);
    else {
      _callAfterSearchManajemenMitraController = false;
      Get.offNamed(Routes.SEARCH_RESULT_MANAJEMEN_MITRA, arguments: _args);
    }
    _addToSharedPref();
  }

  void _addToSharedPref() {
    if (_textSearch != "") {
      if (_listHistorySearchTemp.length > 0) {
        for (int i = 0; i < _listHistorySearchTemp.length; i++) {
          if (_listHistorySearchTemp[i].name.toLowerCase() ==
              _textSearch.toLowerCase()) {
            _listHistorySearchTemp.removeAt(i);
            break;
          }
        }
      }
    }
    _listHistorySearchTemp.insert(0, HistorySearchModel(name: _textSearch));
    if (_listHistorySearchTemp.length > 3)
      _listHistorySearchTemp.removeAt(_listHistorySearchTemp.length - 1);
    SharedPreferencesHelper.setHistorySearchManajemenMitra(
        jsonEncode(_listHistorySearchTemp), typeMitra);
  }

  void addTextSearch(String value) {
    _textSearch = value;
    isShowClearSearch.value = _textSearch != "";
    listHistorySearch.clear();
    if (_textSearch != "") {
      for (HistorySearchModel data in _listHistorySearchTemp) {
        if (data.name.toLowerCase().contains(_textSearch.toLowerCase())) {
          listHistorySearch.add(data);
        }
      }
    } else {
      listHistorySearch.addAll(_listHistorySearchTemp);
    }
    listHistorySearch.refresh();
  }

  void onCompleteBuildWidget() async {
    if (_firstTimeBuildWidget) {
      _firstTimeBuildWidget = false;
      _checkSearchResultManajemenMitraController();
      _checkCallAfterUpdateManajemenMitraController();
      await _getListHistorySearch();
      addTextSearch(_args[searchValueArgsKey] ?? "");
      searchTextEditingController.value.text = _textSearch;
      if (_textSearch.length > 0) {
        searchTextEditingController.value.selection =
            TextSelection.fromPosition(
                TextPosition(offset: _textSearch.length));
      }
    }
  }

  void onClearAllHistorySearch() async {
    await SharedPreferencesHelper.setHistorySearchManajemenMitra("", typeMitra);
    _listHistorySearchTemp.clear();
    listHistorySearch.clear();
    listHistorySearch.refresh();
  }

  void onClearOneItemHistorySearch(int index) {
    listHistorySearch.removeAt(index);
    SharedPreferencesHelper.setHistorySearchManajemenMitra(
        jsonEncode(listHistorySearch), typeMitra);
    listHistorySearch.refresh();
  }

  Future _getListHistorySearch() async {
    try {
      var resultJson = jsonDecode(
          await SharedPreferencesHelper.getHistorySearchManajemenMitra(
              typeMitra)) as List;
      listHistorySearch.addAll(
          resultJson.map((data) => HistorySearchModel.fromJson(data)).toList());
      listHistorySearch.refresh();
      _listHistorySearchTemp.addAll(listHistorySearch);
    } catch (err) {}
  }

  void onClickHistorySearch(int index) {
    HistorySearchModel data = listHistorySearch[index];
    _textSearch = data.name;
    onSearch(_textSearch);
  }

  void _checkSearchResultManajemenMitraController() {
    try {
      _searchResultManajemenMitraController =
          Get.find<SearchResultManajemenMitraController>();
    } catch (err) {}
  }

  void _checkCallAfterUpdateManajemenMitraController() {
    _callAfterSearchManajemenMitraController =
        _searchResultManajemenMitraController == null;
  }
}
