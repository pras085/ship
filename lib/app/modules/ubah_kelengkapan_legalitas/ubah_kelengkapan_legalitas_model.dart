class UbahKelengkapanLegalitasModel {
  Message message;
  Data data;
  List<FileLegalitas> file;
  String type;

  UbahKelengkapanLegalitasModel(
      {this.message, this.data, this.file, this.type});

  UbahKelengkapanLegalitasModel.fromJson(Map<String, dynamic> json) {
    message =
        json['Message'] != null ? new Message.fromJson(json['Message']) : null;
    data = json['Data'] != null && json['Data'] is Map ? new Data.fromJson(json['Data']) : null;
    if (json['File'] != null) {
      file = <FileLegalitas>[];
      json['File'].forEach((v) {
        file.add(new FileLegalitas.fromJson(v));
      });
    }
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
    if (this.file != null) {
      data['File'] = this.file.map((v) => v.toJson()).toList();
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
  String ktpDirektur;
  String npwp;
  String ktpPic;

  Data({this.ktpDirektur, this.npwp, this.ktpPic});

  Data.fromJson(Map<String, dynamic> json) {
    ktpDirektur = json['ktp_direktur'];
    npwp = json['npwp'];
    ktpPic = json['ktp_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ktp_direktur'] = this.ktpDirektur;
    data['npwp'] = this.npwp;
    data['ktp_pic'] = this.ktpPic;
    return data;
  }
}

class FileLegalitas {
  int fileID;
  String fieldName;
  String name;
  String fileFilename;

  FileLegalitas({this.fileID, this.fieldName, this.name, this.fileFilename});

  FileLegalitas.fromJson(Map<String, dynamic> json) {
    fileID = json['FileID'];
    fieldName = json['field_name'];
    name = json['Name'];
    fileFilename = json['FileFilename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FileID'] = this.fileID;
    data['field_name'] = this.fieldName;
    data['Name'] = this.name;
    data['FileFilename'] = this.fileFilename;
    return data;
  }
}
