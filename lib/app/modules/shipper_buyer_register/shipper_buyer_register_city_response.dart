import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/city_model.dart';

class ShipperBuyerRegisterCityResponse {
  MessageFromUrlModel message;
  List<CityModel> listData = [];
  ShipperBuyerRegisterCityResponse.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      listData.addAll(
          data.map<CityModel>((value) => CityModel.fromJson(value)).toList());
    }
  }
}
