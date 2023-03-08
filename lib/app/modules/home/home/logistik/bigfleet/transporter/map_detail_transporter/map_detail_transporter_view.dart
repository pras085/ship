import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import 'package:get/get.dart';

import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/map_detail_transporter/map_detail_transporter_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class MapDetailTransporterView extends GetView<MapDetailTransporterController> {
  double _heightAppBar = AppBar().preferredSize.height;
  double _getWidthOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.width;
  double _getHeightOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double _getSizeSmallestWidthHeight(BuildContext context) =>
      _getWidthOfScreen(context) < _getHeightOfScreen(context)
          ? _getWidthOfScreen(context)
          : _getHeightOfScreen(context);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(_heightAppBar),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: ClipOval(
                      child: Material(
                          shape: CircleBorder(),
                          color: Color(ListColor.color4),
                          child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                  width: _heightAppBar - 10,
                                  height: _heightAppBar - 10,
                                  child: Center(
                                      child: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    size: (_heightAppBar - 20) * 0.7,
                                    color: Colors.white,
                                  ))))),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomText('DetailTransporterMapAppBarTitle'.tr,
                      color: Colors.black, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [
                Positioned.fill(child: _buildMap(context)),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      margin: EdgeInsets.only(right: 20, bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          controller.mapController.value.onReady.then((value) =>
                              controller.mapController.value.move(
                                  (controller.listMarker[0] as Marker).point,
                                  18.0));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.location_searching,
                                color: Color(ListColor.color4))),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMap(BuildContext context) {
    return FlutterMap(
      mapController: controller.mapController.value,
      options: MapOptions(
          interactiveFlags: InteractiveFlag.pinchMove |
              InteractiveFlag.pinchZoom |
              InteractiveFlag.drag,
          maxZoom: 18.0,
          plugins: [PopupMarkerPlugin()],
          onTap: (_) {
            controller.popupController.hidePopup();
          }),
      layers: [
        GlobalVariable.tileLayerOptions,
        PopupMarkerLayerOptions(
            markers: controller.listMarker
                .map<Marker>((data) => data as Marker)
                .toList(),
            popupSnap: PopupSnap.markerTop,
            popupController: controller.popupController,
            popupBuilder: (_, marker) {
              return Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 40,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: CustomText(controller.address));
            }),
      ],
    );
  }
}
