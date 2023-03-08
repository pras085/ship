class GroupMitraModel {
  String id;
  String name;
  String description;
  bool status;
  String totalPartner;
  String avatar;
  bool isDelete;
  GroupMitraModel(
      {this.id,
      this.name,
      this.description,
      this.status,
      this.totalPartner,
      this.avatar,
      this.isDelete});

  Map<String, dynamic> toMap() {
    return {
      'GroupID': id,
      'Name': name,
      'Description': description,
      'StatusInt': status ? "1" : "0",
      'QtyMitra': totalPartner,
      'Avatar': avatar,
      'IsDelete': isDelete ? "1" : "0"
    };
  }

  GroupMitraModel.fromJson(Map<String, dynamic> json) {
    id = json['GroupID'].toString();
    name = json['Name'];
    description = json['Description'];
    status = json['StatusInt'].toString() == "1";
    totalPartner = json['QtyMitra'].toString();
    avatar = json['Avatar'];
    isDelete = json['IsDelete'].toString() == "1";
  }
}
