import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class VerifyEmailResendResponseModel {
  MessageFromUrlModel message;
  String messageInsideData = "";
  String type = "";
  bool isForceStopVerify = false;

  VerifyEmailResendResponseModel({this.message});

  VerifyEmailResendResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    type = json['Type'] ?? "";
    var data = json['Data'];
    if (data != null) {
      try {
        messageInsideData = data['Return'];
      } catch (err) {
        messageInsideData = data;
      }
    }
    isForceStopVerify = (type == "API_Verify_Running" && message.code == 204);
  }
}
