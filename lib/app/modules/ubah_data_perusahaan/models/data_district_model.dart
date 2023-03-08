class DistrictModel {
  Message message;
  Data data;
  String type;

  DistrictModel({this.message, this.data, this.type});

  DistrictModel.fromJson(Map<String, dynamic> json) {
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
  double lat;
  double long;
  List<Districts> districts;
  CompleteLocation completeLocation;

  Data({this.lat, this.long, this.districts, this.completeLocation});

  Data.fromJson(Map<String, dynamic> json) {
    lat = json['Lat'];
    long = json['Long'];
    if (json['Districts'] != null) {
      districts = new List<Districts>();
      json['Districts'].forEach((v) {
        districts.add(new Districts.fromJson(v));
      });
    }
    completeLocation = json['CompleteLocation'] != null ? new CompleteLocation.fromJson(json['CompleteLocation']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Lat'] = this.lat;
    data['Long'] = this.long;
    if (this.districts != null) {
      data['Districts'] = this.districts.map((v) => v.toJson()).toList();
    }
    if (this.completeLocation != null) {
      data['CompleteLocation'] = this.completeLocation.toJson();
    }
    return data;
  }
}

class Districts {
  int districtID;
  String district;
  int cityID;
  String cityName;
  int provinceID;
  String provinceName;
  List<PostalCodes> postalCodes;
  List<DistrictList> districtList;

  Districts({this.districtID, this.district, this.cityID, this.cityName, this.provinceID, this.provinceName, this.postalCodes, this.districtList});

  Districts.fromJson(Map<String, dynamic> json) {
    districtID = json['DistrictID'];
    district = json['District'];
    cityID = json['CityID'];
    cityName = json['CityName'];
    provinceID = json['ProvinceID'];
    provinceName = json['ProvinceName'];
    if (json['PostalCodes'] != null) {
      postalCodes = new List<PostalCodes>();
      json['PostalCodes'].forEach((v) {
        postalCodes.add(new PostalCodes.fromJson(v));
      });
    }
    if (json['DistrictList'] != null) {
      districtList = new List<DistrictList>();
      json['DistrictList'].forEach((v) {
        districtList.add(new DistrictList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DistrictID'] = this.districtID;
    data['District'] = this.district;
    data['CityID'] = this.cityID;
    data['CityName'] = this.cityName;
    data['ProvinceID'] = this.provinceID;
    data['ProvinceName'] = this.provinceName;
    if (this.postalCodes != null) {
      data['PostalCodes'] = this.postalCodes.map((v) => v.toJson()).toList();
    }
    if (this.districtList != null) {
      data['DistrictList'] = this.districtList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostalCodes {
  int iD;
  String postalCode;

  PostalCodes({this.iD, this.postalCode});

  PostalCodes.fromJson(Map<String, dynamic> json) {
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

class DistrictList {
  int districtID;
  String district;

  DistrictList({this.districtID, this.district});

  DistrictList.fromJson(Map<String, dynamic> json) {
    districtID = json['DistrictID'];
    district = json['District'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DistrictID'] = this.districtID;
    data['District'] = this.district;
    return data;
  }
}

class CompleteLocation {
  double lat;
  double lng;
  String village;
  String district;
  String city;
  int cityid;
  String province;
  int provinceid;
  String postal;
  bool intPostal;

  CompleteLocation({this.lat, this.lng, this.village, this.district, this.city, this.cityid, this.province, this.provinceid, this.postal, this.intPostal});

  CompleteLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    village = json['village'];
    district = json['district'];
    city = json['city'];
    cityid = json['cityid'];
    province = json['province'];
    provinceid = json['provinceid'];
    postal = json['postal'];
    intPostal = json['int_postal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['village'] = this.village;
    data['district'] = this.district;
    data['city'] = this.city;
    data['cityid'] = this.cityid;
    data['province'] = this.province;
    data['provinceid'] = this.provinceid;
    data['postal'] = this.postal;
    data['int_postal'] = this.intPostal;
    return data;
  }
}
