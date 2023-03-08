import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';

class MapDetailTransporterController extends GetxController {
  //TODO: Implement MapDetailTransporterController

  final mapController = MapController().obs;
  PopupController popupController = PopupController();
  final listMarker = [].obs;

  String address = "";
  LatLng latLng;
  bool _isFirstInitial = false;

  @override
  void onInit() {
    latLng = Get.arguments[0];
    address = Get.arguments[1];
    _setMarker();
    mapController.value.onReady.then((value) => popupController.togglePopup(listMarker[0]));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onCompleteBuildWidget() {
    if (!_isFirstInitial) {
      _isFirstInitial = true;
      _setCameraFitBoundsDefault();
    }
  }

  Future _setCameraFitBoundsDefault() async {
    await mapController.value.onReady;
    _setCameraFitBoundsCustom(
        (MediaQuery.of(Get.context).size.height * 0.4) + 30, [latLng]);
  }

  Future _setCameraFitBoundsCustom(
      double paddingBottom, List<LatLng> points) async {
    await mapController.value.onReady;
    mapController.value.fitBounds(LatLngBounds.fromPoints(points),
        options: FitBoundsOptions(padding: EdgeInsets.all(20)));
  }

  void _setMarker() {
    listMarker.add(
      Marker(
          width: 60,
          height: 60,
          point: latLng,
          anchorPos: AnchorPos.align(AnchorAlign.top),
          builder: (ctx) => Container(
              child: SvgPicture.asset("assets/marker_transporter_icon.svg",
                  width: 50, height: 50))
          // child: Transform.translate(
          //   offset: Offset(0, -20),
          //   child: Image(
          //     image: AssetImage(
          //         "assets/" + listLocationTruckReadyResultModel[i].urlMarker),
          //     width: listLocationTruckReadyResultModel[i].widthHeightMarker,
          //     height: listLocationTruckReadyResultModel[i].widthHeightMarker,
          //   ),
          // ),
          ),
    );
  }
}
