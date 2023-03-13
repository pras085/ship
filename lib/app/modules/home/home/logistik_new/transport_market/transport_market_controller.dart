import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/cek_sub_user_dan_hak_akses.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/network/api_helper.dart' as apiInternal;
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class TransportMarketController extends GetxController {
  final List<String> imgList = [];
  var imageSliders = [].obs;
  final indexImageSlider = 0.obs;
  var loading = true.obs;
  var newNotif = false.obs;

  var hasAccessLihatSubscription = true.obs;

  @override
  void onInit() async {
    super.onInit();
    getInit();

    hasAccessLihatSubscription.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "612", showDialog: false);

    hasAccessLihatSubscription.value = false;
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future<void> getInit() async {
    loading.value = true;
    await getNotif();
    await getDataCarousel();
    loading.value = false;
    imageSliders.value = imgList.map((item) => ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
      ),
      child: Stack(
        children: <Widget>[
          Image.network(
            item,
            fit: BoxFit.cover,
            width: MediaQuery.of(Get.context).size.width,
          ),
        ],
      )
    )).toList();
  }

  Future getNotif() async {
    var result = await apiInternal.ApiHelper(
      context: Get.context,
      isShowDialogLoading: false,
      isShowDialogError: false
    ).getListNotifAll();

    if (result['Message']['Code'].toString() == '200') {
      newNotif.value = result['SupportingData']['NotReadCount'] > 0;
    }
  }

  Future getDataCarousel() async {
    loading.value = true;
    var result = await ApiHelper(
      context: Get.context,
      isShowDialogLoading: false,
      isShowDialogError: false
    ).getDataCarousel();

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      for (int i = 0; i < data.length; i++) {
        imgList.add(data[i]["Image"]);
      }
    }
    loading.value = false;
  }
}
