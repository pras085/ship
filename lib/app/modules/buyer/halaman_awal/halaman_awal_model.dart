class HalamanAwalModel {
  MessageTransportationStore message;
  DataTransportationStore data;
  String total;
  String draw;
  String colomnSort;
  String supportingData;
  String type;

  HalamanAwalModel(
      {this.message,
      this.data,
      this.total,
      this.draw,
      this.colomnSort,
      this.supportingData,
      this.type});

  HalamanAwalModel.fromJson(Map<String, dynamic> json) {
    message =
        json['Message'] != null ? new MessageTransportationStore.fromJson(json['Message']) : null;
    data = json['Data'] != null ? new DataTransportationStore.fromJson(json['Data']) : null;
    total = json['Total'];
    draw = json['draw'];
    colomnSort = json['colomn_sort'];
    supportingData = json['SupportingData'];
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
    data['Total'] = this.total;
    data['draw'] = this.draw;
    data['colomn_sort'] = this.colomnSort;
    data['SupportingData'] = this.supportingData;
    data['Type'] = this.type;
    return data;
  }
}

class MessageTransportationStore {
  int code;
  String text;

  MessageTransportationStore({this.code, this.text});

  MessageTransportationStore.fromJson(Map<String, dynamic> json) {
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

class DataTransportationStore {
  List<DataLayananTransportationStore> dataLayanan;

  DataTransportationStore({this.dataLayanan});

  DataTransportationStore.fromJson(Map<String, dynamic> json) {
    if (json['DataLayanan'] != null) {
      dataLayanan = new List<DataLayananTransportationStore>();
      json['DataLayanan'].forEach((v) {
        dataLayanan.add(new DataLayananTransportationStore.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataLayanan != null) {
      data['DataLayanan'] = this.dataLayanan.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataLayananTransportationStore {
  int iD;
  String nama;
  int isActive;
  int kategoriID;
  String icon;

  DataLayananTransportationStore({this.iD, this.nama, this.isActive, this.kategoriID, this.icon});

  DataLayananTransportationStore.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nama = json['Nama'];
    isActive = json['IsActive'];
    kategoriID = json['KategoriID'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Nama'] = this.nama;
    data['IsActive'] = this.isActive;
    data['KategoriID'] = this.kategoriID;
    data['icon'] = this.icon;
    return data;
  }
}
