class GoldStatusModel {
  Message message;
  Data data;
  String type;

  GoldStatusModel({this.message, this.data, this.type});

  GoldStatusModel.fromJson(Map<String, dynamic> json) {
    message =
        json['Message'] != null ? new Message.fromJson(json['Message']) : null;
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['Message'] = this.message.toJson();
    }
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    data['Type'] = this.type;
    return data;
  }
}

class Message {
  int code;
  String text;

  Message({this.code, this.text});

  Message.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    text = json['Text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    data['Text'] = this.text;
    return data;
  }
}

class Data {
  int statCopySTNKCountTruck;
  int statKelengkapanLegalitas;
  int statProfilPerusahaan;
  int statTestimoni;
  int statFotoVideo;

  Data(
      {this.statCopySTNKCountTruck,
      this.statKelengkapanLegalitas,
      this.statProfilPerusahaan,
      this.statTestimoni,
      this.statFotoVideo});

  Data.fromJson(Map<String, dynamic> json) {
    statCopySTNKCountTruck = json['statCopySTNKCountTruck'];
    statKelengkapanLegalitas = json['statKelengkapanLegalitas'];
    statProfilPerusahaan = json['statProfilPerusahaan'];
    statTestimoni = json['statTestimoni'];
    statFotoVideo = json['statFotoVideo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statCopySTNKCountTruck'] = this.statCopySTNKCountTruck;
    data['statKelengkapanLegalitas'] = this.statKelengkapanLegalitas;
    data['statProfilPerusahaan'] = this.statProfilPerusahaan;
    data['statTestimoni'] = this.statTestimoni;
    data['statFotoVideo'] = this.statFotoVideo;
    return data;
  }
}
