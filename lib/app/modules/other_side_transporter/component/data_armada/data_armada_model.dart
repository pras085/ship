class DataTruckModel {
  Message message;
  Data data;
  String type;

  DataTruckModel({this.message, this.data, this.type});

  DataTruckModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null ? new Message.fromJson(json['Message']) : null;
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
  String message;
  int truckListCount;
  List<TruckList> truckList;
  List<CarrierWithTrucks> carrierWithTrucks;
  List<Heads> heads;
  List<Carriers> carriers;

  Data({this.message, this.truckListCount, this.truckList, this.carrierWithTrucks, this.heads, this.carriers});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    truckListCount = json['TruckListCount'];
    if (json['TruckList'] != null) {
      truckList = new List<TruckList>();
      json['TruckList'].forEach((v) {
        truckList.add(new TruckList.fromJson(v));
      });
    }
    if (json['CarrierWithTrucks'] != null) {
      carrierWithTrucks = new List<CarrierWithTrucks>();
      json['CarrierWithTrucks'].forEach((v) {
        carrierWithTrucks.add(new CarrierWithTrucks.fromJson(v));
      });
    }
    if (json['Heads'] != null) {
      heads = new List<Heads>();
      json['Heads'].forEach((v) {
        heads.add(new Heads.fromJson(v));
      });
    }
    if (json['Carriers'] != null) {
      carriers = new List<Carriers>();
      json['Carriers'].forEach((v) {
        carriers.add(new Carriers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['TruckListCount'] = this.truckListCount;
    if (this.truckList != null) {
      data['TruckList'] = this.truckList.map((v) => v.toJson()).toList();
    }
    if (this.carrierWithTrucks != null) {
      data['CarrierWithTrucks'] = this.carrierWithTrucks.map((v) => v.toJson()).toList();
    }
    if (this.heads != null) {
      data['Heads'] = this.heads.map((v) => v.toJson()).toList();
    }
    if (this.carriers != null) {
      data['Carriers'] = this.carriers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TruckList {
  int iD;
  int qty;
  int headID;
  int carrierID;
  num capacityMin;
  num capacityMax;
  num capacityMeasure;
  int p;
  int l;
  int t;
  num dimensionMeasure;
  int fileID;
  String pictureName;
  String picturePath;
  String headTxt;
  String carrierTxt;
  String capacityTxt;
  String dimensionTxt;

  TruckList(
      {this.iD,
      this.qty,
      this.headID,
      this.carrierID,
      this.capacityMin,
      this.capacityMax,
      this.capacityMeasure,
      this.p,
      this.l,
      this.t,
      this.dimensionMeasure,
      this.fileID,
      this.pictureName,
      this.picturePath,
      this.headTxt,
      this.carrierTxt,
      this.capacityTxt,
      this.dimensionTxt});

  TruckList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    qty = json['Qty'];
    headID = json['HeadID'];
    carrierID = json['CarrierID'];
    capacityMin = json['CapacityMin'];
    capacityMax = json['CapacityMax'];
    capacityMeasure = json['CapacityMeasure'];
    p = json['P'];
    l = json['L'];
    t = json['T'];
    dimensionMeasure = json['DimensionMeasure'];
    fileID = json['FileID'];
    pictureName = json['PictureName'];
    picturePath = json['PicturePath'];
    headTxt = json['HeadTxt'];
    carrierTxt = json['CarrierTxt'];
    capacityTxt = json['CapacityTxt'];
    dimensionTxt = json['DimensionTxt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Qty'] = this.qty;
    data['HeadID'] = this.headID;
    data['CarrierID'] = this.carrierID;
    data['CapacityMin'] = this.capacityMin;
    data['CapacityMax'] = this.capacityMax;
    data['CapacityMeasure'] = this.capacityMeasure;
    data['P'] = this.p;
    data['L'] = this.l;
    data['T'] = this.t;
    data['DimensionMeasure'] = this.dimensionMeasure;
    data['FileID'] = this.fileID;
    data['PictureName'] = this.pictureName;
    data['PicturePath'] = this.picturePath;
    data['HeadTxt'] = this.headTxt;
    data['CarrierTxt'] = this.carrierTxt;
    data['CapacityTxt'] = this.capacityTxt;
    data['DimensionTxt'] = this.dimensionTxt;
    return data;
  }
}

class CarrierWithTrucks {
  int iD;
  String description;
  int imageCarrierID;
  int length;
  int width;
  int height;
  int volume;
  int headID;
  String headDescription;

  CarrierWithTrucks({
    this.iD,
    this.description,
    this.imageCarrierID,
    this.length,
    this.width,
    this.height,
    this.volume,
    this.headID,
    this.headDescription,
  });

  CarrierWithTrucks.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    description = json['Description'];
    imageCarrierID = json['ImageCarrierID'];
    length = json['Length'];
    width = json['Width'];
    height = json['Height'];
    volume = json['Volume'];
    headID = json['HeadID'];
    headDescription = json['HeadDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Description'] = this.description;
    data['ImageCarrierID'] = this.imageCarrierID;
    data['Length'] = this.length;
    data['Width'] = this.width;
    data['Height'] = this.height;
    data['Volume'] = this.volume;
    data['HeadID'] = this.headID;
    data['HeadDescription'] = this.headDescription;
    return data;
  }
}

class Heads {
  int iD;
  String description;
  int imageHeadID;

  Heads({this.iD, this.description, this.imageHeadID});

  Heads.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    description = json['Description'];
    imageHeadID = json['ImageHeadID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Description'] = this.description;
    data['ImageHeadID'] = this.imageHeadID;
    return data;
  }
}

class Carriers {
  int iD;
  String description;
  int imageCarrierID;
  int length;
  int width;
  int height;
  int volume;

  Carriers({this.iD, this.description, this.imageCarrierID, this.length, this.width, this.height, this.volume});

  Carriers.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    description = json['Description'];
    imageCarrierID = json['ImageCarrierID'];
    length = json['Length'];
    width = json['Width'];
    height = json['Height'];
    volume = json['Volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Description'] = this.description;
    data['ImageCarrierID'] = this.imageCarrierID;
    data['Length'] = this.length;
    data['Width'] = this.width;
    data['Height'] = this.height;
    data['Volume'] = this.volume;
    return data;
  }
}
