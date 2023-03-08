import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/manajemen_lokasi_model.dart';
import 'package:muatmuat/global_variable.dart';

class DetailManajemenLokasiModel {
  ManajemenLokasiModel manajemenLokasiModel;
  String notes;
  final String role = "2";

  DetailManajemenLokasiModel({this.manajemenLokasiModel, this.notes});

  DetailManajemenLokasiModel.fromJson(dynamic json) {
    manajemenLokasiModel =
        ManajemenLokasiModel.fromJson(json, docIDParamName: "DocID");
    notes = json["Notes"];
  }

  Map toJson() {
    var map = {};
    map.addAll(manajemenLokasiModel.toJson());
    map["Notes"] = notes;
    map["Role"] = role;
    map["UsersID"] = GlobalVariable.userModelGlobal.docID;
    return map;
  }
}
