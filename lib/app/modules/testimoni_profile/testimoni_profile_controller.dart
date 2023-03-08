import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/home/profile/profil_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:muatmuat/app/utils/response_state.dart';

import 'testimoni_profile_model.dart'; 

class TestimoniProfileController extends GetxController {

  final refreshController = RefreshController();
  var dataModelResponse = ResponseState<TestimoniProfileModel>().obs;
  var dataList = <Data>[].obs;
  final profilController = Get.find<ProfilController>();
  var search = "".obs;
  var searchResult = "";
  final searchController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
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
        'q': search.value,
        'Limit': "10",
        'Offset': "${dataList.length}",
      };
      // update text pencarian
      searchResult = search.value;
      final response = await ApiProfile(context: Get.context).getAllTestimonialShipperToTransporterTabShipper(body);
      if (response != null) {
        // convert json to object
        dataModelResponse.value = ResponseState.complete(TestimoniProfileModel.fromJson(response));
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
