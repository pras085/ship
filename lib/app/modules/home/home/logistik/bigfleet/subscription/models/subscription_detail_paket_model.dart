class SubscriptionDetailPaketModel {
  String name;
  int jumlah;
  int harga;
  String tipe;
  String periode;

  SubscriptionDetailPaketModel();

  SubscriptionDetailPaketModel.fromJson(Map<String, dynamic> json) {
    name = json['PacketName'];
    jumlah = json['PacketQty'];
    harga = json['PacketPrice'];
    tipe = json['PacketTypeStr'];
    periode = json['ActivePeriod'];
  }
}
