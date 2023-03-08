class ManajemenLokasiModel {
  String id;
  String name;
  String address;
  double latitude;
  double longitude;
  String province;
  String city;
  String district;
  String postalCode;
  String picName;
  String picNoTelp;

  ManajemenLokasiModel(
      {this.id,
      this.name,
      this.address,
      this.latitude,
      this.longitude,
      this.province,
      this.city,
      this.district,
      this.postalCode,
      this.picName,
      this.picNoTelp});

  ManajemenLokasiModel.fromJson(dynamic json, {String docIDParamName = "ID"}) {
    id = json[docIDParamName].toString();
    name = json["Name"];
    address = json["Address"];
    latitude = json["Latitude"] as double;
    longitude = json["Longitude"] as double;
    province = json["Province"];
    city = json["City"];
    district = json["District"];
    postalCode = json["PostalCode"];
    picName = json["PicName"];
    picNoTelp = json["PicNoTelp"];
  }

  Map toJson() {
    return {
      "ID": id,
      "Name": name,
      "Address": address,
      "Latitude": latitude.toString(),
      "Longitude": longitude.toString(),
      "Province": province,
      "City": city,
      "District": district,
      "PostalCode": postalCode,
      "PicName": picName,
      "PicNoTelp": picNoTelp
    };
  }
}
