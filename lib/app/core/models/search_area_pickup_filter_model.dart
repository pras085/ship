class SearchAreaPickupFilterModel {
  String keyDescription;
  String id;
  String description;

  SearchAreaPickupFilterModel({this.keyDescription = "", this.id, this.description});

  SearchAreaPickupFilterModel.fromJson(Map<String, dynamic> data) {
    keyDescription = data['key'].toString();
    id = data['data'][0]["id"].toString();
    description = data['data'][0]["name"].toString();
  }
}
