import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/metode_pembayaran.dart';

class CategoryMetodePembayaranModel {
  String categoryID;
  String paymentCategory;
  List<MetodePembayaranModel> content = [];

  CategoryMetodePembayaranModel(
      {this.categoryID, this.paymentCategory, this.content});

  CategoryMetodePembayaranModel.fromJson(Map<String, dynamic> json) {
    categoryID = json['CategoryID'].toString();
    paymentCategory = json['PaymentCategory'].toString();

    var data = json['Content'];
    try {
      content.addAll(data
          .map<MetodePembayaranModel>(
              (value) => MetodePembayaranModel.fromJson(value))
          .toList());
    } catch (err) {}
  }
}
