import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class VerifyEmailChangeEmailResponseModel {
  MessageFromUrlModel message;
  String data;
  String type = "";

  VerifyEmailChangeEmailResponseModel({this.message});

  VerifyEmailChangeEmailResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    type = json['Type'] ?? "";
    data = json['Data'];
  }
}
