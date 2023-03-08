class ModelPengaturanAkun {
  String phoneUsers;
  String emailUsers;
  String passwordUsers;
  // int tipeUserUsers;
  int isVerifPhoneUsers;
  int isVerifEmailUsers;
  int isGoogle;
  int timezoneId;
  String alias;
  int localization;
  String title;
  String locale;
  String urlSegment;

  ModelPengaturanAkun();

  ModelPengaturanAkun.fromJson(Map<String, dynamic> json) {
    phoneUsers = json['PhoneUsers'];
    emailUsers = json['EmailUsers'];
    passwordUsers = json['PasswordUsers'];
    // tipeUserUsers = json['TipeUserUsers'];
    isVerifPhoneUsers = json['IsVerifPhoneUsers'];
    isVerifEmailUsers = json['IsVerifEmailUsers'];
    isGoogle = json['IsGoogle'];
    timezoneId = json['TimezoneID'];
    alias = json['Alias'];
    localization = json['Localization'];
    title = json['Title'];
    locale = json['Locale'];
    urlSegment = json['URLSegment'];
  }
}