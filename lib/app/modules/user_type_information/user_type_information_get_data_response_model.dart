import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class UserTypeInformationGetDataResponseModel {
  MessageFromUrlModel message;
  var listData;
  // String shipperID = "";

  UserTypeInformationGetDataResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    Map<String, dynamic> data = json['Data'];
    if (data != null) {
      listData = null;
      // shipperID = data['ShipperID'].toString();
    }
  }
}
