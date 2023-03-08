import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/pembayaran_subscription/tm_tipe_step_pembayaran_model.dart';

class TMPembayaranSubscriptionResponseModel {
  MessageFromUrlModel message;
  List<TMTipeLangkahPembayaranModel> listTipeLangkahPembayaran = [];

  TMPembayaranSubscriptionResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      try {
        listTipeLangkahPembayaran.addAll(data
            .map<TMTipeLangkahPembayaranModel>(
                (value) => TMTipeLangkahPembayaranModel.fromJson(value))
            .toList());
      } catch (err) {}
    }
  }
}
