import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/peta_bf_tm/search_location_map_bf_tm_view.dart';
import 'package:muatmuat/app/modules/select_list_lokasi/select_list_lokasi_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/widgets/appbar_detail.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class SelectListLokasiView extends GetView<SelectListLokasiController> {
  double _heightAppBar = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back(result: controller.selectLokasi);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBarDetailProfil(
            type: 1,
              title: 'Atur Pin Lokasi',
              onClickBack: () {
                Get.back(result: controller.selectLokasi);
                return Future.value(false);
              }),
          // CustomedAppBar(
          //   title: 'Atur Pin Lokasi',
          //   centerTitle: false,
          //   preferredSize: Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
          // ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: Obx(
                () => FlutterMap(
                  mapController: controller.mapController,
                  options: MapOptions(
                      // center: LatLng(double.parse(controller.transporter.latitude),
                      //     double.parse(controller.transporter.longitude)),
                      center: GlobalVariable.centerMap,
                      zoom: GlobalVariable.zoomMap,
                      interactiveFlags: InteractiveFlag.none
                      // minZoom: 13.0,
                      // maxZoom: 13.0,
                      ),
                  layers: [
                    GlobalVariable.tileLayerOptions,
                    MarkerLayerOptions(markers: [
                      for (var index = 0; index < controller.selectLokasi.keys.length; index++)
                        Marker(
                          width: GlobalVariable.ratioWidth(Get.context) * 18,
                          height: GlobalVariable.ratioWidth(Get.context) * 24,
                          point: controller.selectLokasi.values.toList()[index]["Lokasi"],
                          builder: (ctx) => Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              SvgPicture.asset(
                                controller.selectLokasi.keys.length == 1 
                                    ? "assets/pin_truck_icon.svg" 
                                    : index == 0 
                                        ? "assets/marker_first.svg" 
                                        : "assets/marker_second.svg",
                                width: GlobalVariable.ratioWidth(Get.context) * 18,
                                height: GlobalVariable.ratioWidth(Get.context) * 24,
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 5),
                                  child: CustomText(controller.totalLokasi == 1 ? "" : (int.parse(controller.selectLokasi.keys.toList()[index]) + 1).toString(),
                                      color: index == 0 ? Color(ListColor.color4) : Colors.white, fontWeight: FontWeight.w600, fontSize: 8))
                            ],
                          ),
                        ),
                    ])
                  ],
                ),
              )),
              Container(
                margin: EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var index = 0; index < controller.totalLokasi; index++)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  SvgPicture.asset(
                                    controller.totalLokasi == 1 
                                        ? "assets/pin_truck_icon.svg" 
                                        : index == 0 
                                            ? "assets/pin_yellow_icon.svg" 
                                            : "assets/pin_blue_icon.svg",
                                    width: GlobalVariable.ratioWidth(Get.context) * 18,
                                    height: GlobalVariable.ratioWidth(Get.context) * 24,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 5),
                                    child: CustomText(
                                      controller.totalLokasi == 1 ? "" : (index + 1).toString(),
                                      color: index == 0 ? Color(ListColor.color4) : Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 8,
                                    ),
                                  )
                                ],
                              ),
                              Container(width: 8),
                              Expanded(
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    side: BorderSide(
                                      color: Color(ListColor.colorLightGrey2),
                                      width: 1,
                                    ),
                                  ),
                                  minWidth: 0,
                                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                  onPressed: () async {
                                    controller.onClickAddress(index);
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Obx(
                                      () => CustomText(
                                        controller.selectLokasi[index.toString()] == null
                                            ? "Pilih Lokasi"
                                            : controller.selectLokasi[index.toString()][controller.namaKey],
                                        color: controller.selectLokasi[index.toString()] == null ? Color(ListColor.colorLightGrey2) : Colors.black,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(width: 8),
                              GestureDetector(
                                onTap: () {
                                  controller.clearLokasi(index);
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Color(ListColor.colorDarkGrey3),
                                ),
                              )
                            ],
                          ),
                          controller.totalLokasi > 1 && index != (controller.totalLokasi - 1) ? Container(height: 10) : SizedBox.shrink()
                        ],
                      )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
