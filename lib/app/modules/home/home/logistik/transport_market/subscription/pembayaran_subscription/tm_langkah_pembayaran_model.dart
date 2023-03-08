class TMLangkahPembayaranModel {
  String langkahPembayaranID;
  String paragraph;
  String descriptionID;

  TMLangkahPembayaranModel(
      {this.langkahPembayaranID, this.paragraph, this.descriptionID});

  TMLangkahPembayaranModel.fromJson(Map<String, dynamic> json) {
    langkahPembayaranID = json['ID'].toString();
    paragraph = json['Paragraph'].toString();
    descriptionID = json['DescriptionID'];
  }
}
