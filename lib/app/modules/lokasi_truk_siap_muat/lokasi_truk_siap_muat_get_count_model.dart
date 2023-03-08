class LokasiTrukSiapMuatGetCountModel {
  String count;

  LokasiTrukSiapMuatGetCountModel.fromJson(Map<String, dynamic> json) {
    count = json != null ? json['TotalTruk'].toString() : "0";
  }
}
