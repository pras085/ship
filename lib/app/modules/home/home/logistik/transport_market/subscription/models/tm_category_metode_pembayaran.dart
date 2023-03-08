import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/models/tm_metode_pembayaran.dart';

class TMCategoryMetodePembayaranModel {
  String categoryID;
  String paymentCategory;
  List<TMMetodePembayaranModel> content = [];

  TMCategoryMetodePembayaranModel(
      {this.categoryID, this.paymentCategory, this.content});

  TMCategoryMetodePembayaranModel.fromJson(Map<String, dynamic> json) {
    categoryID = json['CategoryID'].toString();
    paymentCategory = json['PaymentCategory'].toString();

    var data = json['Content'];
    try {
      content.addAll(data
          .map<TMMetodePembayaranModel>(
              (value) => TMMetodePembayaranModel.fromJson(value))
          .toList());
    } catch (err) {}
  }
}
