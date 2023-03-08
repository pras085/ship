import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZoFilterLelangMuatanController extends GetxController {
  final searchTextEditingController = TextEditingController().obs;
  final isShowClearSearch = false.obs;

  var listAllLocation = [].obs;
  var listSelectedLocation = [].obs;
  var listTempLocation = [].obs;
  var search = "".obs;

  var title = "".obs;
  var jenis = 0; //0 untuk kota, 1 untuk provinsi

  @override
  void onInit() async {
    var getLocation = List.from(Get.arguments[0]);
    var getSelectedLocation = List.from(Get.arguments[1]);
    title.value = Get.arguments[2];

    var allLocation = [];
    if (title.value == "LelangMuatTabAktifTabAktifLabelTitleProvince".tr) {
      getLocation.forEach((element) {
        allLocation.add({
          "ID": element["Code"].toString(),
          "Nama": element["Description"],
          "Initial": initialProvinsi(element["Description"])
        });
        listTempLocation.add({
          "ID": element["Code"].toString(),
          "Nama": element["Description"],
          "Initial": initialProvinsi(element["Description"])
        });
      });
      allLocation.sort((a, b) => a["Initial"].compareTo(b["Initial"]));
      listAllLocation.value = allLocation;
      listTempLocation.value = allLocation;
      getSelectedLocation.forEach((element) {
        if (element["Code"] == null) {
          listSelectedLocation.add({
            "ID": element["ID"].toString(),
            "Nama": element["Nama"],
            "Initial": initialProvinsi(element["Nama"])
          });
        } else {
          listSelectedLocation.add({
            "ID": element["Code"].toString(),
            "Nama": element["Description"],
            "Initial": initialProvinsi(element["Description"])
          });
        }
      });
    } else {
      getLocation.forEach((element) {
        allLocation.add({"Nama": element, "Initial": initial(element)});
        listTempLocation.add({"Nama": element, "Initial": initial(element)});
      });
      allLocation.sort((a, b) => a["Initial"].compareTo(b["Initial"]));
      listAllLocation.value = allLocation;
      listTempLocation.value = allLocation;
      getSelectedLocation.forEach((element) {
        listSelectedLocation
            .add({"Nama": element, "Initial": initial(element)});
      });
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  String initial(String text) {
    var getText = text.split(" ").length > 1 ? text.split(" ")[1] : text;
    return getText.substring(0, 1);
    // return "";
  }

  String initialProvinsi(String text) {
    var getText =
        jenis == 0 && text.split(" ").length > 1 ? text.split(" ")[0] : text;

    print("DASLFALFKA ${getText.substring(0, 1)}");
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
      if (title.value == "LelangMuatTabAktifTabAktifLabelTitleProvince".tr) {
        listReturn.add(element);
      } else {
        listReturn.add(element["Nama"]);
      }
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
          .where((element) => (element["Nama"] as String)
              .toLowerCase()
              .contains(search.value.toLowerCase()))
          .toList();
      searchList.sort((a, b) => a["Initial"].compareTo(b["Initial"]));
      listTempLocation.value = searchList;
    }
  }
}
