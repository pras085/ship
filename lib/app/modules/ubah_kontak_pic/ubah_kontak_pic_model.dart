class KontakPicShipperModel {
  Message message;
  Data data;
  String type;

  KontakPicShipperModel({this.message, this.data, this.type});

  KontakPicShipperModel.fromJson(Map<String, dynamic> json) {
    message =
        json['Message'] != null ? new Message.fromJson(json['Message']) : null;
    data = json['Data'] != null && json['Data'] is Map
        ? new Data.fromJson(json['Data'])
        : null;
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
  String pic1Name;
  String pic1Phone;
  String pic2Name;
  String pic2Phone;
  String pic3Name;
  String pic3Phone;

  Data({
    this.pic1Name,
    this.pic1Phone,
    this.pic2Name,
    this.pic2Phone,
    this.pic3Name,
    this.pic3Phone,
  });

  Data.fromJson(Map<String, dynamic> json) {
    pic1Name = json['pic_1_name'];
    pic1Phone = json['pic_1_phone'];
    pic2Name = json['pic_2_name'];
    pic2Phone = json['pic_2_phone'];
    pic3Name = json['pic_3_name'];
    pic3Phone = json['pic_3_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pic_1_name'] = this.pic1Name;
    data['pic_1_phone'] = this.pic1Phone;
    data['pic_2_name'] = this.pic2Name;
    data['pic_2_phone'] = this.pic2Phone;
    data['pic_3_name'] = this.pic3Name;
    data['pic_3_phone'] = this.pic3Phone;
    return data;
  }
}
