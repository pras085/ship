import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZoListMuatanController extends GetxController {
  final searchTextEditingController = TextEditingController().obs;
  var title = "".obs;
  var listMuatan = [].obs;
  var listSelectedList = [].obs;
  var listTempList = [].obs;
  var search = "".obs;
  final isShowClearSearch = false.obs;

  @override
  void onInit() {
    title.value = Get.arguments[2];
    var getList = List.from(Get.arguments[0]);
    var getSelectList = List.from(Get.arguments[1]);
    var allList = [];
    getList.forEach((element) {
      allList.add(element);
      listTempList.add(element);
    });
    allList.sort((a, b) => a.compareTo(b));
    listMuatan.value = allList;
    listTempList.value = allList;
    getSelectList.forEach((element) {
      listSelectedList.add(element);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onReset() {
    listSelectedList.clear();
    // onChange("");
  }

  void onSave() {
    var listReturn = [];
    listSelectedList.value.forEach((element) {
      listReturn.add(element);
    });
    Get.back(result: listReturn);
  }

  void onChange(String value) {
    search.value = value;
    isShowClearSearch.value = search.isNotEmpty;
    if (value.isEmpty) {
      listTempList.value = List.from(listMuatan.value);
    } else {
      var searchList = List.from(listMuatan)
          .where((element) => (element as String)
              .toLowerCase()
              .contains(search.value.toLowerCase()))
          .toList();

      searchList.sort((a, b) => a.compareTo(b));
      listTempList.value = searchList;
    }
  }
}
