class TMMetodePembayaranModel {
  String paymentID;
  String paymentName;
  String noRek;
  String thumbnail;

  TMMetodePembayaranModel(
      {this.paymentID, this.paymentName, this.noRek, this.thumbnail});

  TMMetodePembayaranModel.fromJson(Map<String, dynamic> json) {
    paymentID = json['PaymentID'].toString();
    paymentName = json['PaymentName'].toString();
    noRek = json['NoRek'];
    thumbnail = json['Thumbnail'];
  }
}
