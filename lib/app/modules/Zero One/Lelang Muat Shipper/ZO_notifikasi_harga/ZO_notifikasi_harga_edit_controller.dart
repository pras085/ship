import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/ZO_notifikasi_harga_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_controller.dart';

class ZoNotifikasiHargaEditController extends ZoNotifikasiHargaController {
  @override
  void onInit() {
    super.onInit();
    final params = Get.arguments;
    debugPrint(params.toString());
    final model = ZoNotifikasiHargaModel.fromParameters(params);
    debugPrint('$model');
    // if (model != null) {
    isEditPage.value = true;
    initFieldsForEdit(model);
    // }
  }
}
