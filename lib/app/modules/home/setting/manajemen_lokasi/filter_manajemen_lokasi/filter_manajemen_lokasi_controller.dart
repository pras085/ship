import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterManajemenLokasiController extends GetxController {
  final searchTextEditingController = TextEditingController().obs;
  final isShowClearSearch = false.obs;

  var listAllLocation = [].obs;
  var listSelectedLocation = [].obs;
  var listTempLocation = [].obs;
  var search = "".obs;

  var title = "Kota".obs;
  var jenis = 0; //0 untuk kota, 1 untuk provinsi

  @override
  void onInit() async {
    var getLocation = List.from(Get.arguments[0]);
    var getSelectedLocation = List.from(Get.arguments[1]);
    jenis = Get.arguments[2];
    title.value = jenis == 0 ? "Kota" : "Provinsi";
    var allLocation = [];
    getLocation.forEach((element) {
      allLocation.add({"Nama": element, "Initial": initial(element)});
      listTempLocation.add({"Nama": element, "Initial": initial(element)});
    });
    allLocation.sort((a, b) => a["Initial"].compareTo(b["Initial"]));
    listAllLocation.value = allLocation;
    listTempLocation.value = allLocation;
    getSelectedLocation.forEach((element) {
      listSelectedLocation.add({"Nama": element, "Initial": initial(element)});
    });

    // listAllLocation.value = List.from(Get.arguments[0]);
    // listTempLocation.value = List.from(Get.arguments[0]);
    // listSelectedLocation.value = List.from(Get.arguments[1]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  String initial(String text) {
    var getText =
        jenis == 0 && text.split(" ").length > 1 ? text.split(" ")[1] : text;
    return getText.substring(0, 1);
    // return "";
  }

  void onReset() {
    listSelectedLocation.clear();
    onChange("");
  }

  void onSave() {
    var listReturn = [];
    listSelectedLocation.value.forEach((element) {
      listReturn.add(element["Nama"]);
    });
    Get.back(result: listReturn);
  }

  void onChange(String value) {
    search.value = value;
    if (value.isEmpty) {
      listTempLocation.value = List.from(listAllLocation.value);
    } else {
      var searchList = List.from(listAllLocation)
          .where((element) => (element["Nama"] as String)
              .toLowerCase()
              .contains(search.value.toLowerCase()))
          .toList();
      searchList.sort((a, b) => a["Initial"].compareTo(b["Initial"]));
      listTempLocation.value = searchList;
    }
  }
}
