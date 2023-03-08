import 'dart:async';
import 'dart:math';

import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/maps_function.dart';

class FindTruckController extends GetxController {
  var listTruck = List<LatLng>().obs;
  var loadList = true.obs;
  var closestTruck = 0.obs;
  var closeDistance = 0.0.obs;
  var currentLocation = LatLng(0, 0).obs;
  var listRoute = List<LatLng>().obs;
  var location = Location();
  var mapController = MapController();

  @override
  void onInit() {
    listTruck.clear();
    closestTruck.value = null;
    var rng = Random();
    var min = 4;
    var max = 10;
    var randomNumber = min + rng.nextInt(max - min);
    for (var i = 0; i < randomNumber; i++) {
      var randomLat = 51.5 + rng.nextDouble();
      var randomLng = -0.09 + rng.nextDouble();
      listTruck.add(LatLng(randomLat, randomLng));
    }
    listTruck.value.forEach((truck) {
      var tempDistance = MapFunction.calculateDistance(
          51.5, -0.09, truck.latitude, truck.longitude);
      if (!closestTruck.value.isNullOrBlank) {
        if (tempDistance < closeDistance.value) {
          closestTruck.value = listTruck.indexOf(truck);
          closeDistance.value = tempDistance;
        }
      } else {
        closestTruck.value = listTruck.indexOf(truck);
        closeDistance.value = tempDistance;
      }
    });
    Timer(Duration(seconds: 3), () async {
      loadList.value = false;
      listRoute.clear();
      // listRoute.add(LatLng(51.5, -0.09));
      // listRoute.add(LatLng(52.5, -0.29));
      // listRoute.add(LatLng(53.5, 1.09));
    });
    location.onLocationChanged.listen((LocationData current) {
      if (current.accuracy < 50) {
        currentLocation.value = LatLng(current.latitude, current.longitude);
        mapController.move(currentLocation.value, 17.7);
      }
    });
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
}
