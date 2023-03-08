import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/user_model.dart';

class ForgotPasswordModel {
  MessageFromUrlModel message;
  UserModel data;
  String tokenApp = "";
  String dataMessageError = "";

  ForgotPasswordModel({this.message, this.data});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;

    if (json['Data'] != null) {
      try {
        data = UserModel.fromJson(json['Data'], true);
        tokenApp = json['Data']['TokenApp'];
      } catch (err) {
        data = null;
        dataMessageError = json['Data'];
      }
    }
  }
}
