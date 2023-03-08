import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class ResetPasswordResponseModel {
  MessageFromUrlModel message;
  String data;


  ResetPasswordResponseModel({this.message});

  ResetPasswordResponseModel.fromJson(Map<String, dynamic> json){
    message = json['Message'] != null ? MessageFromUrlModel.fromJson(json['Message']) : null;    
    data = json['Data'];
  }
}