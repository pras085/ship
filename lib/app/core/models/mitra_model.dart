import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_model.dart';

class MitraModel {
  String docID;
  String id;
  String name;
  String avatar;
  String address = "";
  String city;
  String initials;
  String areaLayanan;
  String qtyAreaLayanan;
  String yearFounded = "";
  String qtyTruck = "0";
  String joinDate = "";
  bool isGold = false;
  ContactTransporterByShipperModel contacts;

  MitraModel({this.id, this.name, this.address, this.docID});

  //MitraModel({this.id, this.name, this.address = null});

  MitraModel.fromJson(Map<String, dynamic> json) {
    docID = json['DocID'].toString();
    id = json['TransporterID'].toString();
    name = json['Transporter'];
    avatar = json['Avatar'];
    city = json['TransporterKota'];
    address = json['TransporterAddr'];
    initials = _getInitials(name);
    areaLayanan = json['AreaLayanan'] ?? "";
    qtyAreaLayanan = json['QtyAreaLayanan'].toString();
    yearFounded = json['Founded'] ?? "";
    qtyTruck = (json['QtyTruck'] ?? "0").toString();
    isGold = (json['IsGold'] ?? "0").toString() == "1";
    joinDate = json['JoinDate'] ?? "";
  }

  String _getInitials(String value) {
    List<String> listWords = value.split(" ");
    listWords.removeWhere((element) => element.isEmpty);
    String initials = "";
    final int maxInitials = 3;
    int countInitials =
        listWords.length > maxInitials ? maxInitials : listWords.length;
    for (int i = 0; i < countInitials; i++) {
      initials += '${listWords[i][0]}';
    }
    return initials.toUpperCase();
  }
}
