import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class CheckValidRefferalResponseModel {
  MessageFromUrlModel message;
  String data = "";
  String type = "";

  CheckValidRefferalResponseModel();

  CheckValidRefferalResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    data = json['Data'].toString() ?? "";
    type = json['Type'];
  }
}
