import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/map_management_lokasi/map_management_lokasi_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class MapManagementLokasiView extends GetView<MapManagementLokasiController> {
  double _heightAppBar = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
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
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 16),
                      child: ClipOval(
                        child: Material(
                            shape: CircleBorder(),
                            color: Color(ListColor.color4),
                            child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    width: 30,
                                    height: 30,
                                    child: Center(
                                        child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      size: 20,
                                      color: Colors.white,
                                    ))))),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      'LocationManagementLabelLihatPeta'.tr,
                      color: Color(ListColor.colorDarkGrey3),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned.fill(
                  child: Obx(
                () => FlutterMap(
                  mapController: controller.mapController,
                  options: MapOptions(
                      zoom: GlobalVariable.zoomMap,
                      interactiveFlags:
                          InteractiveFlag.all & ~InteractiveFlag.rotate),
                  layers: [
                    GlobalVariable.tileLayerOptions,
                    MarkerLayerOptions(markers: [
                      Marker(
                        width: 40.0,
                        height: 40.0,
                        point: controller.selectLokasi["Lokasi"],
                        anchorPos: AnchorPos.align(AnchorAlign.top),
                        builder: (ctx) => SvgPicture.asset(
                          "assets/pin_truck_icon.svg",
                          width: 14,
                          height: 35,
                        ),
                      ),
                    ])
                  ],
                ),
              )),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                          color: Colors.white,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      top: GlobalVariable.ratioHeight(
                                              Get.context) *
                                          7),
                                  color: Color(ListColor.colorLightGrey16),
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          38,
                                  height:
                                      GlobalVariable.ratioHeight(Get.context) *
                                          3),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: GlobalVariable.ratioHeight(
                                              Get.context) *
                                          14,
                                      bottom: GlobalVariable.ratioHeight(
                                              Get.context) *
                                          7),
                                  child: CustomText(
                                    "LocationManagementLabelLocationMap".tr,
                                    color: Color(ListColor.color4),
                                    fontWeight: FontWeight.w700,
                                  )),
                              GestureDetector(
                                onTap: () async {
                                  controller.onClickAddress();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          17,
                                      vertical: GlobalVariable.ratioHeight(
                                              Get.context) *
                                          17),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/pin_truck_icon.svg",
                                        width: 14,
                                        height: 35,
                                      ),
                                      Container(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              15),
                                      Expanded(
                                          child: Obx(() => CustomText(
                                              controller.selectLokasi[
                                                  controller.namaKey],
                                              color: Color(
                                                  ListColor.colorLightGrey4),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              height: 1.2))),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                      ))),
            ],
          )),
    );
  }
}
