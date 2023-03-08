import 'package:get/get.dart';
import 'package:muatmuat/app/modules/user_type_information/user_type_information_get_data_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:open_appstore/open_appstore.dart';

import 'user_type_information_model.dart';

class UserTypeInformationController extends GetxController {
  final listData = [].obs;
  final listShow = [].obs;

  @override
  void onInit() {
    listData.addAll([
      UserTypeInformationModel(
          question: "Apa itu Pengirim Barang atau Pembeli?",
          answer:
              "Pengirim barang adalah pengirim fisik barang dari gudang ke tempat tujuan yang disesuaikan dengan dokumen pemesanan dan pengiriman serta dalam kondisi yang sesuai dengan persyaratan penanganan barangnya "),
      UserTypeInformationModel(
          question: "Apa itu Transporter?", answer: "Transporter adalah..."),
      UserTypeInformationModel(
          question: "Apa itu Penjual?", answer: "Penjual adalah..."),
      UserTypeInformationModel(
          question: "Apa itu Pencari Kerja?",
          answer: "Pencari kerja adalah..."),
    ]);
    listShow.addAll([false, false, false, false]);
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future getData() async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogError: true,
            isShowDialogLoading: true)
        .fetchGetDataUserTypeInformation();
    try {
      if (result != null) {
        UserTypeInformationGetDataResponseModel
            userTypeInformationGetDataResponseModel =
            UserTypeInformationGetDataResponseModel.fromJson(result);
        if (userTypeInformationGetDataResponseModel.message.code == 200) {
          if (userTypeInformationGetDataResponseModel.listData != null) {
            listData.addAll(userTypeInformationGetDataResponseModel.listData);
          }
        }
      }
    } catch (err) {}
  }
}
