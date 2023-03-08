import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class VerifyEmailCheckStatusResponseModel {
  MessageFromUrlModel message;
  String verif;
  String verifId;
  String code;
  String type = "";

  VerifyEmailCheckStatusResponseModel({this.message});

  VerifyEmailCheckStatusResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    type = json['Type'] ?? "";
    var data = json['Data'];
    if (data != null) {
      verif = data['Verif'].toString();
      verifId = data['VerifID'].toString();
      code = (data['Code'] ?? "").toString();
    }
  }
}
