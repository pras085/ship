class MetodePembayaranModel {
  String paymentID;
  String paymentName;
  String noRek;
  String thumbnail;

  MetodePembayaranModel(
      {this.paymentID, this.paymentName, this.noRek, this.thumbnail});

  MetodePembayaranModel.fromJson(Map<String, dynamic> json) {
    paymentID = json['PaymentID'].toString();
    paymentName = json['PaymentName'].toString();
    noRek = json['NoRek'];
    thumbnail = json['Thumbnail'];
  }
}
