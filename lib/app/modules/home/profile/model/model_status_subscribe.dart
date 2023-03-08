class StatusSubscribe {
  int isSubscribeBF;
  int isSubscribeTM;
  int isVerifBF;
  int isVerifTM;
  int isNextBF;
  int isNextTM;
  int userLevel;

  StatusSubscribe();

  StatusSubscribe.fromJson(Map<String, dynamic> json) {
    isSubscribeBF = json['IsSubscribeBF'];
    isSubscribeTM = json['IsSubscribeTM'];
    isVerifBF = json['IsVerifBF'];
    isVerifTM = json['IsVerifTM'];
    isNextBF = json['IsNextBF'];
    isNextTM = json['IsNextTM'];
    userLevel = json['UserLevel'];
  }
}