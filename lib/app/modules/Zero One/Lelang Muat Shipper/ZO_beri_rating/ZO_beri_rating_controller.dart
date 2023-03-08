import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/custom_toast_zo.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/api_helper_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoBeriRatingController extends GetxController {
  String loginASval;
  int bidId;
  int transporterId;
  String transporterName;
  int truckOffer;
  RxInt rating;
  TextEditingController qualityController;
  TextEditingController priceController;
  RxBool isQualityErrorVisible;
  RxBool isPriceErrorVisible;
  RxBool isSubmittedOnce;
  RxBool isLoading;

  bool _isTextValid(String text) => text.isNotEmpty;

  bool _shouldShowError(String text) =>
      isSubmittedOnce.isTrue && !_isTextValid(text);

  bool _isValid() =>
      _isTextValid(qualityController.text) &&
      _isTextValid(priceController.text) &&
      rating.value > 0;

  void onRatingChanged(int newRating) => rating.value = newRating;

  void onSubmitted() async {
    if (isSubmittedOnce.isFalse) {
      isSubmittedOnce.value = true;
      if (!_isTextValid(qualityController.text)) {
        isQualityErrorVisible.value = true;
      }
      if (!_isTextValid(priceController.text)) {
        isPriceErrorVisible.value = true;
      }
    }
    if (_isValid()) {
      FocusManager.instance.primaryFocus.unfocus();

      isLoading.value = true;

      MessageFromUrlModel messageModel = await ApiHelper(
        context: Get.context,
        isShowDialogError: true,
        isShowDialogLoading: true,
      ).postReviewTransporter(
        bidId: bidId,
        transporterId: transporterId,
        loginAs: loginASval,
        quality: qualityController.text,
        price: priceController.text,
        score: rating.value,
      );

      isLoading.value = false;

      print(messageModel.code.toString());
      print(messageModel.text.toString());
      if (messageModel.code == 200) {
        Get.back(result: true);
        CustomToast.show(
          context: Get.context,
          sizeRounded: 6,
          message:
              "LelangMuatPesertaLelangPesertaLelangLabelTitleBerhasilBeriNilaiTransporter"
                  .tr,
        );
      } else {
        GlobalAlertDialog.showAlertDialogCustom(
          context: Get.context,
          message: messageModel.text,
          labelButtonPriority1: "Oke",
          labelButtonPriority2: "",
          onTapPriority1: () {},
          onTapPriority2: () {},
          onTapCloseButton: () {},
          title: "",
        );
      }
    } else {
      if (rating.value < 1) {
        GlobalAlertDialog.showAlertDialogCustom(
          context: Get.context,
          message: "Anda belum memberikan penilaian kepada Transporter".tr,
          labelButtonPriority1: "Oke",
          labelButtonPriority2: "",
          onTapPriority1: () {},
          onTapPriority2: () {},
          onTapCloseButton: () {},
          title: "",
        );
      }
    }
  }

  @override
  void onInit() {
    isLoading = false.obs;
    loginASval = Get.arguments['loginAS'];
    bidId = int.tryParse(Get.parameters['bidId']);
    transporterId = int.tryParse(Get.parameters['transporterId']);
    transporterName = Get.arguments['transporter_name'].toString();
    truckOffer = Get.arguments['truck_offer'] as int;
    rating = 0.obs;
    qualityController = TextEditingController()
      ..addListener(() {
        isQualityErrorVisible.value = _shouldShowError(qualityController.text);
      });
    priceController = TextEditingController()
      ..addListener(() {
        isPriceErrorVisible.value = _shouldShowError(priceController.text);
      });
    isQualityErrorVisible = false.obs;
    isPriceErrorVisible = false.obs;
    isSubmittedOnce = false.obs;
    super.onInit();
  }

  @override
  void onClose() {
    qualityController.dispose();
    priceController.dispose();
    super.onClose();
  }
}
