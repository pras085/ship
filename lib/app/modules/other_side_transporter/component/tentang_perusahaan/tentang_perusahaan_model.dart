class TentangPerusahaanModel {
  Message message;
  Data data;
  String type;

  TentangPerusahaanModel({this.message, this.data, this.type});

  TentangPerusahaanModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null ? new Message.fromJson(json['Message']) : null;
    if (json['Data'] != null) {
      data = Data.fromJson(json['Data']);

    }
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
  int transporterId;
  List<CustomerList> customerList;
  List<PortfolioList> portfolioList;
  String tahunMulaiUsaha;
  String tahunPendirianBadanUsaha;
  String advantage;
  List<AreaLayananList> areaLayananList;
  List<LayananTambahan> layananTambahan;

  Data({
    this.transporterId,
    this.customerList,
    this.portfolioList,
    this.tahunMulaiUsaha,
    this.tahunPendirianBadanUsaha,
    this.advantage,
    this.layananTambahan,
    this.areaLayananList,
  });

  Data.fromJson(Map<String, dynamic> json) {
    transporterId = json['transporter_id'];
    if (json['CustomerList'] != null) {
      customerList = <CustomerList>[];
      json['CustomerList'].forEach((v) {
        customerList.add(new CustomerList.fromJson(v));
      });
    }
    if (json['PortfolioList'] != null) {
      portfolioList = <PortfolioList>[];
      json['PortfolioList'].forEach((v) {
        portfolioList.add(new PortfolioList.fromJson(v));
      });
    }
    tahunMulaiUsaha = json['tahun_mulai_usaha'];
    tahunPendirianBadanUsaha = json['tahun_pendirian_badan_usaha'];
    advantage = json['advantage'];
    if (json['AreaLayananList'] != null) {
      areaLayananList = <AreaLayananList>[];
      json['AreaLayananList'].forEach((v) {
        areaLayananList.add(new AreaLayananList.fromJson(v));
      });
    }
    if (json['LayananTambahan'] != null) {
      layananTambahan = <LayananTambahan>[];
      json['LayananTambahan'].forEach((v) {
        layananTambahan.add(new LayananTambahan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transporter_id'] = this.transporterId;
    if (this.customerList != null) {
      data['CustomerList'] = this.customerList.map((v) => v.toJson()).toList();
    }
    if (this.portfolioList != null) {
      data['PortfolioList'] = this.portfolioList.map((v) => v.toJson()).toList();
    }
    data['tahun_mulai_usaha'] = this.tahunMulaiUsaha;
    data['tahun_pendirian_badan_usaha'] = this.tahunPendirianBadanUsaha;
    data['advantage'] = this.advantage;
    if (this.areaLayananList != null) {
      data['AreaLayananList'] = this.areaLayananList.map((v) => v.toJson()).toList();
    }
    if (this.layananTambahan != null) {
      data['LayananTambahan'] = this.layananTambahan.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PortfolioList {
  int customerId;
  int shipperId;
  String shipperName;
  String status;
  int avatarID;
  String fileName;
  String filePath;

  PortfolioList({
    this.customerId,
    this.shipperId,
    this.shipperName,
    this.status,
    this.avatarID,
    this.fileName,
    this.filePath,
  });

  PortfolioList.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    shipperId = json['shipper_id'];
    shipperName = json['shipper_name'];
    status = json['Status'];
    avatarID = json['AvatarID'];
    fileName = json['FileName'];
    filePath = json['FilePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['shipper_id'] = this.shipperId;
    data['shipper_name'] = this.shipperName;
    data['Status'] = this.status;
    data['AvatarID'] = this.avatarID;
    data['FileName'] = this.fileName;
    data['FilePath'] = this.filePath;
    return data;
  }
}

class CustomerList {
  int customerId;
  int shipperId;
  String shipperName;
  String status;
  int avatarID;
  String fileName;
  String filePath;

  CustomerList({this.customerId, this.shipperId, this.shipperName, this.status, this.avatarID, this.fileName, this.filePath});

  CustomerList.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    shipperId = json['shipper_id'];
    shipperName = json['shipper_name'];
    status = json['Status'];
    avatarID = json['AvatarID'];
    fileName = json['FileName'];
    filePath = json['FilePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['shipper_id'] = this.shipperId;
    data['shipper_name'] = this.shipperName;
    data['Status'] = this.status;
    data['AvatarID'] = this.avatarID;
    data['FileName'] = this.fileName;
    data['FilePath'] = this.filePath;
    return data;
  }
}

class LayananTambahan {
  int iD;
  String layananTambahan;

  LayananTambahan({this.iD, this.layananTambahan});

  LayananTambahan.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    layananTambahan = json['layanan_tambahan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['layanan_tambahan'] = this.layananTambahan;
    return data;
  }
}

class AreaLayananList {
  int areaID;
  int cityID;
  String areaLayanan;
  String status;

  AreaLayananList({
    this.areaID,
    this.cityID,
    this.areaLayanan,
    this.status,
  });

  AreaLayananList.fromJson(Map<String, dynamic> json) {
    areaID = json['area_id'];
    cityID = json['id_kota'];
    areaLayanan = json['area_layanan'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_id'] = this.areaID;
    data['id_kota'] = this.cityID;
    data['area_layanan'] = this.areaLayanan;
    data['Status'] = this.status;
    return data;
  }
}
