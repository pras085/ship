import 'package:muatmuat/app/modules/location_truck_ready/location_truck_ready_result_model.dart';
import 'package:latlong/latlong.dart';

class LocationTruckReadyResultPerDistrictModel {
  String idDistrict;
  String districtName;
  List<LocationTruckReadyResultModel> listTransporterLocation = [];
  LatLng centerLatLng;

  LocationTruckReadyResultPerDistrictModel(
      {this.idDistrict, this.districtName, this.centerLatLng});
}
