class HistoryTransactionLocationInfoPermintaanMuatModel {
  String id;
  String address;
  String district;
  HistoryTransactionLocationInfoPermintaanMuatModel({
    this.id,
    this.address,
    this.district,
  });

  HistoryTransactionLocationInfoPermintaanMuatModel.fromJson(dynamic json) {
    id = json["ID"].toString();
    address = json["Address"];
    district = json["District"];
  }
}
