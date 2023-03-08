import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/category_metode_pembayaran.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class SubscriptionPilihMetodePembayaranResponseModel {
  MessageFromUrlModel message;
  List<CategoryMetodePembayaranModel> listCategoryMetodePembayaran = [];

  SubscriptionPilihMetodePembayaranResponseModel.fromJson(
      Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      try {
        listCategoryMetodePembayaran.addAll(data
            .map<CategoryMetodePembayaranModel>(
                (value) => CategoryMetodePembayaranModel.fromJson(value))
            .toList());
      } catch (err) {}
    }
  }
}
