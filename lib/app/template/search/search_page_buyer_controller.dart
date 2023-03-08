import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/buyer/selected_location_controller.dart';
import 'package:muatmuat/app/template/select_location_buyer/select_location_buyer_model.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';

class SearchPageBuyerController extends GetxController {

  final locationController = Get.find<SelectedLocationController>();
  var search = "".obs;
  final searchController = TextEditingController();
  var locationResult = Rxn<SelectLocationBuyerModel>();
  var historyResponse = ResponseState<List>().obs;

  void fetchHistoryLocation() async {
    try {
      historyResponse.value = ResponseState.loading();
      // fetch data
      final local = await SharedPreferencesHelper.getHistorySearchBuyer();
      final localData = jsonDecode("${local ?? ''}");
      // sukses
      if (localData != null && localData is List) {
        historyResponse.value = ResponseState.complete(
          localData.map((e) => e).toList()
        );
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
      historyResponse.value = ResponseState.error("$error");
    }
  }

  Future saveToLocal(String strSearch) async {
    final value = await SharedPreferencesHelper.getHistorySearchBuyer();
    final resList = [];
    if (value != null && value != "") {
      final localData = jsonDecode("${value ?? ''}");
      if (localData is List) {
        if (localData.contains(strSearch)) {
          return;
        }
        final reverseLocalData = localData.reversed.toList();
        for (var i=0;i<reverseLocalData.length;i++) {
          resList.add(reverseLocalData[i]);
        }
      }
    }
    final model = {
      'id': resList.length,
      'name': strSearch,
    };
    final list = [
      model,
      ...resList,
    ];
    final stringJson = jsonEncode(list);
    await SharedPreferencesHelper.setHistorySearchBuyer(stringJson);
  }

  Future deleteByID(int id) async {
    final value = await SharedPreferencesHelper.getHistorySearchBuyer();
    if (value != null && value != "") {
      final localData = jsonDecode("${value ?? ''}");
      if (localData is List) {
        localData.removeWhere((el) => el['id'] == id);
        final stringJson = jsonEncode(localData);
        await SharedPreferencesHelper.setHistorySearchBuyer(stringJson);
      }
      historyResponse.value = ResponseState.complete(
        localData.map((e) => e).toList()
      );
    }
  }

  Future deleteAll() async {
    final value = await SharedPreferencesHelper.getHistorySearchBuyer();
    if (value != null && value != "") {
      final localData = jsonDecode("${value ?? ''}");
      if (localData is List) {
        localData.clear();
        final stringJson = jsonEncode(localData);
        await SharedPreferencesHelper.setHistorySearchBuyer(stringJson);
      }
      historyResponse.value = ResponseState.complete(
        localData.map((e) => e).toList()
      );
    }
  }

}
