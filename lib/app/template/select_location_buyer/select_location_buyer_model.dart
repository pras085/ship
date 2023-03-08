class SelectLocationBuyerModel {
  int kind;
  int provinceID;
  String province;
  int cityID;
  String city;
  int districtID;
  String description;

  SelectLocationBuyerModel(
      {this.kind,
      this.provinceID,
      this.province,
      this.cityID,
      this.city,
      this.districtID,
      this.description});

  SelectLocationBuyerModel.fromJson(Map<String, dynamic> json) {
    kind = json['Kind'];
    provinceID = json['ProvinceID'];
    province = json['Province'];
    cityID = json['CityID'];
    city = json['City'];
    districtID = json['DistrictID'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Kind'] = this.kind;
    data['ProvinceID'] = this.provinceID;
    data['Province'] = this.province;
    data['CityID'] = this.cityID;
    data['City'] = this.city;
    data['DistrictID'] = this.districtID;
    data['Description'] = this.description;
    return data;
  }
}
