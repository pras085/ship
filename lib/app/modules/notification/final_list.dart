import 'package:muatmuat/app/modules/notification/notif_controller.dart';

class SupportingData {
  num notreadcount;
  num realcountdata;
  num countdata;

  SupportingData({
    this.notreadcount,
    this.realcountdata,
    this.countdata
  });

  SupportingData.fromJson(Map<String, dynamic> json)
  : notreadcount = json['NotReadCount'],
    realcountdata = json['RealCountData'],
    countdata = json['CountData'];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'notreadcount': notreadcount,
      'realcountdata': realcountdata,
      'countdata' : countdata,
    };
    return map;
}
  SupportingData.fromMap(Map<String, dynamic> map) {
    notreadcount = map['notreadcount'];
    realcountdata = map['realcountdata'];
    countdata = map['countdata'];
  }

   @override
  String toString() {
    return "Supportingdata(notreadcount: $notreadcount, realcountdata: $realcountdata, countdata: $countdata)";
  }
}

class FinalList {
  num id;
  String judul;
  String deskripsi;
  num statusread;
  String timenotif;

  FinalList({this.id, this.judul, this.deskripsi, this.timenotif});
  FinalList.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        judul = json['Judul'],
        deskripsi = json['Deskripsi'],
        statusread = json['status_read'],
        timenotif = json['time_notif'];
  
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'judul': judul,
      'deskripsi' : deskripsi,
      'statusread' : statusread,
      'timenotif' : timenotif,
    };
    return map;
  }

  FinalList.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    judul = map['judul'];
    deskripsi = map['deskripsi'];
    statusread = map['statusread'];
    timenotif = map['timenotif'];
  }

   @override
  String toString() {
    return "FinalList(id: $id, qty: $judul, description: $deskripsi)";
  }
}