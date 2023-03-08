import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class DetailProfileShipperResponseModel {
  MessageFromUrlModel message;
  //String messageData = "";

  DetailProfileShipperResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
  }
}
