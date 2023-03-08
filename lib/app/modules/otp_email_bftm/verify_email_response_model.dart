import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class VerifyEmailResponseModel {
  MessageFromUrlModel message;
  String type = "";
  int countdown;

  VerifyEmailResponseModel({this.message});

  VerifyEmailResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    type = json['Type'] ?? "";
    var data = json['Data'];
    try {
      if (data != null) {
        countdown = int.parse(data['EndTime'].toString()) -
            int.parse(data['Now'].toString());
      }
      print(data);
      print(countdown);
    } catch (err) {}
  }
}
