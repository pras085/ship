import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/business_entity_model.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/business_field_model.dart';

class ShipperBuyerRegisterBusinessFieldResponse {
  MessageFromUrlModel message;
  List<BusinessFieldModel> listData = [];
  ShipperBuyerRegisterBusinessFieldResponse.fromJson(
      Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      listData.addAll(data
          .map<BusinessFieldModel>(
              (value) => BusinessFieldModel.fromJson(value))
          .toList());
    }
  }
}
