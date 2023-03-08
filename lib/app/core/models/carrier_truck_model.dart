class CarrierTruckModel {
  String id;
  String description;
  String imageUrl;

  CarrierTruckModel({this.id, this.description, this.imageUrl});

  CarrierTruckModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'].toString();
    description = json['Description'];
    imageUrl = json['ImageCarrier'];
  }
}
