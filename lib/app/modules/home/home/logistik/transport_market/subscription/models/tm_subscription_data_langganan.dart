class TMSubscriptionDataLanggananModel {
  int id;
  int paketID;
  String name;
  String packetStartDate;
  String packetEndDate;
  String periodeAwal;
  String periodeAkhir;
  String fullPeriodeAkhir;
  String fullNextPeriode;
  String nextPeriode;
  bool isAllowOrder;
  bool isExpired;
  int subUser;

  TMSubscriptionDataLanggananModel();

  TMSubscriptionDataLanggananModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    paketID = json['PaketID'];
    name = json['Name'];
    packetStartDate = json['PacketStartDate'];
    packetEndDate = json['PacketEndDate'];
    periodeAwal = json['PeriodeAwal'];
    periodeAkhir = json['PeriodeAkhir'];
    fullPeriodeAkhir = json['FullPeriodeAkhir'];
    fullNextPeriode = json['FullNextPeriode'];
    nextPeriode = json['NextPeriode'];
    isAllowOrder = json['IsAllowOrder'];
    isExpired = json['IsExpired'];
    subUser = json['SubUsers'];
  }
}
