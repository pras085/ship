import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/lokasi_truk_siap_muat/lokasi_truk_siap_muat_get_count_model.dart';

class LokasiTrukSiapMuatGetCountResponseModel {
  MessageFromUrlModel message;
  LokasiTrukSiapMuatGetCountModel _data;
  String count = "0";

  LokasiTrukSiapMuatGetCountResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    _data = LokasiTrukSiapMuatGetCountModel.fromJson(data);
    count = _data.count;
  }
}
