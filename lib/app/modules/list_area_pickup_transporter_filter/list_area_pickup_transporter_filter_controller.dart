import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/transporter_area_pickup_filter_model.dart';

class ListAreaPickupTransporterFilterController extends GetxController {
  var listParent = [].obs;
  var listParentTemp = [].obs;
  var listChild = [].obs;
  var listChildTemp = [].obs;
  var expandParent = {}.obs;

  var listChoosen = {}.obs;
  var isShowClearSearch = false.obs;
  var searchTextEditingController = TextEditingController();

  String _searchValue = "";

  @override
  void onInit() {
    listChild.value = List.from(Get.arguments[0]);
    listChildTemp.value = List.from(Get.arguments[0]);
    listParent.value = List.from(Get.arguments[1]);
    listParentTemp.value = List.from(Get.arguments[1]);
    listChoosen.value = Get.arguments[2];
    // for (var index = 0; index < Get.arguments[1].length; index++)
    //   expandParent[index] = false;
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
    isShowClearSearch.value = _searchValue.isNotEmpty;
    if (_searchValue != "") {
      _searchCity();
    } else {
      _showAllCity();
    }
  }

  void onSubmitSearch() {
    _searchCity();
  }

  void _showAllCity() {
    listParentTemp.clear();
    listChildTemp.clear();
    listParentTemp.addAll(List.from(listParent.value));
    listChildTemp.addAll(List.from(listChild.value));
  }

  void _searchCity() {
    listParentTemp.clear();
    listChildTemp.clear();
    var listConvert = List.from(listChild.value)
        .where((element) => element.description
            .toString()
            .toLowerCase()
            .contains(_searchValue.toLowerCase()))
        .toList();
    listChildTemp.addAll(listConvert);
    listConvert.forEach((element) {
      var indexPosition = listConvert.indexOf(element);
      if (indexPosition == 0 ||
          listConvert[indexPosition - 1].kategori != element.kategori) {
        listParentTemp.add(element.kategori);
      }
    });
  }

  void onClearSearch() {
    searchTextEditingController.text = "";
    addTextSearchCity("");
  }

  void onCheckParent(int index, bool value) {
    var getChild = List.from(listChild.value)
        .where((element) => element.kategori == listParentTemp[index])
        .toList();
    if (value) {
      getChild.forEach((element) {
        listChoosen[element.id] = element.description;
      });
    } else {
      listChoosen.removeWhere(
          (key, value) => getChild.any((element) => element.id == key));
    }
  }

  void onCheckAreaPickup(TransporterAreaPickupFilterModel child, bool value) {
    if (value) {
      listChoosen[child.id] = child.description;
    } else {
      listChoosen.removeWhere((key, value) => key == child.id);
    }
  }

  void onSubmit() {
    Get.back(result: Map.from(listChoosen.value));
  }

  void resetAll() {
    listChoosen.clear();
  }
}
