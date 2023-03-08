class SubscriptionListRiwayatBFModel {
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
  String packetType;
  String invNumber;

  SubscriptionListRiwayatBFModel();

  SubscriptionListRiwayatBFModel.fromJson(Map<String, dynamic> json) {
    orderID = json['OrderID'];
    packetName = json['PacketName'];
    periodeLangganan = json['PeriodeLangganan'];
    orderDate = json['OrderDate'];
    orderTime = json['OrderTime'];
    qtyPaidSubuser = json['QtyPaidSubuser'];
    qtyFreeSubuser = json['QtyFreeSubuser'];
    grandTotal = json['GrandTotal'];
    docNumber = json['DocNumber'];
    paymentName = json['PaymentName'];
    packetType = json['PacketType'];
    invNumber = json['InvNumber'];
  }
}
