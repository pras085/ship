import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

class LocationTruckReadyResultModel {
  @required
  final String idTransporter;
  @required
  final String title;
  @required
  final String typeOfTransporter;
  @required
  final LatLng latLng;
  @required
  final String urlMarker;
  @required
  final String address;
  @required
  final double widthHeightMarker;
  @required
  final String locationNameTransporter;
  final String locationNameDestination;
  @required
  final String idTypeOfTruck;
  @required
  final String typeOfTruckName;
  @required
  final int numberOfTruck;
  final String lastUpdate;
  final String idDistrict;
  final String districtName;

  LocationTruckReadyResultModel(
      {this.idTransporter,
      this.title,
      this.typeOfTransporter,
      this.latLng,
      this.urlMarker,
      this.widthHeightMarker,
      this.address,
      this.locationNameTransporter,
      this.locationNameDestination = "-",
      this.idTypeOfTruck,
      this.typeOfTruckName,
      this.numberOfTruck,
      this.lastUpdate,
      this.idDistrict,
      this.districtName});
}
