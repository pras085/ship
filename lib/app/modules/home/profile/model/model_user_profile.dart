class UserProfil {
  String userID;
  String name;
  String phone;
  int isVerifPhone;
  String code;
  String email;
  int isVerifEmail;
  int userType;
  int avatarID;
  int subUserID;
  int isSubUser;
  int businessEntityStatus;
  String fileName;
  String filePath;

  UserProfil();

  UserProfil.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    name = json['Name'];
    phone = json['Phone'];
    isVerifPhone = json['IsVerifPhone'];
    code = json['Code'];
    email = json['Email'];
    isVerifEmail = json['IsVerifEmail'];
    userType = json['UserType'];
    avatarID = json['AvatarID'];
    subUserID = json['SubUserID'];
    isSubUser = json['isSubUser'];
    businessEntityStatus = json['businessEntityStatus'];
    fileName = json['FileName'];
    filePath = json['FilePath']??"";
  }
}
