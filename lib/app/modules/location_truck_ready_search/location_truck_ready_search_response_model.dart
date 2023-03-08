import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/transporter_location_truck_ready_model.dart';

class LocationTruckReadySearchResponseModel {
  MessageFromUrlModel message;
  List<TransporterLocationTruckReadyModel> listData = [];

  LocationTruckReadySearchResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      listData.addAll(data
          .map<TransporterLocationTruckReadyModel>(
              (value) => TransporterLocationTruckReadyModel.fromJson(value))
          .toList());
    }
  }
}
