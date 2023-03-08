import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/home/home/logistik_new/testimoni/testimoni_model.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TestimoniController extends GetxController {

  final refreshController = RefreshController();
  var dataModelResponse = ResponseState<TestimoniModel>().obs;
  var dataList = <Data>[].obs;
  var selectedRating = "0".obs; // for selecting purposes
  var selectedRatingResult = "0".obs; // the result
  String transporterId = "";

  @override
  void onInit() async {
    super.onInit();
    // PENYESUAIAN PROFILE PENGGUNA LAIN
    transporterId = "102";
    fetchDataTestimoni();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
  }

  void fetchDataTestimoni({refresh = true}) async {
    try {
      if (refresh) {
        dataList.value = [];
        dataModelResponse.value = ResponseState.loading();
      }
      final body = {
        'Limit': "10",
        'Offset': "${dataList.length}",
        'TargetUserID': transporterId
      };
      if (selectedRatingResult.value != "0") body['FilterByRating'] = selectedRatingResult.value;
      final response = await ApiProfile(context: Get.context).getAllTestimonialShipperToTransporterTabTransporter(body);
      if (response != null) {
        // convert json to object
        dataModelResponse.value = ResponseState.complete(TestimoniModel.fromJson(response));
        if (refresh) {
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else if (dataModelResponse.value.data.data.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        if (dataModelResponse.value.data.message.code == 200) {
          // sukses
          dataList.value.addAll(dataModelResponse.value.data.data);
        } else {
          // error
          if (dataModelResponse.value.data.message != null && dataModelResponse.value.data.message.code == 200) {
            throw("${dataModelResponse.value.data.message.text}");
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
