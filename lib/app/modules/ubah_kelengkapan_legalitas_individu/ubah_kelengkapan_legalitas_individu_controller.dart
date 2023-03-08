import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/utils/response_state.dart';

class UbahKelengkapanLegalitasIndividuController extends GetxController {

  var dataModelResponse = ResponseState().obs;

  @override
  void onInit() async {
    super.onInit();
    fetchDataLegalitas();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
  }

  void fetchDataLegalitas({isRefresh = true}) async {
    try {
      if (isRefresh) dataModelResponse.value = ResponseState.loading();
      final response = await ApiProfile(context: Get.context).getDataKelengkapanLegalitasIndividu({});
      if (response != null) {
        // convert json to object
        if (response['Message']['Code'] == 200) {
          // sukses
          dataModelResponse.value = ResponseState.complete(response);
        } else {
          // error
          if (response['Message']['Code'] != null && response['Message']['Code'] == 200) {
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
