import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/detail_manajemen_lokasi_model.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class DetailManajemenLokasiResponseModel {
  MessageFromUrlModel message;
  DetailManajemenLokasiModel detailManajemenLokasiModel;
  DetailManajemenLokasiResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      detailManajemenLokasiModel = DetailManajemenLokasiModel.fromJson(data);
    }
  }
}
