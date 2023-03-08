import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class ChooseUserTypeCheckUserResponseModel {
  MessageFromUrlModel message;
  String shipperID = "";

  ChooseUserTypeCheckUserResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    Map<String, dynamic> data = json['Data'];
    if (data != null) {
      shipperID = data['ShipperID'].toString();
    }
  }
}
