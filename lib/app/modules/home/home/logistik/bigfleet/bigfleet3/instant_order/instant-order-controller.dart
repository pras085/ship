import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/cek_sub_user_dan_hak_akses.dart';

class InstantOrderController extends GetxController {
  var lokasiTrukAkses = true.obs;
  var infoPermintaanAkses = true.obs;
  var directOrderAkses = true.obs;
  var loading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    loading.value = true;
    await cekRole();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return loading.value = false;
    });
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future<void> cekRole() async {
    lokasiTrukAkses.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(
      context: Get.context,
      menuId: "669",
      showDialog: false,
    );
    infoPermintaanAkses.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(
      context: Get.context,
      menuId: "611",
      showDialog: false,
    );
    // directOrderAkses.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(
    //   context: Get.context,
    //   menuId: "611",
    //   showDialog: false,
    // );
  }
}
