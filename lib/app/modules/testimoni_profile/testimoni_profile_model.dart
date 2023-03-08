class TestimoniProfileModel {
  Message message;
  List<Data> data;
  SupportingData supportingData;
  String type;

  TestimoniProfileModel(
      {this.message, this.data, this.supportingData, this.type});

  TestimoniProfileModel.fromJson(Map<String, dynamic> json) {
    message =
        json['Message'] != null ? new Message.fromJson(json['Message']) : null;
    if (json['Data'] != null && json['Data'] is Iterable) {
      data = new List<Data>();
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    supportingData = json['SupportingData'] != null
        ? new SupportingData.fromJson(json['SupportingData'])
        : null;
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
    if (this.supportingData != null) {
      data['SupportingData'] = this.supportingData.toJson();
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
  String content;
  int rate;
  int shipperId;
  int transporterId;
  String transporterName;
  String shipperName;
  String tanggal;
  String tanggalMobile;
  int fileId;
  String fileName;
  String filePath;

  Data({
    this.iD,
    this.content,
    this.rate,
    this.shipperId,
    this.transporterId,
    this.transporterName,
    this.shipperName,
    this.tanggal,
    this.tanggalMobile,
    this.fileId,
    this.fileName,
    this.filePath,
  });

  Data copyWith({
    int iD,
    String content,
    int rate,
    int shipperId,
    int transporterId,
    String transporterName,
    String shipperName,
    String tanggal,
    String tanggalMobile,
    int fileId,
    String fileName,
    String filePath,
  }) {
    return Data(
      iD: iD ?? this.iD,
      content: content ?? this.content,
      rate: rate ?? this.rate,
      shipperId: shipperId ?? this.shipperId,
      transporterId: transporterId ?? this.transporterId,
      transporterName: transporterName ?? this.transporterName,
      shipperName: shipperName ?? this.shipperName,
      tanggal: tanggal ?? this.tanggal,
      tanggalMobile: tanggalMobile ?? this.tanggalMobile,
      fileId: fileId ?? this.fileId,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
    );
  }

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    content = json['content'];
    rate = json['rate'];
    shipperId = json['shipper_id'];
    transporterId = json['transporter_id'];
    transporterName = json['transporter_name'];
    shipperName = json['shipper_name'];
    tanggal = json['tanggal'];
    tanggalMobile = json['tanggalMobile'];
    fileId = json['FileID'];
    fileName = json['FileName'];
    filePath = json['FilePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['content'] = this.content;
    data['rate'] = this.rate;
    data['shipper_id'] = this.shipperId;
    data['transporter_id'] = this.transporterId;
    data['transporter_name'] = this.transporterName;
    data['shipper_name'] = this.shipperName;
    data['tanggal'] = this.tanggal;
    data['tanggalMobile'] = this.tanggalMobile;
    data['FileID'] = this.fileId;
    data['FileName'] = this.fileName;
    data['FilePath'] = this.filePath;
    return data;
  }
}

class SupportingData {
  int realCountData;
  int countData;

  SupportingData({this.realCountData, this.countData});

  SupportingData.fromJson(Map<String, dynamic> json) {
    realCountData = json['RealCountData'];
    countData = json['CountData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RealCountData'] = this.realCountData;
    data['CountData'] = this.countData;
    return data;
  }
}
