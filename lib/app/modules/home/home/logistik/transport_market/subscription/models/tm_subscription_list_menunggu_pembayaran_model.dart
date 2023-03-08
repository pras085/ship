class TMSubscriptionListMenungguPembayaranModel {
  int orderID;
  String packetName;

  ///packetType 0 layanan
  ///packetType 1 sub user
  int packetType;
  String orderDate;
  String orderTime;
  int grandTotal;
  String paymentName;
  String paymentExpired;

  TMSubscriptionListMenungguPembayaranModel();

  TMSubscriptionListMenungguPembayaranModel.fromJson(
      Map<String, dynamic> json) {
    orderID = json['ID'];
    packetName = json['PacketName'];
    packetType = json['PacketType'];
    orderDate = json['OrderDateOnly'];
    orderTime = json['OrderTimeOnly'];
    grandTotal = json['GrandTotal'];
    paymentName = json['PaymentName'];
    paymentExpired = json['PaymentExpired'];
  }
}
