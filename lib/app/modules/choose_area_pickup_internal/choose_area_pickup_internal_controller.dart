import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';

class ChooseAreaPickupInternalController extends GetxController {
  var loading = false.obs;
  final listLocation = {}.obs;
  final listChoosen = {}.obs;

  final searchTextEditingController = TextEditingController().obs;
  final isShowClearSearch = false.obs;

  var type = 0;

  Map<String, dynamic> _listAllLocationTemp = {};
  Map<String, dynamic> _listAllLocationInitialPosTemp = {};
  Map<String, dynamic> _listAllLocationInitialPos = {};
  var searchValue = "".obs;

  var lastSearchTransaction = {}.obs;
  var lastTransaction = {}.obs;

  var limitSearch = 10;
  var limitLastSearch = 4;
  var firstLoad = true.obs;
  Timer timerGetLocation;
  var loadLastSearchLastTrasaction = true.obs;

  bool _firstTimeBuildWidget = true;

  @override
  void onInit() async {
    type = Get.arguments[0];
    if (type == 0) {
      // await _getCity();
      await _getLastTransactionCity();
      await _getLastSearchCity();
    } else {
      // await _getDistrict();
      await _getLastTransactionDistrict();
      await _getLastSearchDistrict();
    }
    listChoosen.addAll(Get.arguments[1]);
    _listAllLocationTemp.addAll(Map.from(listLocation));
    _setListInitialsPos(Map.from(listLocation));
    _listAllLocationInitialPosTemp.addAll(_listAllLocationInitialPos);
    // loading.value = false;
    loadLastSearchLastTrasaction.value = false;
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

  void onCompleteBuildWidget() async {
    if (type == 0) {
      await _getLastTransactionCity();
      await _getLastSearchCity();
    } else {
      await _getLastTransactionDistrict();
      await _getLastSearchDistrict();
    }

    // searchTextEditingController.value.text = '';
    // searchValue.value = "";
    // isShowClearSearch.value = searchValue.isNotEmpty;
    // listLocation.clear();
    // firstLoad = true.obs;
  }

  void addTextSearchCity(String value) {
    searchValue.value = value;
    isShowClearSearch.value = searchValue.isNotEmpty;
    _startTimer();
  }

  void onSubmitSearch() {
    // _startTimer();
    if (searchValue.isNotEmpty) {
      firstLoad.value = false;
      type == 0 ? _getCity() : _getDistrict();
    }
  }

  void _startTimer() {
    _stopTimerGetCity();
    timerGetLocation = Timer(Duration(seconds: 1), () async {
      if (searchValue.isNotEmpty) {
        firstLoad.value = false;
        type == 0 ? _getCity() : _getDistrict();
      }
    });
  }

  void _stopTimerGetCity() {
    if (timerGetLocation != null) timerGetLocation.cancel();
  }

  void onClearSearch() {
    searchTextEditingController.value.text = "";
    _stopTimerGetCity();
    addTextSearchCity("");
  }

  void onCheckLocation(int index, bool value) {
    if (value) {
      listChoosen.clear();
      listChoosen[listLocation.keys.elementAt(index)] =
          listLocation.values.elementAt(index);
      if (lastTransaction[listLocation.keys.elementAt(index).toString()] ==
          null) {
        type == 0
            ? _setLastSearchCity(listLocation.keys.elementAt(index).toString(),
                listLocation.values.elementAt(index))
            : _setLastSearchDistrict(
                listLocation.keys.elementAt(index).toString(),
                listLocation.values.elementAt(index));
      }
    } else {
      // listChoosen.removeWhere(
      //     (key, value) => key == listLocation.keys.elementAt(index));
      listChoosen.removeWhere((key, value) =>
          (value as String).contains(listLocation.values.elementAt(index)));
    }
    listLocation.refresh();
    onSubmit();
  }

  void onCheckLastTransaction(int index) {
    listChoosen.clear();
    listChoosen[lastTransaction.keys.toList()[index]] =
        lastTransaction.values.toList()[index];
    onSubmit();
  }

  void onCheckLastSearchTransaction(int index) {
    listChoosen.clear();
    listChoosen[lastSearchTransaction.keys.toList()[index]] =
        lastSearchTransaction.values.toList()[index];
    type == 0
        ? _setLastSearchCity(lastSearchTransaction.keys.toList()[index],
            lastSearchTransaction.values.toList()[index])
        : _setLastSearchDistrict(lastSearchTransaction.keys.toList()[index],
            lastSearchTransaction.values.toList()[index]);
    onSubmit();
  }

  void onSubmit() {
    onClearSearch();
    Get.back(result: listChoosen);
  }

  void _setListInitialsPos(Map<String, dynamic> data) {
    _listAllLocationInitialPos.clear();
    data.entries.forEach((element) {
      var initial =
          type == 0 ? element.value.split(" ")[1][0] : element.value[0];
      if (!_listAllLocationInitialPos.containsKey(initial))
        _listAllLocationInitialPos[initial] = element.key;
    });
  }

  String getInitial(String key) {
    return _listAllLocationInitialPos.keys.firstWhere(
        (element) => _listAllLocationInitialPos[element] == key,
        orElse: () => "");
  }

  void resetAll() {
    listChoosen.clear();
    listLocation.refresh();
  }

  Future _getCity() async {
    loading.value = true;
    var resultArea = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchSearchCity(searchValue.value);
    List dataArea = resultArea["Data"] as List;
    dataArea = dataArea.sublist(0, dataArea.length < 4 ? dataArea.length : 4);
    var locationMap = {};
    dataArea.forEach((element) {
      locationMap[element["CityID"].toString()] = element["City"];
    });
    listLocation.value = locationMap;
    loading.value = false;
  }

  Future _getDistrict() async {
    loading.value = true;
    var resultArea = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchAllDistrict(searchValue.value);
    List dataArea = resultArea["Data"] as List;
    dataArea = dataArea.sublist(0, dataArea.length < 4 ? dataArea.length : 4);
    var locationMap = {};
    dataArea.forEach((element) {
      locationMap[element["DistrictID"].toString()] = element["District"];
    });
    listLocation.value = locationMap;
    loading.value = false;
  }

  Future _getLastTransactionCity() async {
    var stringCity =
        await SharedPreferencesHelper.getAreaPickupLastTransactionCity() ?? "";
    lastTransaction.value = stringCity.isEmpty
        ? {}
        : jsonDecode(stringCity); //fix Rizki tambah toLIst()
  }

  Future _getLastTransactionDistrict() async {
    var stringDistrict =
        await SharedPreferencesHelper.getAreaPickupLastTransactionDistrict() ??
            "";
    lastTransaction.value = stringDistrict.isEmpty
        ? {}
        : jsonDecode(stringDistrict); //fix Rizki tambah toLIst()
  }

  Future _getLastSearchCity() async {
    var stringCity =
        await SharedPreferencesHelper.getAreaPickupLastSearchCity() ?? "";
    lastSearchTransaction.value = stringCity.isEmpty
        ? {}
        : jsonDecode(stringCity); //fix Rizki tambah toLIst()

    print('Debug: ' + 'lastTransaction = ' + lastTransaction.toString());
    print('Debug: ' +
        'lastSearchTransaction = ' +
        lastSearchTransaction.toString());
    lastTransaction.forEach((keyTransaction, valueTransaction) {
      print('Debug: ' + 'keyTransaction = ' + keyTransaction.toString());
      if (lastSearchTransaction.keys.toList().contains(keyTransaction)) {
        lastSearchTransaction
            .removeWhere((key, value) => key == keyTransaction);
      }
    });
  }

  Future _getLastSearchDistrict() async {
    var stringDistrict =
        await SharedPreferencesHelper.getAreaPickupLastSearchDistrict() ?? "";
    lastSearchTransaction.value = stringDistrict.isEmpty
        ? {}
        : jsonDecode(stringDistrict); //fix Rizki tambah toLIst()
  }

  Future _setLastSearchCity(String cityID, String city) async {
    var listCity = Map.from(lastSearchTransaction.value);
    if (listCity.keys.toList().contains(cityID)) {
      listCity.removeWhere((key, value) => key == cityID);
    }
    while (listCity.length > limitLastSearch) {
      listCity.removeWhere((key, value) => key == listCity.keys.first);
    }
    listCity[cityID] = city;
    // if (!listCity.keys.toList().contains(cityID)) {
    //   if (listCity.length == limitLastSearch)
    //     listCity.remove(listCity[listCity.keys.first]);
    //   listCity[cityID] = city;
    // }
    await SharedPreferencesHelper.setAreaPickupLastSearchCity(listCity);
  }

  Future _setLastSearchDistrict(String districtID, String district) async {
    var listDistrict = Map.from(lastSearchTransaction.value);
    if (listDistrict.keys.toList().contains(districtID)) {
      listDistrict.removeWhere((key, value) => key == districtID);
    }
    while (listDistrict.length > limitLastSearch) {
      listDistrict.removeWhere((key, value) => key == listDistrict.keys.first);
    }
    listDistrict[districtID] = district;
    // if (listDistrict.keys.toList().contains(districtID)) {
    //   if (listDistrict.length == limitLastSearch)
    //     listDistrict.remove(listDistrict[listDistrict.keys.first]);
    //   listDistrict[districtID] = district;
    // }
    await SharedPreferencesHelper.setAreaPickupLastSearchDistrict(listDistrict);
  }
}
