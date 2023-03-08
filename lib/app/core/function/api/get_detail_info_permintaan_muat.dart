import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/detail_info_permintaan_muat_response_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/api_permintaan_muat.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';

class GetDetailInfoPermintaanMuat {
  static Future getDetail(String permintaanMuatID,
      {bool isShowDialogLoading = true}) async {
    var shipperID = await SharedPreferencesHelper.getUserShipperID();
    var responseBody = await ApiPermintaanMuat(
            context: Get.context, isShowDialogLoading: isShowDialogLoading)
        .detailPermintaanMuat(shipperID, permintaanMuatID);
    if (responseBody != null) {
      DetailInfoPermintaanMuatResponseModel response =
          DetailInfoPermintaanMuatResponseModel.fromJson(responseBody);
      return response;
    }
    return null;
  }
}
