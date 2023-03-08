class DataKapasitasModel {
  Message message;
  List<Data> data;
  String type;

  DataKapasitasModel({this.message, this.data, this.type});

  DataKapasitasModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null ? new Message.fromJson(json['Message']) : null;
    if (json['Data'] != null) {
      data = new List<Data>();
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
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
      data['Data'] = this.data.map((v) => v.toJson()).toList();
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
  int capacity;
  List<FileKapasitas> file;

  Data({this.capacity, this.file});

  Data.fromJson(Map<String, dynamic> json) {
    capacity = json['capacity'];
    if (json['file'] != null) {
      file = new List<FileKapasitas>();
      json['file'].forEach((v) {
        file.add(new FileKapasitas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['capacity'] = this.capacity;
    if (this.file != null) {
      data['file'] = this.file.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FileKapasitas {
  int fileID;
  String name;
  String fileFilename;

  FileKapasitas({this.fileID, this.name, this.fileFilename});

  FileKapasitas.fromJson(Map<String, dynamic> json) {
    fileID = json['FileID'];
    name = json['Name'];
    fileFilename = json['FileFilename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FileID'] = this.fileID;
    data['Name'] = this.name;
    data['FileFilename'] = this.fileFilename;
    return data;
  }
}
