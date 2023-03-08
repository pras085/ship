class ProvinceModel {
  int code;
  String descriptionID;

  ProvinceModel(this.code, this.descriptionID);

  ProvinceModel.fromJson(Map<String, dynamic> map) {
    code = map['Code'];
    descriptionID = map['Description'];
  }
}
