class CategoryCapacityModel {
  int id;
  String descriptionID;
  int topRange;
  int bottomRange;

  CategoryCapacityModel(this.id, this.descriptionID);

  CategoryCapacityModel.fromJson(Map<String, dynamic> map) {
    id = map['ID'];
    descriptionID = map['Description'];
    topRange = map['TopRange'];
    bottomRange = map['BottomRange'];
  }
}
