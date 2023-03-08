import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class ShipperBuyerRegisterResponseModel {
  MessageFromUrlModel message;
  String messaggeResponse = "";
  String shipperID = "0";
  ShipperBuyerRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    if (json['Data'] != null) {
      messaggeResponse = json['Data']['Message'];
      shipperID = json['Data']['ShipperID'].toString();
    }
  }
}
