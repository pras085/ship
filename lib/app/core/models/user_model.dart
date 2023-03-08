class UserModel {
  String docID;
  String name;
  String email;
  String phone;
  String password;
  String referralCode;
  String code;
  bool isGoogle;
  bool isVerifPhone;
  bool isSubUser;

  UserModel(
      {this.name = "",
      this.email = "",
      this.phone = "",
      this.password = "",
      this.referralCode = "",
      this.isGoogle = false,
      this.isVerifPhone = false,
      this.isSubUser = false,
      this.docID = "",
      this.code = ""});

  UserModel.fromJson(Map<String, dynamic> json, bool isFromURL) {
    name = json['Name'];
    email = json['Email'];
    phone = json['Phone'] ?? "";
    referralCode = json['ReferralCode'] ?? "";
    docID = (json['DocID'] ?? "").toString();
    code = json['Code'] ?? "";
    if (!isFromURL) {
      isVerifPhone = json['IsVerifPhone'];
      password = json['Password'] ?? "";
      isGoogle = json['IsGoogle'] ?? false;
      isSubUser = json['IsSubUser'] ?? false;
    } else {
      int isVerifPhoneJ = json['IsVerifPhone'] ?? 0;
      isVerifPhone = isVerifPhoneJ == 1;
      isGoogle = false;
      isSubUser = false;
    }
  }

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Email': email,
        'Phone': phone,
        'ReferralCode': referralCode,
        'IsVerifPhone': isVerifPhone,
        'DocID': docID,
        'Password': password,
        'IsGoogle': isGoogle,
        'Code': code,
        'IsSubUser': isSubUser,
      };

  setForUserModelGlobal(UserModel userModelGlobal) {
    this.name = userModelGlobal.name;
    this.email = userModelGlobal.email;
    this.phone = userModelGlobal.phone;
    //this.password = userModelGlobal.name;
    //this.referralCode = "",
    this.isGoogle = userModelGlobal.isGoogle;
    this.isVerifPhone = userModelGlobal.isVerifPhone;
    this.docID = userModelGlobal.docID;
    this.isSubUser = userModelGlobal.isSubUser;
  }
}
