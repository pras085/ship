import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/user_model.dart';

class UploadPictureModel {
  MessageFromUrlModel message;
  UserModel data;
  String tokenApp = "";
  String dataMessageError = "";

  UploadPictureModel({this.message, this.data});

  UploadPictureModel.fromJson(Map<String, dynamic> json) {
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
