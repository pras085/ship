import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/pembayaran_subscription/langkah_pembayaran_model.dart';

class TipeLangkahPembayaranModel {
  String code;
  List<LangkahPembayaranModel> content = [];

  TipeLangkahPembayaranModel({this.code, this.content});

  TipeLangkahPembayaranModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'].toString();

    var data = json['Content'];
    try {
      content.addAll(data
          .map<LangkahPembayaranModel>(
              (value) => LangkahPembayaranModel.fromJson(value))
          .toList());
    } catch (err) {}
  }
}
