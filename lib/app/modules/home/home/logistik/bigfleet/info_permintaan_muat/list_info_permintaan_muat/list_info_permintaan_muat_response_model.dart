import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_info_permintaan_muat/info_permintaan_muat_model.dart';

class ListInfoPermintaanMuatResponseModel {
  MessageFromUrlModel message;
  List<InfoPermintaanMuatModel> listPermintaanMuat = [];
  String realCountData = "0";

  ListInfoPermintaanMuatResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      try {
        listPermintaanMuat.addAll(data
            .map<InfoPermintaanMuatModel>(
                (value) => InfoPermintaanMuatModel.fromJson(value))
            .toList());
      } catch (err) {}
    }
    var supportingData = json['SupportingData'];
    if (supportingData != null) {
      try {
        realCountData = supportingData['RealCountData'].toString();
      } catch (err) {}
    }
  }
}
