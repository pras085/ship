import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/network/api_helper.dart';

class ChooseBusinessFieldController extends GetxController {
  var businessIdKey = 'ID';
  var businessCodeKey = 'Code';
  var businessDesc = 'Description';

  var businessFields = [].obs;
  var businessFieldsTemp = [].obs;
  var searchController = TextEditingController();
  var text = "".obs;

  @override
  void onInit() async {
    searchController.text = Get.arguments;
    text.value = Get.arguments;
    var result = await ApiHelper(context: Get.context, isShowDialogLoading: false).fetchBusinessField();
    businessFields.value = result['Data'];
    businessFieldsTemp.value = result['Data'];
    search(search: text.value ?? "");
    super.onInit();
  }

  Future search({String search = ""}) async {
    text.value = search;
    print("TES: $search");
    businessFieldsTemp.value = search.isEmpty ? businessFields : businessFields.where((e) => e[businessDesc].toString().toLowerCase().contains(search.toLowerCase())).toList();
  }

  void onTap({int businessId, String businessCode, String businessDesc}) {
    Get.back(result: {'id': businessId, 'code': businessCode, 'name': businessDesc});
  }
}