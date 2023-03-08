import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZoPromoTransporterFilterLocationController extends GetxController {
  final searchTextEditingController = TextEditingController().obs;
  final isShowClearSearch = false.obs;

  var listAllLocation = [].obs;
  var listSelectedLocation = [].obs;
  var listTempLocation = [].obs;
  var search = "".obs;

  var title = "".obs;
  var jenis = 0; //0 untuk kota, 1 untuk provinsi

  final scrollController = ScrollController();
  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.easeOut,
    );
  }

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
          "Initial": initialProvinsi(element["Description"]),
          "no_prefix_name": getNoPrefixNameProvinsi(element["Description"]),
        });
        listTempLocation.add({
          "ID": element["Code"].toString(),
          "Nama": element["Description"],
          "Initial": initialProvinsi(element["Description"]),
          "no_prefix_name": getNoPrefixNameProvinsi(element["Description"]),
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
            "Initial": initialProvinsi(element["Nama"]),
            "no_prefix_name": getNoPrefixNameProvinsi(element["Nama"]),
          });
        } else {
          listSelectedLocation.add({
            "ID": element["Code"].toString(),
            "Nama": element["Description"],
            "Initial": initialProvinsi(element["Description"]),
            "no_prefix_name": getNoPrefixNameProvinsi(element["Description"]),
          });
        }
      });
    } else {
      getLocation.forEach((element) {
        allLocation.add({
          "Nama": element,
          "Initial": initial(element),
          "no_prefix_name": getNoPrefixName(element),
        });
        listTempLocation.add({
          "Nama": element,
          "Initial": initial(element),
          "no_prefix_name": getNoPrefixName(element),
        });
      });
      allLocation.sort((a, b) {
        var result1 = '${a["Initial"]}'.compareTo('${b["Initial"]}');
        if (result1 != 0) return result1;
        var result2 =
            '${a['no_prefix_name']}'.compareTo('${b['no_prefix_name']}');
        if (result2 != 0) return result2;
        return '${a['Nama']}'
            .split(' ')[0]
            .compareTo('${b['Nama']}'.split(' ')[0]);
      });
      listAllLocation.value = allLocation;
      listTempLocation.value = allLocation;
      getSelectedLocation.forEach((element) {
        listSelectedLocation.add({
          "Nama": element,
          "Initial": initial(element),
          "no_prefix_name": getNoPrefixName(element),
        });
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

  String getNoPrefixName(String text) {
    return text.split(" ").length > 1
        ? text.split(" ").skip(1).join(" ")
        : text;
  }

  String initial(String text) {
    var getText = getNoPrefixName(text);
    return getText.substring(0, 1);
    // return "";
  }

  String getNoPrefixNameProvinsi(String text) {
    return jenis == 0 && text.split(" ").length > 1 ? text.split(" ")[0] : text;
  }

  String initialProvinsi(String text) {
    var getText = getNoPrefixNameProvinsi(text);

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
