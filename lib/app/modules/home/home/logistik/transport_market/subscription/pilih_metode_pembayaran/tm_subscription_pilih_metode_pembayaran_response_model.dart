import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/models/tm_category_metode_pembayaran.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class TMSubscriptionPilihMetodePembayaranResponseModel {
  MessageFromUrlModel message;
  List<TMCategoryMetodePembayaranModel> listCategoryMetodePembayaran = [];

  TMSubscriptionPilihMetodePembayaranResponseModel.fromJson(
      Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      try {
        listCategoryMetodePembayaran.addAll(data
            .map<TMCategoryMetodePembayaranModel>(
                (value) => TMCategoryMetodePembayaranModel.fromJson(value))
            .toList());
      } catch (err) {}
    }
  }
}
