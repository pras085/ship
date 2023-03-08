import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/district_data_model.dart';

class DistrictResponseModel {
  MessageFromUrlModel message;
  List<DistrictDataModel> listData = [];
  DistrictResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      listData.addAll(data
          .map<DistrictDataModel>((value) => DistrictDataModel.fromJson(value))
          .toList());
    }
  }
}
