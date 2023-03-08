class LangkahPembayaranModel {
  String langkahPembayaranID;
  String paragraph;
  String descriptionID;

  LangkahPembayaranModel(
      {this.langkahPembayaranID, this.paragraph, this.descriptionID});

  LangkahPembayaranModel.fromJson(Map<String, dynamic> json) {
    langkahPembayaranID = json['ID'].toString();
    paragraph = json['Paragraph'].toString();
    descriptionID = json['DescriptionID'];
  }
}
