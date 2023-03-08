class DistrictDataModel {
  String districtid;

  DistrictDataModel({this.districtid});

  DistrictDataModel.fromJson(Map<String, dynamic> data) {
    districtid = data['districtid'];
  }
}