class CityModel {
  int code;
  String city;

  CityModel(this.code, this.city);

  CityModel.fromJson(Map<String, dynamic> map) {
    code = map['ID'];
    city = map['City'];
  }
}
