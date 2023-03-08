import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ListAreaPickupSearchFilterController extends GetxController {
  final listAreaPickupSearch = [].obs;
  var listAreaPickupSearchFind = [].obs;

  final listChoosen = {}.obs;
  var isShowClearSearch = false.obs;
  var searchTextEditingController = TextEditingController();

  String _searchValue = "";

  @override
  void onInit() {
    listAreaPickupSearch.value = List.from(Get.arguments[0]);
    listAreaPickupSearchFind.value = List.from(Get.arguments[0]);
    listChoosen.value = Get.arguments[1];
    //_listAllTruckCarrierTemp.addAll(Map.from(listTruckCarrier));
    super.onInit();
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

  void onCompleteBuildWidget() {
    // listAreaPickupSearch.value = Get.arguments[0];
    // listAreaPickupSearchFind.value = Get.arguments[0];
    // listChoosen.value = Get.arguments[1];
  }

  void _showAllCity() {
    listAreaPickupSearchFind.clear();
    listAreaPickupSearchFind.addAll(List.from(listAreaPickupSearch.value));
  }

  void _searchCity() {
    listAreaPickupSearchFind.clear();
    listAreaPickupSearchFind.addAll(List.from(listAreaPickupSearch.value)
        .where((element) => element.description
            .toString()
            .toLowerCase()
            .contains(_searchValue.toLowerCase()))
        .toList());
  }

  void onClearSearch() {
    searchTextEditingController.text = "";
    addTextSearchCity("");
  }

  void onCheckTruckCarrier(int index, bool value) {
    if (value) {
      listChoosen[listAreaPickupSearch[index].id] =
          listAreaPickupSearch[index].description;
    } else {
      listChoosen
          .removeWhere((key, value) => key == listAreaPickupSearch[index].id);
    }
    listAreaPickupSearch.refresh();
  }

  void onSubmit() {
    Get.back(result: Map.from(listChoosen.value));
  }

  void resetAll() {
    listChoosen.clear();
    listAreaPickupSearch.refresh();
  }
}
