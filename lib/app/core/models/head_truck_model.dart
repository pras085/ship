class HeadTruckModel {
  String id;
  String description;
  String imageUrl;

  HeadTruckModel({this.id, this.description, this.imageUrl});

  HeadTruckModel.fromJson(Map<String, dynamic> data) {
    id = data['ID'].toString();
    description = data['Description'];
    imageUrl = data['ImageHead'];
  }
}
