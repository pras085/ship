import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:latlong/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapManagementLokasiController extends GetxController
    with SingleGetTickerProviderMixin {
  var selectLokasi = Map().obs;
  var mapController = MapController();

  final String namaKey = "Nama";
  final String lokasiKey = "Lokasi";

  var panelController = PanelController();
  var zoom = 16.0;
  var animationDuration = 1000;

  @override
  void onInit() {
    selectLokasi.value = Get.arguments[0];
    updateMap();
  }

  void updateMap() async {
    await mapController.onReady;
    var markerBounds = LatLngBounds();
    markerBounds.extend(selectLokasi[lokasiKey]);
    if (markerBounds.isValid) {
      mapController.fitBounds(markerBounds,
          options: FitBoundsOptions(padding: EdgeInsets.all(40)));
    }
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void onClickAddress() async {
    panelController.close();
    mapController.onReady.then((value) => animateMove());
  }

  void animateMove() {
    LatLng latLng = selectLokasi.value != null ? selectLokasi[lokasiKey] : null;
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: latLng.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: latLng.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: zoom);

    var animationController = AnimationController(
        duration: Duration(milliseconds: animationDuration), vsync: this);
    Animation animation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animationController.addListener(() {
      mapController.move(
          LatLng(latTween.evaluate(animationController),
              lngTween.evaluate(animationController)),
          zoomTween.evaluate(animationController));
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        animationController.dispose();
      }
    });
    animationController.forward();
  }
}
