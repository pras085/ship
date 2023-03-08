import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class ManajemenMitraRequestCancelResponseModel {
  MessageFromUrlModel message;
  String messageSuccess = "";

  ManajemenMitraRequestCancelResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      try {
        messageSuccess = data['Message'];
      } catch (err) {}
    }
  }
}
