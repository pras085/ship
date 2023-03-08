import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTruckCarrierFilterController extends GetxController {
  final listTruckCarrier = [].obs;
  final listTruckCarrierTemp = [].obs;
  final listChoosen = {}.obs;
  String title = "";
  bool _isFirstTime = true;

  Timer _timerGetMitraText;
  var filterSearch = "".obs;
  var searchBar = TextEditingController();

  //Map<String, dynamic> _listAllTruckCarrierTemp = {};
  @override
  void onInit() {
    //listTruckCarrier.addAll(Get.arguments[0]);
    //listChoosen.addAll(Get.arguments[1]);
    title = Get.arguments[2];
    //_listAllTruckCarrierTemp.addAll(Map.from(listTruckCarrier));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void startTimerGetMitra() {
    stopTimerGetMitra();
    _timerGetMitraText = Timer(Duration(seconds: 2), () async {
      refreshData();
    });
  }

  void stopTimerGetMitra() {
    if (_timerGetMitraText != null) _timerGetMitraText.cancel();
  }

  void refreshData() async {
    stopTimerGetMitra();
    listTruckCarrier.value = List.from(listTruckCarrierTemp.value)
        .where((element) => element.description
            .toLowerCase()
            .contains(filterSearch.value.toLowerCase()))
        .toList();
  }

  void onClearSearch() {
    searchBar.text = "";
    filterSearch.value = "";
    listTruckCarrier.value = List.from(listTruckCarrierTemp).toList();
  }

  void onCheckTruckCarrier(int index, bool value) {
    if (value) {
      listChoosen[listTruckCarrier[index].id] =
          listTruckCarrier[index].description;
    } else {
      listChoosen
          .removeWhere((key, value) => key == listTruckCarrier[index].id);
    }
    listTruckCarrier.refresh();
  }

  void onSubmit() {
    Get.back(result: listChoosen);
  }

  void resetAll() {
    listChoosen.clear();
    listTruckCarrier.refresh();
  }

  void onCompleteBuildWidget() {
    if (_isFirstTime) {
      _isFirstTime = false;
      listTruckCarrierTemp.addAll(Get.arguments[0]);
      listTruckCarrier.addAll(Get.arguments[0]);
      listChoosen.addAll(Get.arguments[1]);
    }
  }
}
