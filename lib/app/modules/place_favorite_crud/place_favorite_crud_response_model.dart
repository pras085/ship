import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class PlaceFavoriteCRUDResponseModel {
  MessageFromUrlModel message;
  String docID = "";
  String messageResult = "";

  PlaceFavoriteCRUDResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      docID = data['DocID'].toString();
      messageResult = data['Message'];
    }
  }
}
