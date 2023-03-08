import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/province_model.dart';

class ShipperBuyerRegisterProvinceResponse {
  MessageFromUrlModel message;
  List<ProvinceModel> listData = [];
  ShipperBuyerRegisterProvinceResponse.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      listData.addAll(data
          .map<ProvinceModel>((value) => ProvinceModel.fromJson(value))
          .toList());
    }
  }
}
