import 'package:muatmuat/app/core/models/history_transaction_location_info_permintaan_muat_model.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class HistoryTransactionLocationInfoPermintaanMuatResponseModel {
  MessageFromUrlModel message;
  List<HistoryTransactionLocationInfoPermintaanMuatModel> listData = [];

  HistoryTransactionLocationInfoPermintaanMuatResponseModel.fromJson(
      Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      listData.addAll(data
          .map<HistoryTransactionLocationInfoPermintaanMuatModel>((value) =>
              HistoryTransactionLocationInfoPermintaanMuatModel.fromJson(value))
          .toList());
    }
  }
}
