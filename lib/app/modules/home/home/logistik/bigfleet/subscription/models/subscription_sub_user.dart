class SubscriptionSubUserModel {
  String startDate;
  String endDate;
  String fullStartDate;
  String fullEndDate;
  int quota;
  int used;
  int notUsed;
  bool isRange;

  SubscriptionSubUserModel();

  SubscriptionSubUserModel.fromJson(Map<String, dynamic> json) {
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    fullStartDate = json['FullStartDate'];
    fullEndDate = json['FullEndDate'];
    quota = json['Quota'];
    used = json['Used'];
    notUsed = json['NotUsed'];
    isRange = json['IsRange'];
  }
}
