class Transporter {
  String transporterID;
  String status;
  bool isGold = false;
  bool isMitra = false;
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
    namaPic1 = json["NamePic1"];
    namaPic2 = json["NamePic2"];
    namaPic3 = json["NamePic3"];
    contactPic1 = json["ContactPic1"];
    contactPic2 = json["ContactPic2"];
    contactPic3 = json["ContactPic3"];
    // bisnis_entity= json["Name"];
    // provinsi= json["Provinsi"];
    kota = json["Kota"];
    category_total_truck = "";
    // noTelp = "";
    // noWA = "";
    email = "";
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
