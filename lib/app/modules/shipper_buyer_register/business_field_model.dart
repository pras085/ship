class BusinessFieldModel {
  int id;
  String code;
  String descriptionID;
  String showText;

  BusinessFieldModel(this.id, this.code, this.descriptionID, this.showText);

  BusinessFieldModel.fromJson(Map<String, dynamic> map) {
    id = map['ID'];
    code = map['Code'];
    descriptionID = map['Description'];
    showText = code + " - " + descriptionID;
  }
}
