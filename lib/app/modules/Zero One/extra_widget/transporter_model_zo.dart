import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class Transporter {
  String transporterID;
  String status;
  bool isGold = false;
  bool isMitra = false;
  bool isWa1 = false;
  bool isWa2 = false;
  bool isWa3 = false;
  String nama;
  String tahunBerdiri;
  String alamat;
  String tipe;
  String bisnis_field;
  String postal;
  String jumlahTruk;
  String namaPic1;
  String namaPic2;
  String namaPic3;
  String contactPic1;
  String contactPic2;
  String contactPic3;
  String emergencyHP;
  String emergencyWA;
  String inbox;
  String bisnis_entity;
  String provinsi;
  String kota;
  String category_total_truck;
  String noTelp;
  String noWA;
  String email;
  String avatar;
  String latitude;
  String longitude;
  String joinDate;
  List<String> areaLayanan;

  Transporter(
      {this.transporterID,
      this.status,
      this.isGold,
      this.nama,
      this.tahunBerdiri,
      this.alamat,
      this.tipe,
      this.bisnis_field,
      this.postal,
      this.jumlahTruk,
      this.namaPic1,
      this.namaPic2,
      this.namaPic3,
      this.contactPic1,
      this.contactPic2,
      this.contactPic3,
      this.isWa1,
      this.isWa2,
      this.isWa3,
      this.emergencyHP,
      this.emergencyWA,
      this.inbox,
      this.bisnis_entity,
      this.provinsi,
      this.kota,
      this.category_total_truck,
      this.noTelp,
      this.noWA,
      this.email,
      this.avatar,
      this.latitude,
      this.longitude,
      this.areaLayanan,
      this.joinDate = "",
      this.isMitra});

  Transporter.fromJson(Map<String, dynamic> json) {
    transporterID = json["TransporterID"].toString();
    status = json["StatusVerified"].toString();
    isGold = json["IsGold"].toString() == "1";
    isMitra = json["IsMitra"].toString() == "1";
    nama = json["Name"];
    tahunBerdiri = json["FoundedYear"];
    // alamat = "";
    alamat = json["TransporterAddr"];
    tipe = "";
    bisnis_field = "";
    postal = "";
    // tipe= json["Type"];
    // bisnis_field= json["BusinessField"];
    // postal= json["PostalCode"];
    jumlahTruk = json["QtyTruck"].toString();
    // namaPic1 = "";
    // namaPic2 = "";
    // namaPic3 = "";
    // contactPic1 = "";
    // contactPic2 = "";
    // contactPic3 = "";
    bisnis_entity = "";
    provinsi = "";

    String getFromValues(List<String> values) {
      var value = values[0];
      for (int i = 1; i < values.length; i++) {
        if ((value?.trim()?.isEmpty ?? true) || value.trim() == '-') {
          value = values[1];
        }
      }
      return value;
    }

    namaPic1 = getFromValues([json['pic_1_name'], json['NamePic1']]);
    namaPic2 = getFromValues([json['pic_2_name'], json['NamePic2']]);
    namaPic3 = getFromValues([json['pic_3_name'], json['NamePic3']]);

    contactPic1 = getFromValues([json['pic_1_phone'], json['ContactPic1']]);
    contactPic2 = getFromValues([json['pic_2_phone'], json['ContactPic2']]);
    contactPic3 = getFromValues([json['pic_3_phone'], json['ContactPic3']]);

    isWa1 = json['IsWa1'].toString() == "1";
    isWa2 = json['IsWa2'].toString() == "1";
    isWa3 = json['IsWa3'].toString() == "1";
    emergencyHP = json['EmergencyHp'];
    emergencyWA = json['EmergencyWA'];
    // inbox = json['Inbox'];
    // bisnis_entity= json["Name"];
    // provinsi= json["Provinsi"];
    kota = json["Kota"];
    category_total_truck = "";
    // noTelp = "";
    // noWA = "";
    email = json['Email'];
    // category_total_truck= json["category_total_truck"];
    noTelp = json["PhoneWA"];
    noWA = json["PhoneWA"];
    // email= json["email"];
    avatar = json["Avatar"];
    latitude = json["Latitude"] ?? "";
    longitude = json["Longitude"] ?? "";
    areaLayanan = json["AreaLayanan"].toString().split(',');
    joinDate = json["JoinDate"] ?? "";
    // isMitra = json["IsMitra"] ?? "";
    isMitra = json["IsMitra"].toString() == "1";
  }
}

class TransporterResponseModel {
  final MessageFromUrlModel message;
  final Transporter data;
  final String type;

  const TransporterResponseModel._({this.message, this.data, this.type});

  TransporterResponseModel copyWith({
    MessageFromUrlModel message,
    Transporter data,
    String type,
  }) {
    return TransporterResponseModel._(
      message: message ?? this.message,
      data: data ?? this.data,
      type: type ?? this.type,
    );
  }

  factory TransporterResponseModel.fromJson(Map<String, dynamic> json) {
    return TransporterResponseModel._(
      message: MessageFromUrlModel.fromJson(json['Message']),
      data: json['Data'] is Map ? Transporter.fromJson(json['Data']) : null,
      type: json['Type'],
    );
  }
}
