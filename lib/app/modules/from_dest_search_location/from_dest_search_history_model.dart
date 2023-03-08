class FromDestSearchHistoryModel {
  String id;
  String address;
  String district;

  FromDestSearchHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json["ID"].toString();
    address = json["Address"];
    district = json["District"];
  }
}
