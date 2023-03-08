import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/network/api_helper.dart';

class ChooseEkspetasiDestinasiController extends GetxController {
  var loading = true.obs;

  var allLocation = false.obs;
  final listLocation = {}.obs;
  final listChoosen = {}.obs;

  final searchTextEditingController = TextEditingController().obs;
  final isShowClearSearch = false.obs;

  Map<String, dynamic> _listAllLocationTemp = {};
  Map<String, dynamic> _listAllLocationInitialPosTemp = {};
  Map<String, dynamic> _listAllLocationInitialPos = {};
  String _searchValue = "";

  var title = "".obs;

  @override
  void onInit() async {
    await _getCity();
    var getMap = Get.arguments[0] as Map;
    if (Get.arguments[1] != null) {
      title.value = Get.arguments[1];
    }
    if (getMap.isNotEmpty && getMap.keys.contains("0"))
      allLocation.value = true;
    getMap.removeWhere((key, value) => key == "0");
    listChoosen.addAll(getMap);
    _listAllLocationTemp.addAll(Map.from(listLocation));
    _setListInitialsPos(Map.from(listLocation));
    _listAllLocationInitialPosTemp.addAll(_listAllLocationInitialPos);
    loading.value = false;
    super.onInit();
  }

  Map<String, dynamic> _getSortingByValue(Map<String, dynamic> data) {
    var sortedKeys = data.keys.toList(growable: false)
      ..sort(
          (k1, k2) => data[k1].split(" ")[1].compareTo(data[k2].split(" ")[1]));
    LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
        key: (k) => k, value: (k) => data[k]);
    return Map<String, dynamic>.from(sortedMap);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void addTextSearchCity(String value) {
    _searchValue = value;
    if (_searchValue != "") {
      isShowClearSearch.value = true;
      _searchCity();
    } else {
      isShowClearSearch.value = false;
      _showAllCity();
    }
  }

  void onSubmitSearch() {
    _searchCity();
  }

  void onClearSearch() {
    searchTextEditingController.value.text = "";
    addTextSearchCity("");
  }

  void onCheckCity(int index, bool value) {
    allLocation.value = false;
    if (value) {
      listChoosen[listLocation.keys.elementAt(index)] =
          listLocation.values.elementAt(index);
    } else {
      listChoosen.removeWhere(
          (key, value) => key == listLocation.keys.elementAt(index));
    }
    listLocation.refresh();
  }

  void _searchCity() {
    listLocation.clear();
    _listAllLocationInitialPos.clear();
    Map<String, dynamic> listMap = {};
    for (var data in _listAllLocationTemp.entries) {
      if (data.value.toLowerCase().contains(_searchValue.toLowerCase())) {
        listMap[data.key] = data.value;
        if (!_listAllLocationInitialPos
            .containsKey(data.value.split(" ")[1][0]))
          _listAllLocationInitialPos[data.value.split(" ")[1][0]] = data.key;
      }
    }
    listLocation(listMap);
    listLocation.refresh();
  }

  void _showAllCity() {
    listLocation.clear();
    _listAllLocationInitialPos.clear();
    _listAllLocationInitialPos.addAll(_listAllLocationInitialPosTemp);
    listLocation(Map.from(_listAllLocationTemp));
    listLocation.refresh();
  }

  void onSubmit() {
    Get.back(
        result: allLocation.value ? {"0": "Siap kemana saja"} : listChoosen);
  }

  void _setListInitialsPos(Map<String, dynamic> data) {
    _listAllLocationInitialPos.clear();
    data.entries.forEach((element) {
      if (!_listAllLocationInitialPos
          .containsKey(element.value.split(" ")[1][0]))
        _listAllLocationInitialPos[element.value.split(" ")[1][0]] =
            element.key;
    });
  }

  String getInitial(String key) {
    return _listAllLocationInitialPos.keys.firstWhere(
        (element) => _listAllLocationInitialPos[element] == key,
        orElse: () => "");
  }

  void resetAll() {
    allLocation.value = false;
    listChoosen.clear();
    listLocation.refresh();
  }

  Future _getCity() async {
    var resultArea = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchAllCity();
    List dataArea = resultArea["Data"];
    dataArea.sort((a, b) => a["Kota"]
        .toString()
        .split(" ")[1]
        .compareTo(b["Kota"].toString().split(" ")[1]));
    dataArea.forEach((element) {
      listLocation[element["ID"].toString()] = element["Kota"];
    });
  }
}
