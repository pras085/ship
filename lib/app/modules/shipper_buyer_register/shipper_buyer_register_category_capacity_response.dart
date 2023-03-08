import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/category_capacity_model.dart';

class ShipperBuyerRegisterCategoryCapacityResponse {
  MessageFromUrlModel message;
  List<CategoryCapacityModel> listData = [];
  ShipperBuyerRegisterCategoryCapacityResponse.fromJson(
      Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      listData.addAll(data
          .map<CategoryCapacityModel>(
              (value) => CategoryCapacityModel.fromJson(value))
          .toList());
    }
  }
}
