import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class VerifyEmailResponseModel {
  MessageFromUrlModel message;
  bool isVerif;
  String docID;
  String messageError = "";
  String type = "";
  bool isForceStopVerify = false;

  VerifyEmailResponseModel({this.message});

  VerifyEmailResponseModel.fromJson(Map<String, dynamic> json) {
    print("json verify email: " + json.toString());
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    type = json['Type'] ?? "";
    isForceStopVerify = (type == "API_Verify_Stop" && message.code == 204);
    _setData(json['Data']);
  }

  _setData(Map<String, dynamic> json) {
    isVerif = json['Verif'] == 1;
    docID = (json['DocID'] ?? "") != "" ? json['DocID'].toString() : "";
    messageError = json['Return'] ?? "";
  }
}
