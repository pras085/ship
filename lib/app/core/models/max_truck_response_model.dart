import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/carrier_truck_model.dart';

class MaxTruckResponseModel {
  MessageFromUrlModel message;
  double maxData = 0;
  MaxTruckResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      maxData = (data["Max"]).toDouble();
    }
  }
}
