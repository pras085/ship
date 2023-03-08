import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_info_permintaan_muat/info_permintaan_muat_status_enum.dart';

class InfoPermintaanMuatModel {
  String id;
  String kode;
  String tanggalWaktuDibuat;
  String tanggalDibuat = "";
  String waktuDibuat = "";
  String rute;
  String truck;
  String unit;
  String tanggalEstimasi;
  String tanggalKedatanganHistory;
  String tanggalKedatanganHistoryDate;
  String tanggalKedatanganHistoryTime;
  String tanggalEstimasiHistory;
  String tanggalEstimasiHistoryDate;
  String tanggalEstimasiHistoryTime;
  String status;
  InfoPermintaanMuatStatus statusKey;
  String diumumkanKepada;
  String firstLocationPickup;
  String firstLocationBongkar;
  String typePickup;
  String typeBongkar;

  InfoPermintaanMuatModel.fromJson(Map<String, dynamic> json) {
    id = json["ID"].toString() ?? "";
    kode = json["Kode"] ?? "";
    tanggalWaktuDibuat = json["TanggalDibuat"] ?? "";
    var splitStringTanggalWaktuDibuat = tanggalWaktuDibuat.split(" ").toList();
    for (int i = 0; i < splitStringTanggalWaktuDibuat.length; i++) {
      if (i < 3) {
        tanggalDibuat += (tanggalDibuat != "" ? " " : "") + splitStringTanggalWaktuDibuat[i];
      } else {
        waktuDibuat += (waktuDibuat != "" ? " " : "") + splitStringTanggalWaktuDibuat[i];
      }
    }

    rute = json["Rute"] ?? "";
    truck = json["Truck"] ?? "";
    unit = json["Unit"].toString() ?? "";
    tanggalEstimasi = json["TanggalEstimasi"] ?? "";
    tanggalKedatanganHistory = json["TanggalKedatanganHistory"] ?? "";
    tanggalKedatanganHistoryDate = json["TanggalKedatanganHistoryDate"] ?? "";
    tanggalKedatanganHistoryTime = json["TanggalKedatanganHistoryTime"] ?? "";
    tanggalEstimasiHistory = json["TanggalEstimasiHistory"] ?? "";
    tanggalEstimasiHistoryDate = json["TanggalEstimasiHistoryDate"] ?? "";
    tanggalEstimasiHistoryTime = json["TanggalEstimasiHistoryTime"] ?? "";
    status = json["Status"] ?? "";
    statusKey =
        json["StatusKey"] == 0 ? InfoPermintaanMuatStatus.AKTIF : (json["StatusKey"] == 1 ? InfoPermintaanMuatStatus.SELESAI : InfoPermintaanMuatStatus.BATAL);
    diumumkanKepada = json["DiumumkanKepada"] ?? "";
    firstLocationPickup = json["FirstLocationPickup"] ?? "";
    firstLocationBongkar = json["FirstLocationBongkar"] ?? "";
    typePickup = json["TypePickup"] ?? "";
    typeBongkar = json["TypeBongkar"] ?? "";
  }
}
