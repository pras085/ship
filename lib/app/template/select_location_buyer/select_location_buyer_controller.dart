import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/buyer/api_buyer.dart';
import 'package:muatmuat/app/template/select_location_buyer/select_location_buyer_model.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';

class SelectLocationBuyerController extends GetxController {
  var searchvalue = "".obs;
  var dataModelResponse = ResponseState<List<SelectLocationBuyerModel>>().obs;
  var historyResponse = ResponseState<List<SelectLocationBuyerModel>>().obs;

  void fetchHistoryLocation() async {
    try {
      historyResponse.value = ResponseState.loading();
      // fetch data
      final local = await SharedPreferencesHelper.getHistoryPilihLokasiBuyer();
      final localData = jsonDecode("${local ?? ''}");
      // sukses
      if (localData != null && localData is List) {
        historyResponse.value = ResponseState.complete(
          localData.map((e) => SelectLocationBuyerModel.fromJson(e)).toList()
        );
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
      historyResponse.value = ResponseState.error("$error");
    }
  }

  void fetchLocation() async {
    try {
      dataModelResponse.value = ResponseState.loading();
      final response = await ApiBuyer(context: Get.context).getRegion({
        'q': searchvalue.value,
      });
      if (response != null) {
        // convert json to object
        if (response['Message']['Code'] == 200) {
          // sukses
          dataModelResponse.value = ResponseState.complete(
            (response['Data'] as Iterable).map((e) => SelectLocationBuyerModel.fromJson(e)).toList()
          );
        } else {
          // error
          if (response['Message'] != null && response['Message']['Text'] != null) {
            throw("${response['Message']['Text']}");
          }
          throw("failed to fetch data!");
        }
      } else {
        // error
        throw("failed to fetch data!");
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
      dataModelResponse.value = ResponseState.error("$error");
    }
  }
}
