class ManajemenMitraGetCountModel {
  String label;
  String request;

  ManajemenMitraGetCountModel.fromJson(Map<String, dynamic> json) {
    label = json['Label'];
    request = json['Request'].toString();
  }
}
