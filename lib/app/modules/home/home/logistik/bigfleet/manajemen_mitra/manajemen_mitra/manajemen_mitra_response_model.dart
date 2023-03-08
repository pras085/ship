import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/mitra_model.dart';

class ManajemenMitraResponseModel {
  MessageFromUrlModel message;
  List<MitraModel> listMitra = [];
  String realCountData = "0";

  ManajemenMitraResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      try {
        listMitra.addAll(data
            .map<MitraModel>((value) => MitraModel.fromJson(value))
            .toList());
      } catch (err) {}
    }
    var supportingData = json['SupportingData'];
    if (supportingData != null) {
      try {
        realCountData = supportingData['RealCountData'].toString();
      } catch (err) {}
    }
  }
}
