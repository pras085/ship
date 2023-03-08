import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/pembayaran_subscription/tipe_step_pembayaran_model.dart';

class PembayaranSubscriptionResponseModel {
  MessageFromUrlModel message;
  List<TipeLangkahPembayaranModel> listTipeLangkahPembayaran = [];

  PembayaranSubscriptionResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      try {
        listTipeLangkahPembayaran.addAll(data
            .map<TipeLangkahPembayaranModel>(
                (value) => TipeLangkahPembayaranModel.fromJson(value))
            .toList());
      } catch (err) {}
    }
  }
}
