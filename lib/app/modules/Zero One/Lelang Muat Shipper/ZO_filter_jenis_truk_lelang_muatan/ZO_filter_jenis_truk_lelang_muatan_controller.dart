import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZoFilterJenisTrukLelangMuatanController extends GetxController {
  final searchTextEditingController = TextEditingController().obs;
  final isShowClearSearch = false.obs;

  var listAllLocation = [].obs;
  var listSelectedLocation = [].obs;
  var listTempLocation = [].obs;
  var search = "".obs;

  var title = "".obs;
  var jenis = 0; //0 untuk kota, 1 untuk provinsi
  var nameimg = "".obs;

  @override
  void onInit() async {
    var getLocation = List.from(Get.arguments[0]);
    var getSelectedLocation = List.from(Get.arguments[1]);

    print("GAGAGA $getLocation");
    // jenis = Get.arguments[2];
    title.value = Get.arguments[2];
    var img = '';
    if (Get.arguments[2] ==
        "LelangMuatTabAktifTabAktifLabelTitleTruckType".tr) {
      img = 'ImageHead';
    } else {
      img = 'ImageCarrier';
    }
    nameimg.value = img;
    var allLocation = [];
    getLocation.forEach((element) {
      allLocation.add({
        "ID": element["ID"],
        "Description": element["Description"],
        img: element[img]
      });
      listTempLocation.add({"Description": element});
    });
    allLocation.sort((a, b) => a["Description"].compareTo(b["Description"]));
    listAllLocation.value = allLocation;
    listTempLocation.value = allLocation;
    getSelectedLocation.forEach((element) {
      listSelectedLocation.add(element);
    });
    super.onInit();
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
      listReturn.add(element);
    });
    Get.back(result: listReturn);
  }

  void onChange(String value) {
    search.value = value;
    isShowClearSearch.value = search.isNotEmpty;
    if (value.isEmpty) {
      listTempLocation.value = List.from(listAllLocation.value);
    } else {
      var searchList = List.from(listAllLocation)
          .where((element) => (element["Description"] as String)
              .toLowerCase()
              .contains(search.value.toLowerCase()))
          .toList();

      searchList.sort((a, b) => a["Description"].compareTo(b["Description"]));
      listTempLocation.value = searchList;
    }
  }
}
