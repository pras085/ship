class HistorySearchModel {
  String name;
  int dateSearchEpoch;

  HistorySearchModel({this.name, this.dateSearchEpoch}) {
    dateSearchEpoch = dateSearchEpoch ?? DateTime.now().millisecondsSinceEpoch;
  }

  factory HistorySearchModel.fromJson(dynamic json) {
    return HistorySearchModel(
        name: json['name'], dateSearchEpoch: json['dateSearchEpoch']);
  }

  Map toJson() {
    return {'name': name, 'dateSearchEpoch': dateSearchEpoch};
  }
}
