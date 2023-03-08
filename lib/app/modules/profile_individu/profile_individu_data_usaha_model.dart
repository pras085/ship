class ProfileIndividuDataUsahaModel {
  Message message;
  Data data;
  String type;

  ProfileIndividuDataUsahaModel({this.message, this.data, this.type});

  ProfileIndividuDataUsahaModel.fromJson(Map<String, dynamic> json) {
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
  int individualID;
  int sellerID;
  String companyName;
  String companyAddress;
  int companyDistrictID;
  int companyCityID;
  int companyProvinceID;
  String companyPostalCode;
  int companyLogoID;
  String fullFilename;
  String personalAddress;
  int personalDistrictID;
  int personalCityID;
  int personalProvinceID;
  String personalPostalCode;
  String pic1Name;
  String pic1Phone;
  String companyProvinceName;
  String companyCityName;
  String companyDistrictName;
  String personalProvinceName;
  String personalCityName;
  String personalDistrictName;
  PostalCodeData postalCodeData;

  Data(
      {this.individualID,
      this.sellerID,
      this.companyName,
      this.companyAddress,
      this.companyDistrictID,
      this.companyCityID,
      this.companyProvinceID,
      this.companyPostalCode,
      this.companyLogoID,
      this.fullFilename,
      this.personalAddress,
      this.personalDistrictID,
      this.personalCityID,
      this.personalProvinceID,
      this.personalPostalCode,
      this.pic1Name,
      this.pic1Phone,
      this.companyProvinceName,
      this.companyCityName,
      this.companyDistrictName,
      this.personalProvinceName,
      this.personalCityName,
      this.personalDistrictName,
      this.postalCodeData});

  Data.fromJson(Map<String, dynamic> json) {
    individualID = json['individualID'];
    sellerID = json['sellerID'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    companyDistrictID = json['company_districtID'];
    companyCityID = json['company_cityID'];
    companyProvinceID = json['company_provinceID'];
    companyPostalCode = json['company_postal_code'];
    companyLogoID = json['company_logoID'];
    fullFilename = json['full_filename'];
    personalAddress = json['personal_address'];
    personalDistrictID = json['personal_districtID'];
    personalCityID = json['personal_cityID'];
    personalProvinceID = json['personal_provinceID'];
    personalPostalCode = json['personal_postal_code'];
    pic1Name = json['pic_1_name'];
    pic1Phone = json['pic_1_phone'];
    companyProvinceName = json['company_provinceName'];
    companyCityName = json['company_cityName'];
    companyDistrictName = json['company_districtName'];
    personalProvinceName = json['personal_provinceName'];
    personalCityName = json['personal_cityName'];
    personalDistrictName = json['personal_districtName'];
    postalCodeData = json['postal_code_data'] != null
        ? new PostalCodeData.fromJson(json['postal_code_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['individualID'] = this.individualID;
    data['sellerID'] = this.sellerID;
    data['company_name'] = this.companyName;
    data['company_address'] = this.companyAddress;
    data['company_districtID'] = this.companyDistrictID;
    data['company_cityID'] = this.companyCityID;
    data['company_provinceID'] = this.companyProvinceID;
    data['company_postal_code'] = this.companyPostalCode;
    data['company_logoID'] = this.companyLogoID;
    data['full_filename'] = this.fullFilename;
    data['personal_address'] = this.personalAddress;
    data['personal_districtID'] = this.personalDistrictID;
    data['personal_cityID'] = this.personalCityID;
    data['personal_provinceID'] = this.personalProvinceID;
    data['personal_postal_code'] = this.personalPostalCode;
    data['pic_1_name'] = this.pic1Name;
    data['pic_1_phone'] = this.pic1Phone;
    data['company_provinceName'] = this.companyProvinceName;
    data['company_cityName'] = this.companyCityName;
    data['company_districtName'] = this.companyDistrictName;
    data['personal_provinceName'] = this.personalProvinceName;
    data['personal_cityName'] = this.personalCityName;
    data['personal_districtName'] = this.personalDistrictName;
    if (this.postalCodeData != null) {
      data['postal_code_data'] = this.postalCodeData.toJson();
    }
    return data;
  }
}

class PostalCodeData {
  int status;
  String message;
  int code;
  List<Result> result;

  PostalCodeData({this.status, this.message, this.code, this.result});

  PostalCodeData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int iD;
  String postalCode;

  Result({this.iD, this.postalCode});

  Result.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    postalCode = json['PostalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['PostalCode'] = this.postalCode;
    return data;
  }
}
