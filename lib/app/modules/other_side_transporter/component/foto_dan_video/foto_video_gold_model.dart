class FotoVideoGoldModel {
  Message message;
  List<Data> data;
  String type;

  FotoVideoGoldModel({this.message, this.data, this.type});

  FotoVideoGoldModel.fromJson(Map<String, dynamic> json) {
    message =
        json['Message'] != null ? new Message.fromJson(json['Message']) : null;
    if (json['Data'] != null) {
      data = new List<Data>();
      json['Data'].forEach((v) {
        if (v is Map<String, dynamic> && v.isNotEmpty) data.add(new Data.fromJson(v));
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
  int iD;
  int fileID;
  String fileName;
  String filePath;
  String fileType;

  Data({this.iD, this.fileID, this.fileName, this.filePath, this.fileType});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    fileID = json['FileID'];
    fileName = json['FileName'];
    filePath = json['FilePath'];
    fileType = json['FileType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['FileID'] = this.fileID;
    data['FileName'] = this.fileName;
    data['FilePath'] = this.filePath;
    data['FileType'] = this.fileType;
    return data;
  }
}
