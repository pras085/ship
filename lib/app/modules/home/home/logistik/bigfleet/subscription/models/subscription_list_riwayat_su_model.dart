class SubscriptionListRiwayatSUModel {
  int orderID;
  String packetName;
  String periodeLangganan;
  String orderDate;
  String orderTime;
  int qtyPaidSubuser;
  int qtyFreeSubuser;
  int grandTotal;
  String docNumber;
  String paymentName;

  SubscriptionListRiwayatSUModel();

  SubscriptionListRiwayatSUModel.fromJson(Map<String, dynamic> json) {
    orderID = json['OrderID'];
    packetName = json['PacketName'];
    periodeLangganan = json['PeriodeLangganan'];
    orderDate = json['OrderDate'];
    orderTime = json['OrderTime'];
    qtyPaidSubuser = json['qtyPaidSubuser'];
    qtyFreeSubuser = json['qtyFreeSubuser'];
    grandTotal = json['GrandTotal'];
    docNumber = json['DocNumber'];
    paymentName = json['PaymentName'];
  }
}
