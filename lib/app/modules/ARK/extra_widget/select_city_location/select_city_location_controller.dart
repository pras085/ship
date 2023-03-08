import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class SelectCityLocationController extends GetxController {
  final listKotaKabupaten = [].obs;

  final searchTextEditingController = TextEditingController().obs;
  final isShowClearSearch = false.obs;
  var isLoading = false.obs;

  var hintText = "".obs;

  @override
  void onInit() {
    super.onInit(); // Cari Nama Kota/Kabupaten
    hintText.value = Get.arguments[0];
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void getData() async {
    isLoading.value = true;
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchSearchCity(searchTextEditingController.value.text);

    if (result['Message']['Code'].toString() == '200') {
      listKotaKabupaten.clear();
      var data = result['Data'];
      print(data);
      (data as List).forEach((element) {
        listKotaKabupaten.add({
          'idKota': element['CityID'].toString(),
          'namaKota': element['City'],
        });
      });
      listKotaKabupaten.refresh();
      print(listKotaKabupaten);
      isLoading.value = false;
    }
  }

  void search(value) {
    searchTextEditingController.refresh();
    if (value != "") {
      isShowClearSearch.value = true;
    } else {
      isShowClearSearch.value = false;
    }
    getData();
  }

  void onClearSearch() {
    searchTextEditingController.value.text = "";
    searchTextEditingController.refresh();
    getData();
  }
}
