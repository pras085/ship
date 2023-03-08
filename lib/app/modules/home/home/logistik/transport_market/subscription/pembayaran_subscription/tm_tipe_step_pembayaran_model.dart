import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/pembayaran_subscription/tm_langkah_pembayaran_model.dart';

class TMTipeLangkahPembayaranModel {
  String code;
  List<TMLangkahPembayaranModel> content = [];

  TMTipeLangkahPembayaranModel({this.code, this.content});

  TMTipeLangkahPembayaranModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'].toString();

    var data = json['Content'];
    try {
      content.addAll(data
          .map<TMLangkahPembayaranModel>(
              (value) => TMLangkahPembayaranModel.fromJson(value))
          .toList());
    } catch (err) {}
  }
}
