import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class CheckDuplicateAccountResponseModel {
  MessageFromUrlModel message;
  String data = "";
  String type = "";

  CheckDuplicateAccountResponseModel();

  CheckDuplicateAccountResponseModel.fromJson(Map<String, dynamic> json){
    message = json['Message'] != null ? MessageFromUrlModel.fromJson(json['Message']) : null;    
    data = json['Data'] ?? "";
    type = json['Type'];
  }
}