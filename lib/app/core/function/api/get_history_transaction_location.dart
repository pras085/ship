import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/history_transaction_location_info_permintaan_muat_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';

class GetHistoryTransactionLocation {
  static Future getLocation(String userID, {int limit}) async {
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getHistoryTransactLocation(userID);
    if (responseBody != null) {
      HistoryTransactionLocationInfoPermintaanMuatResponseModel response =
          HistoryTransactionLocationInfoPermintaanMuatResponseModel.fromJson(
              responseBody);
      return response;
    }
    return null;
  }
}
