import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_model.dart';

class ListSearchTruckSiapMuatModel {
  String id;
  String kode;
  String transporterID;
  String namaTransporter;
  String emailTransporter;
  String truck;
  String avatar;
  String initial;
  String kotaTransporter;
  String areaPickup;
  String ekspektasiDestinasi;
  String posisiTruk;
  int jumlahTruk;
  int siapMuat;
  int sudahDipesan;
  String lastUpdateTanggal;
  String lastUpdateWaktu;
  DateTime lastUpdate;
  bool isGold;
  ContactTransporterByShipperModel contacts;
  double latitude;
  double longitude;

  ListSearchTruckSiapMuatModel(
      this.id,
      this.kode,
      this.transporterID,
      this.namaTransporter,
      this.emailTransporter,
      this.truck,
      this.avatar,
      this.initial,
      this.kotaTransporter,
      this.areaPickup,
      this.ekspektasiDestinasi,
      this.posisiTruk,
      this.latitude,
      this.longitude,
      this.jumlahTruk,
      this.siapMuat,
      this.sudahDipesan,
      this.lastUpdateTanggal,
      this.lastUpdateWaktu,
      this.lastUpdate,
      this.isGold);

  ListSearchTruckSiapMuatModel.fromJson(Map<String, dynamic> json) {
    id = json["ID"].toString();
    kode = json["Kode"].toString();
    transporterID = json["TransporterID"].toString();
    namaTransporter = json["TransporterName"].toString();
    emailTransporter = json["TransporterEmail"].toString();
    truck = json["Truck"].toString();
    avatar = "";
    // avatar = json["Avatar"].toString();
    initial = _getInitials(namaTransporter);
    kotaTransporter = json["CityTransporter"].toString();
    areaPickup = (json["Address"].toString().contains(",") ? "Kec. " : "") +
        json["Address"].toString();
    ekspektasiDestinasi = json["Destinasi"].toString();
    posisiTruk = json["PosisiTruk"].toString();
    jumlahTruk = int.parse(json["JumlahTruk"].toString());
    siapMuat = int.parse(json["SiapMuat"].toString());
    sudahDipesan = int.parse(json["SudahDipesan"].toString());
    var getLastUpdate = json["LastUpdate"].toString().split(" ");
    lastUpdateTanggal =
        "${getLastUpdate[0]} ${getLastUpdate[1]} ${getLastUpdate[2]}";
    lastUpdateWaktu = "${getLastUpdate[3]} ${getLastUpdate[4]}";
    lastUpdate = DateFormat('yyyy-MM-dd HH:mm:ss')
        .parse(json["LastUpdateRaw"].toString());
    isGold = json["IsGold"].toString() == "1";
    latitude = double.parse(json["Latitude"].toString());
    longitude = double.parse(json["Longitude"].toString());
  }

  String _getInitials(String value) {
    List<String> listWords = value.split(" ");
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
