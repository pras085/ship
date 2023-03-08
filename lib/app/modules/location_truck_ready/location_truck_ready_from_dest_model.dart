import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

class LocationTruckReadyFromDestModel {
  @required
  final String title;
  @required
  final LatLng latLng;
  @required
  final String urlMarker;
  @required
  final String address;
  @required
  final double widthHeightMarker;

  LocationTruckReadyFromDestModel({
    this.title,
    this.latLng,
    this.urlMarker,
    this.address,
    this.widthHeightMarker,
  });
}
