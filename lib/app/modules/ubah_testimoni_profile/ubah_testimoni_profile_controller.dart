import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/home/profile/profil_controller.dart';
import 'package:muatmuat/app/modules/testimoni_profile/testimoni_profile_model.dart';

class UbahTestimoniProfileController extends GetxController {

  Data argument;
  final profilController = Get.find<ProfilController>();

  final contentController = TextEditingController();
  var data = Data().obs; // contains data to be save

  @override
  void onInit() async {
    super.onInit();
    argument = Get.arguments as Data;
    data.value = argument;
    contentController.text = argument.content;
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
  }

  bool get isValid {
    return (data.value.rate != argument.rate || data.value.content != argument.content) && data.value.content.trim().isNotEmpty;
  }

  void onSaved() async {
    final body = {
      'TestimoniID': '${argument.iD}',
      'Rate': '${data.value.rate}',
      'Content': '${data.value.content}',
    };
    ApiProfile(
      context: Get.context,
      isShowDialogLoading: true,
      isShowDialogError: true,
    ).doUpdateTestimonialShipperToTransporter(body)
    .then((value) => Get.back(result: true,));
  }

}
