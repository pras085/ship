class SubscriptionListRiwayatPesananModel {
  int orderID;
  String packetName;

  ///packetType 0 layanan
  ///packetType 1 sub user
  int packetType;
  String orderDate;
  String orderTime;
  int grandTotal;
  String paymentName;

  ///status pesanan 0 mengunggu pembayaran
  ///status pesanan 1 pembayaran diterima
  ///status pesanan 2 pembayaran dibatalkan
  ///status pesanan 3 pembayaran kadaluarsa
  int status;

  SubscriptionListRiwayatPesananModel();

  SubscriptionListRiwayatPesananModel.fromJson(Map<String, dynamic> json) {
    orderID = json['ID'];
    packetName = json['PacketName'];
    packetType = json['PacketType'];
    orderDate = json['OrderCreateDate'] ?? "";
    orderTime = json['OrderCreateTime'] ?? "";
    grandTotal = json['GrandTotal'];
    paymentName = json['PaymentName'];
    status = json['Status'];
  }
}
