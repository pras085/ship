import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class DetailInfoPermintaanMuatResponseModel {
  MessageFromUrlModel message;
  var data;
  DetailInfoPermintaanMuatResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    data = json['Data'];
  }
}
