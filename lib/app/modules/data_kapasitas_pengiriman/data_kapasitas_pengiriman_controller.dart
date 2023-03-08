import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/data_kapasitas_pengiriman/data_kapasitas_pengiriman_model.dart';
import 'package:muatmuat/app/modules/home/profile/profil_controller.dart';
import 'package:muatmuat/app/utils/response_state.dart';

class DataKapasitasPengirimanController extends GetxController {
  var dataKapasitas = ResponseState<DataKapasitasModel>().obs;
  ScrollController scrollController = ScrollController();
  final profilController = Get.find<ProfilController>();
  var bCategory = 0;
  String subject = "";

  // var kapasitas = 0.obs;
  // var file = [].obs;
  @override
  void onInit() async {
    super.onInit();
    fetchDataPicFromAPi();
    bCategory = profilController.userStatus.businessCategory;
    subject = bCategory == 1
        ? "Direktur"
        : bCategory == 2
            ? "Pengurus"
            : "-";
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void fetchDataPicFromAPi({isRefresh = true}) async {
    try {
      if (isRefresh) dataKapasitas.value = ResponseState.loading();
      final response = await ApiProfile(
        context: Get.context,
        isShowDialogLoading: false,
      ).getDataKapasitasPengirimanShipper({});
      if (response != null) {
        // convert json to object

        if (response['Message']['Code'] == 200) {
          // sukses
          dataKapasitas.value = ResponseState.complete(
            DataKapasitasModel.fromJson(response),
          );

          log("::: SuKESS");
        } else {
          // error
          if (response['Message']['Code'] != null && response['Message']['Code'] != 500) {
            throw (response['Data']);
          }
          throw (response['Data']);
        }
      } else {
        // error
        throw (response['Data']);
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
      dataKapasitas.value = ResponseState.error("$error");
    }
  }
}
