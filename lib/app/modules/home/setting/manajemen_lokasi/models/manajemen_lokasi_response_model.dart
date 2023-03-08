import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/manajemen_lokasi_model.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class ManajemenLokasiResponseModel {
  MessageFromUrlModel message;
  List<ManajemenLokasiModel> listData = [];
  ManajemenLokasiResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      listData.addAll(data
          .map<ManajemenLokasiModel>(
              (value) => ManajemenLokasiModel.fromJson(value))
          .toList());
    }
  }
}
