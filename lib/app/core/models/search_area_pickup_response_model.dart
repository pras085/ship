import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/search_area_pickup_filter_model.dart';

class SearchAreaPickupFilteResponseModel {
  MessageFromUrlModel message;
  List<SearchAreaPickupFilterModel> listData = [];
  List<SearchAreaPickupFilterModel> listDataFull = [];
  int maxTruk;
  SearchAreaPickupFilterModel firstDistrict;
  SearchAreaPickupFilterModel kota;
  SearchAreaPickupFilteResponseModel.fromJson(
      // Map<String, dynamic> json) {(
      Map<String, dynamic> json,
      String kecamatan) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    // var dataFull = json['Data']['dataFull'];
    var dataLimit = json['Data']['dataLimit'];
    // List<SearchAreaPickupFilterModel> getDataFull = [];
    var dataFull = json['Data']['dataFull'];
    if (dataFull != null && kecamatan.isNotEmpty) {
      var getFull = dataFull
          .map<SearchAreaPickupFilterModel>(
              (value) => SearchAreaPickupFilterModel.fromJson(value))
          .toList();
      var filterKecamatan = kecamatan.toLowerCase();
      filterKecamatan = filterKecamatan.replaceAll("kecamatan ", "");
      filterKecamatan = filterKecamatan.replaceAll("kec. ", "");
      try {
        firstDistrict = getFull.firstWhere((element) =>
            element.description
                .toLowerCase()
                .contains(filterKecamatan.toLowerCase()) ||
            filterKecamatan
                .toLowerCase()
                .contains(element.description.toLowerCase()));
      } catch (error) {
        print(error.toString());
      }
    }
    if (dataLimit != null) {
      var dataKota = (dataLimit as List)
          .where((element) => element["id"].toString().length == 4)
          // element["name"].toString().toLowerCase().contains("kota") ||
          // element["name"].toString().toLowerCase().contains("kab.") ||
          // element["name"].toString().toLowerCase().contains("kabupaten"))
          .toList()[0];
      kota = SearchAreaPickupFilterModel(
          id: dataKota["id"].toString(), description: dataKota["name"]);
      listDataFull.add(kota);
    }
    var first = true;
    if (dataFull != null) {
      var getFull = dataFull
          .map<SearchAreaPickupFilterModel>(
              (value) => SearchAreaPickupFilterModel.fromJson(value))
          .toList();
      (getFull as List).forEach((element) {
        if (first && firstDistrict != null) {
          listData.add(firstDistrict);
        }
        if (first) {
          listData.add(kota);
          first = false;
        }
        if (kecamatan.isEmpty || firstDistrict == null) {
          listData.add(element);
        } else if (firstDistrict != null) {
          if (element.id != firstDistrict.id) listData.add(element);
        }
      });
      listDataFull.addAll(getFull);
    }
    var dataMaxTruk = json['Data']['maxTruk'];
    if (dataMaxTruk != null) {
      maxTruk = dataMaxTruk;
    }
  }
}
