class TMSubscriptionDetailPaketModel {
  String name;
  int jumlah;
  int harga;
  String tipe;
  String periode;

  TMSubscriptionDetailPaketModel();

  TMSubscriptionDetailPaketModel.fromJson(Map<String, dynamic> json) {
    name = json['PacketName'];
    jumlah = json['PacketQty'];
    harga = json['PacketPrice'];
    tipe = json['PacketTypeStr'];
    periode = json['ActivePeriod'];
  }
}
