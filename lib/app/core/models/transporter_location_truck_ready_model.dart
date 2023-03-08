import 'package:latlong/latlong.dart';

class TransporterLocationTruckReadyModel {
  String name;
  String address;
  int qty;
  int qtyOpen;
  String head;
  String carrier;
  String serviceArea;
  LatLng latLng;

  TransporterLocationTruckReadyModel.fromJson(Map<String, dynamic> response) {
    name = response['Name'];
    address = response['Address'];
    qty = response['Qty'];
    qtyOpen = response['QtyOpen'];
    head = response['Head'];
    carrier = response['Carrier'];
    serviceArea = response['AreaLayanan'];
    latLng = LatLng(response['Lat'].toDouble(), response['Lng'].toDouble());
  }
}
