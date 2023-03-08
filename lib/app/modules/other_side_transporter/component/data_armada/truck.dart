class Truck{
int id; 
int qty;
int headID;
int carrierID;
int capacityMin;
int capacityMax;
String capacityMeasure;
int p;
int l;
int t;
String dimensionMeasure;
int fileID;
String pictureName;
String picturePath;
String pictureFullPath;
String headTxt;
String carrierTxt;
String capacityTxt;
String dimensionTxt;

  Truck(this.id, this.qty, this.headID, this.carrierID, this.capacityMin, this.capacityMax, this.capacityMeasure, this.p, this.l, this.t, this.dimensionMeasure, this.fileID, 
  this.pictureName, this.picturePath, this.pictureFullPath, this.headTxt, this.carrierTxt, this.capacityTxt, this.dimensionTxt);
  Truck.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        qty = json['Qty'],
        headID = json['HeadID'],
        carrierID = json['CarrierID'],
        capacityMin = json['CapacityMin'],
        capacityMax = json['CapacityMax'],
        capacityMeasure = json['CapacityMeasure'],
        p = json['P'],
        l = json['L'],
        t = json['T'],
        dimensionMeasure = json['DimensionMeasure'],
        fileID = json['FileID'],
        pictureName = json['PictureName'],
        picturePath = json['PicturePath'],
        pictureFullPath = json['PictureFullPath'],
        headTxt = json['HeadTxt'],
        carrierTxt = json['CarrierTxt'],
        capacityTxt = json['CapacityTxt'],
        dimensionTxt = json['DimensionTxt'];
  
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'qty': qty,
      'headID' : headID,
      'carrierID' : carrierID,
      'capacityMin' : capacityMin,
      'capacityMax' : capacityMax,
      'capacityMeasure' : capacityMeasure,
      'p' : p,
        'l' : l,
        't' : t,
        'dimensionMeasure' : dimensionMeasure,
        'fileID' : fileID,
        'pictureName' : pictureName,
        'picturePath' : picturePath,
        'pictureFullPath' : pictureFullPath,
        'headTxt' : headTxt,
        'carrierTxt' : carrierTxt,
        'capacityTxt' : capacityTxt,
        'dimensionTxt' : dimensionTxt
    };
    return map;
  }

  Truck.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    qty = map['qty'];
    headID = map['headID'];
    carrierID = map['carrierID'];
    capacityMin = map['capacityMin'];
    capacityMax = map['capacityMax'];
    capacityMeasure = map['capacityMeasure'];
    p = map['p'];
    l = map['l'];
    t = map['t'];
    dimensionMeasure = map['dimensionMeasure'];
    fileID = map['fileID'];
    pictureName = map['pictureName'];
    picturePath = map['picturePath'];
    pictureFullPath = map['pictureFullPath'];
    headTxt = map['headTxt'];
    carrierTxt = map['carrierTxt'];
    capacityTxt = map['capacityTxt'];
    dimensionTxt = map['dimensionTxt'];
  }

   @override
  String toString() {
    return "Truck(id: $id, qty: $qty, description: $headID)";
  }
}