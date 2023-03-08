import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/transporter_area_pickup_filter_model.dart';

class TransporterAreaPickupFilteResponseModel {
  MessageFromUrlModel message;
  List<TransporterAreaPickupFilterModel> listDataFront = [];
  List<TransporterAreaPickupFilterModel> listDataFull = [];
  TransporterAreaPickupFilteResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    try {
      var dataFront = json['Data']['partDataPickup'];
      if (dataFront != null) {
        (dataFront as List).forEach((element) {
          var listKategori = element["kategori"].toString().split(" ");
          var kategori = "";
          listKategori.forEach((element) {
            if (listKategori.indexOf(element) != 0) kategori += " ";
            kategori += "${element[0].toUpperCase()}${element.substring(1)}";
          });
          (element["listKotaKecamatan"] as List).forEach((elementInside) {
            listDataFront.add(TransporterAreaPickupFilterModel.fromJson(
                kategori, elementInside));
          });
        });
      }
      var dataFull = json['Data']['fullDataPickup'];
      if (dataFull != null) {
        (dataFull as Map).values.forEach((element) {
          (element["data"] as List).forEach((elementData) {
            var listKategori = elementData["kategori"].toString().split(" ");
            var kategori = "";
            listKategori.forEach((element) {
              if (listKategori.indexOf(element) != 0) kategori += " ";
              kategori += "${element[0].toUpperCase()}${element.substring(1)}";
            });
            (elementData["listKotaKecamatan"] as List).forEach((elementInside) {
              listDataFull.add(TransporterAreaPickupFilterModel.fromJson(
                  kategori, elementInside));
            });
          });
        });
      }
    } catch (err) {
      print("error TransporterAreaPickupFilteResponseModel: " + err.toString());
    }
  }
}
