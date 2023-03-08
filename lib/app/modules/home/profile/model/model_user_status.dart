class UserStatus {
  int shipperID;
  int shipperIsVerifBF;
  int shipperIsVerifTM;
  String shipperVerifDate;
  String shipperVerifDateBF;
  String shipperVerifDateTM;
  int transporterID;
  int transporterIsVerifBF;
  int transporterIsVerifTM;
  String transporterVerifDate;
  String transporterVerifDateBF;
  String transporterVerifDateTM;
  int sellerIsVerif;
  int subscribeShipperID;
  int subscribeTransporterID;
  int verifShipper;
  int verifTransporter;
  int userLevel;
  int shipperCapacity;
  int transporterQtyTruck;
  int shipperHasPendingVerification;
  int transporterHasPendingVerification;
  int shipperIsIntermediat;
  int transporterIsIntermediat;
  int businessCategory;
  int userType;
  int isSubUser;
  int isFirstBFShipper;
  int isFirstBFTransporter;
  int isFirstTMShipper;
  int isFirstTMTransporter;

  UserStatus();

  UserStatus.fromJson(Map<String, dynamic> json) {
    shipperID = json['ShipperID'];
    shipperIsVerifBF = json['ShipperIsVerifBF'];
    shipperIsVerifTM = json['ShipperIsVerifTM'];
    shipperVerifDate = json['ShipperVerifDate'];
    shipperVerifDateBF = json['ShipperVerifDateBF'];
    shipperVerifDateTM = json['ShipperVerifDateTM'];
    transporterID = json['TransporterID'];
    transporterIsVerifBF = json['TransporterIsVerifBF'];
    transporterIsVerifTM = json['TransporterIsVerifTM'];
    transporterVerifDate = json['TransporterVerifDate'];
    transporterVerifDateBF = json['TransporterVerifDateBF'];
    transporterVerifDateTM = json['TransporterVerifDateTM'];
    sellerIsVerif = json['SellerIsVerif'];
    subscribeShipperID = json['SubscribeShipperID'];
    subscribeTransporterID = json['SubscribeTransporterID'];
    verifShipper = json['VerifShipper'];
    verifTransporter = json['VerifTransporter'];
    userLevel = json['UserLevel'];
    shipperCapacity = json['ShipperCapacity'];
    transporterQtyTruck = json['TransporterQtyTruck'];
    shipperHasPendingVerification = json['ShipperHasPendingVerification'];
    transporterHasPendingVerification = json['TransporterHasPendingVerification'];
    shipperIsIntermediat = json['ShipperIsIntermediat'];
    transporterIsIntermediat = json['TransporterIsIntermediat'];
    businessCategory = json['BusinessCategory'];
    userType = json['UserType'];
    isSubUser = json['IsSubUser'];
    isFirstBFShipper = json['isFirstBFShipper'];
    isFirstBFTransporter = json['isFirstBFTransporter'];
    isFirstTMShipper = json['isFirstTMShipper'];
    isFirstTMTransporter = json['isFirstTMTransporter'];
  }
}
