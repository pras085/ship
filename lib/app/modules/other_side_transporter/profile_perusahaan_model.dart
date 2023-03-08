class ProfilePerusahaanModel {
  Message message;
  Data data;
  String type;

  ProfilePerusahaanModel({this.message, this.data, this.type});

  ProfilePerusahaanModel.fromJson(Map<String, dynamic> json) {
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
  String companyName;
  String companyPhone;
  String companyAddress;
  String companyAddressDetail;
  String companyPostalCode;
  String companyLatitude;
  String companyLongitude;
  int companyProvinceID;
  int companyCityID;
  int companyDistrictID;
  String companyLogo;
  String companyBusinessEntity;
  String companyBusinessField;
  String companyProvinceName;
  String companyCityName;
  String companyDistrictName;

  Data(
      {this.companyName,
      this.companyPhone,
      this.companyAddress,
      this.companyAddressDetail,
      this.companyPostalCode,
      this.companyLatitude,
      this.companyLongitude,
      this.companyProvinceID,
      this.companyCityID,
      this.companyDistrictID,
      this.companyLogo,
      this.companyBusinessEntity,
      this.companyBusinessField,
      this.companyProvinceName,
      this.companyCityName,
      this.companyDistrictName});

  Data.fromJson(Map<String, dynamic> json) {
    companyName = json['CompanyName'];
    companyPhone = json['CompanyPhone'];
    companyAddress = json['CompanyAddress'];
    companyAddressDetail = json['CompanyAddressDetail'];
    companyPostalCode = json['CompanyPostalCode'];
    companyLatitude = json['CompanyLatitude'];
    companyLongitude = json['CompanyLongitude'];
    companyProvinceID = json['CompanyProvinceID'];
    companyCityID = json['CompanyCityID'];
    companyDistrictID = json['CompanyDistrictID'];
    companyLogo = json['CompanyLogo'];
    companyBusinessEntity = json['CompanyBusinessEntity'];
    companyBusinessField = json['CompanyBusinessField'];
    companyProvinceName = json['CompanyProvinceName'];
    companyCityName = json['CompanyCityName'];
    companyDistrictName = json['CompanyDistrictName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyName'] = this.companyName;
    data['CompanyPhone'] = this.companyPhone;
    data['CompanyAddress'] = this.companyAddress;
    data['CompanyAddressDetail'] = this.companyAddressDetail;
    data['CompanyPostalCode'] = this.companyPostalCode;
    data['CompanyLatitude'] = this.companyLatitude;
    data['CompanyLongitude'] = this.companyLongitude;
    data['CompanyProvinceID'] = this.companyProvinceID;
    data['CompanyCityID'] = this.companyCityID;
    data['CompanyDistrictID'] = this.companyDistrictID;
    data['CompanyLogo'] = this.companyLogo;
    data['CompanyBusinessEntity'] = this.companyBusinessEntity;
    data['CompanyBusinessField'] = this.companyBusinessField;
    data['CompanyProvinceName'] = this.companyProvinceName;
    data['CompanyCityName'] = this.companyCityName;
    data['CompanyDistrictName'] = this.companyDistrictName;
    return data;
  }
}
