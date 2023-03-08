import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/head_truck_model.dart';

class HeadTruckResponseModel {
  MessageFromUrlModel message;
  List<HeadTruckModel> listData = [];
  HeadTruckResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      listData.addAll(data
          .map<HeadTruckModel>((value) => HeadTruckModel.fromJson(value))
          .toList());
    }
  }
}
