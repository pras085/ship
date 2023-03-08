class TransporterAreaPickupFilterModel {
  String kategori;
  String id;
  String description;

  TransporterAreaPickupFilterModel(
      {this.kategori = "", this.id, this.description});

  TransporterAreaPickupFilterModel.fromJson(
      String getKategori, Map<String, dynamic> data) {
    kategori = getKategori;
    id = data["id"].toString();
    description = data["nama"].toString();
  }
}
