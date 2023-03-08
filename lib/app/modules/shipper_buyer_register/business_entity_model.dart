class BusinessEntityModel {
  int id;
  String code;
  String descriptionID;
  String showText;

  BusinessEntityModel(this.id, this.code, this.descriptionID, this.showText);

  BusinessEntityModel.fromJson(Map<String, dynamic> map) {
    id = map['ID'];
    code = map['Code'];
    descriptionID = map['Description'];
    showText = code + " - " + descriptionID;
  }
}
