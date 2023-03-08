import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_get_count_model.dart';

class ManajemenMitraGetCountResponseModel {
  MessageFromUrlModel message;
  String numberRequest = "";
  String numberApprove = "";
  List<ManajemenMitraGetCountModel> _listData = [];

  ManajemenMitraGetCountResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      _listData.addAll(data
          .map<ManajemenMitraGetCountModel>(
              (value) => ManajemenMitraGetCountModel.fromJson(value))
          .toList());
      for (ManajemenMitraGetCountModel data in _listData) {
        if (data.label == "ToTransporter") {
          numberRequest = data.request;
        } else {
          numberApprove = data.request;
        }
      }
    }
  }
}
