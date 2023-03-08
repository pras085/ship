class StreetModel {
  String id;
  String title;
  int lev;

  StreetModel({this.id, this.title, this.lev});

  StreetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    lev = json['lev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['lev'] = this.lev;
    return data;
  }
}
