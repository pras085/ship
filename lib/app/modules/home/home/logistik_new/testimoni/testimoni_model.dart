class TestimoniModel {
  Message message;
  List<Data> data;
  SupportingData supportingData;
  String type;

  TestimoniModel(
      {this.message, this.data, this.supportingData, this.type});

  TestimoniModel.fromJson(Map<String, dynamic> json) {
    message =
        json['Message'] != null ? new Message.fromJson(json['Message']) : null;
    if (json['Data'] != null) {
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
  num code;
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
  num iD;
  String content;
  num rate;
  num shipperId;
  num transporterId;
  String transporterName;
  String shipperName;
  String tanggal;
  num fileID;
  String fileName;
  String filePath;

  Data(
      {this.iD,
      this.content,
      this.rate,
      this.shipperId,
      this.transporterId,
      this.transporterName,
      this.shipperName,
      this.tanggal,
      this.fileID,
      this.fileName,
      this.filePath});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    content = json['content'];
    rate = json['rate'];
    shipperId = json['shipper_id'];
    transporterId = json['transporter_id'];
    transporterName = json['transporter_name'];
    shipperName = json['shipper_name'];
    tanggal = json['tanggal'];
    fileID = json['FileID'];
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
    data['FileID'] = this.fileID;
    data['FileName'] = this.fileName;
    data['FilePath'] = this.filePath;
    return data;
  }
}

class SupportingData {
  dynamic totalCountDataRating;
  List<DataJumlahRating> dataJumlahRating;
  num averageAllRating;
  num realCountData;
  num countData;

  SupportingData(
      {this.totalCountDataRating,
      this.dataJumlahRating,
      this.averageAllRating,
      this.realCountData,
      this.countData});

  SupportingData.fromJson(Map<String, dynamic> json) {
    totalCountDataRating = json['TotalCountDataRating'];
    if (json['DataJumlahRating'] != null) {
      dataJumlahRating = new List<DataJumlahRating>();
      json['DataJumlahRating'].forEach((v) {
        dataJumlahRating.add(new DataJumlahRating.fromJson(v));
      });
    }
    averageAllRating = json['AverageAllRating'];
    realCountData = json['RealCountData'];
    countData = json['CountData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalCountDataRating'] = this.totalCountDataRating;
    if (this.dataJumlahRating != null) {
      data['DataJumlahRating'] =
          this.dataJumlahRating.map((v) => v.toJson()).toList();
    }
    data['AverageAllRating'] = this.averageAllRating;
    data['RealCountData'] = this.realCountData;
    data['CountData'] = this.countData;
    return data;
  }
}

class DataJumlahRating {
  num rating;
  num countRating;
  dynamic displayCountRating;

  DataJumlahRating({this.rating, this.countRating, this.displayCountRating});

  DataJumlahRating.fromJson(Map<String, dynamic> json) {
    rating = json['Rating'];
    countRating = json['CountRating'];
    displayCountRating = json['DisplayCountRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Rating'] = this.rating;
    data['CountRating'] = this.countRating;
    data['DisplayCountRating'] = this.displayCountRating;
    return data;
  }
}
