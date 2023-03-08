class LocationManagementModel {
  String id;
  String name;
  String address;
  String district;

  LocationManagementModel.fromJson(Map<String, dynamic> data) {
    id = data["ID"].toString();
    name = data["Name"];
    address = data["Address"];
    district = data["District"];
  }
}
