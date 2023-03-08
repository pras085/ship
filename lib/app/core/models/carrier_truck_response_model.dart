import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/carrier_truck_model.dart';

class CarrierTruckResponseModel {
  MessageFromUrlModel message;
  List<CarrierTruckModel> listData = [];
  CarrierTruckResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      listData.addAll(data
          .map<CarrierTruckModel>((value) => CarrierTruckModel.fromJson(value))
          .toList());
    }
  }
}
