class ProfileIndividuDataPribadiModel {
  MessageDataPribadi message;
  DataPribadi data;
  String type;

  ProfileIndividuDataPribadiModel({this.message, this.data, this.type});

  ProfileIndividuDataPribadiModel.fromJson(Map<String, dynamic> json) {
    message =
        json['Message'] != null ? new MessageDataPribadi.fromJson(json['Message']) : null;
    data = json['Data'] != null ? new DataPribadi.fromJson(json['Data']) : null;
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

class MessageDataPribadi {
  int code;
  String text;

  MessageDataPribadi({this.code, this.text});

  MessageDataPribadi.fromJson(Map<String, dynamic> json) {
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

class DataPribadi {
  int iD;
  String personalAddress;
  int personalDistrictID;
  int personalCityID;
  int personalProvinceID;
  String personalPostalCode;
  String personalProvinceName;
  String personalCityName;
  String personalDistrictName;
  PostalCodeData postalCodeData;

  DataPribadi(
      {this.iD,
      this.personalAddress,
      this.personalDistrictID,
      this.personalCityID,
      this.personalProvinceID,
      this.personalPostalCode,
      this.personalProvinceName,
      this.personalCityName,
      this.personalDistrictName,
      this.postalCodeData});

  DataPribadi.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    personalAddress = json['personal_address'];
    personalDistrictID = json['personal_districtID'];
    personalCityID = json['personal_cityID'];
    personalProvinceID = json['personal_provinceID'];
    personalPostalCode = json['personal_postal_code'];
    personalProvinceName = json['personal_provinceName'];
    personalCityName = json['personal_cityName'];
    personalDistrictName = json['personal_districtName'];
    postalCodeData = json['postal_code_data'] != null
        ? new PostalCodeData.fromJson(json['postal_code_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['personal_address'] = this.personalAddress;
    data['personal_districtID'] = this.personalDistrictID;
    data['personal_cityID'] = this.personalCityID;
    data['personal_provinceID'] = this.personalProvinceID;
    data['personal_postal_code'] = this.personalPostalCode;
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
