import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class RegisterResponseModel {
  MessageFromUrlModel message;
  DataResponseRegister data;
  String messageReturn = "";
  String type = "";

  RegisterResponseModel({this.message});

  RegisterResponseModel.fromJson(
      Map<String, dynamic> json, bool updateDataUsersGoogle) {
    type = json['Type'] ?? "";
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    if (!updateDataUsersGoogle) {
      data = DataResponseRegister.fromJson(json['Data']);
      messageReturn = data.returns;
    } else
      messageReturn = json['Data'];
  }
}

class DataResponseRegister {
  String returns;
  String token;
  String docID;

  DataResponseRegister({this.returns, this.token});

  DataResponseRegister.fromJson(Map<String, dynamic> json) {
    returns = json['Return'] ?? "";
    token = json['Token'] ?? "";
    docID = (json['DocID'] ?? "").toString();
  }
}
