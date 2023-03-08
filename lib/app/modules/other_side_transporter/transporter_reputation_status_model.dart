class TransporterReputationStatusModel {
  Message message;
  Data data;
  String type;

  TransporterReputationStatusModel({this.message, this.data, this.type});

  TransporterReputationStatusModel.fromJson(Map<String, dynamic> json) {
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
  int isSubscribeBF;
  int isSubscribeTM;
  int isNextBF;
  int isNextTM;
  int isVerifBF;
  int isVerifTM;
  int isGold;
  int userLevel;

  Data(
      {this.isSubscribeBF,
      this.isSubscribeTM,
      this.isNextBF,
      this.isNextTM,
      this.isVerifBF,
      this.isVerifTM,
      this.isGold,
      this.userLevel});

  Data.fromJson(Map<String, dynamic> json) {
    isSubscribeBF = json['IsSubscribeBF'];
    isSubscribeTM = json['IsSubscribeTM'];
    isNextBF = json['IsNextBF'];
    isNextTM = json['IsNextTM'];
    isVerifBF = json['IsVerifBF'];
    isVerifTM = json['IsVerifTM'];
    isGold = json['IsGold'];
    userLevel = json['UserLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSubscribeBF'] = this.isSubscribeBF;
    data['IsSubscribeTM'] = this.isSubscribeTM;
    data['IsNextBF'] = this.isNextBF;
    data['IsNextTM'] = this.isNextTM;
    data['IsVerifBF'] = this.isVerifBF;
    data['IsVerifTM'] = this.isVerifTM;
    data['IsGold'] = this.isGold;
    data['UserLevel'] = this.userLevel;
    return data;
  }
}
