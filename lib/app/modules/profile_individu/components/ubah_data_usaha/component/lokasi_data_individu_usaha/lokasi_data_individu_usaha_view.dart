import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'lokasi_data_individu_usaha_controller.dart';

class LokasiUbahDataIndividuView extends GetView<LokasiUbahDataIndividuController> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back(result: controller.selectLokasi.value);
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 16),
                        child: ClipOval(
                          child: Material(
                              shape: CircleBorder(),
                              color: Color(ListColor.color4),
                              child: InkWell(
                                  onTap: () {
                                    Get.back(result: controller.selectLokasi.value);
                                  },
                                  child: Container(
                                      width: GlobalVariable.ratioWidth(Get.context) * 24,
                                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        size: GlobalVariable.ratioWidth(Get.context) * 12,
                                        color: Colors.white,
                                      ))))),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText("Atur Pin Lokasi", color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Obx(
                      () => FlutterMap(
                        mapController: controller.mapController,
                        options: MapOptions(center: GlobalVariable.centerMap, zoom: GlobalVariable.zoomMap, interactiveFlags: InteractiveFlag.none),
                        layers: [
                          GlobalVariable.tileLayerOptions,
                          MarkerLayerOptions(markers: [
                            for (var index = 0; index < controller.selectLokasi.keys.length; index++)
                              Marker(
                                width: 80.0,
                                height: 80.0,
                                point: controller.selectLokasi.values.toList()[index]["Lokasi"],
                                builder: (ctx) => Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    SvgPicture.asset(
                                      index == 0 ? "assets/pin_yellow_icon.svg" : "assets/pin_blue_icon.svg",
                                      width: GlobalVariable.ratioWidth(Get.context) * 15,
                                      height: GlobalVariable.ratioWidth(Get.context) * 20,
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 5),
                                        child: CustomText(
                                            controller.totalLokasi == 1 ? "" : (int.parse(controller.selectLokasi.keys.toList()[index]) + 1).toString(),
                                            color: index == 0 ? Color(ListColor.color4) : Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 7))
                                  ],
                                ),
                              ),
                          ])
                        ],
                      ),
                    )),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
                          topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20))),
                  padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 4, bottom: GlobalVariable.ratioWidth(Get.context) * 12),
                          width: GlobalVariable.ratioWidth(Get.context) * 38,
                          height: GlobalVariable.ratioWidth(Get.context) * 3,
                          color: Color(ListColor.colorLightGrey16)),
                      Container(
                        width: double.infinity,
                        height: GlobalVariable.ratioWidth(Get.context) * 24,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                  onTap: () {
                                    Get.back(result: controller.selectLokasi.value);
                                  },
                                  child: Container()),
                            ),
                            CustomText("Lokasi", fontSize: 14, fontWeight: FontWeight.w700, color: Color(ListColor.color4))
                          ],
                        ),
                      ),
                      Container(height: GlobalVariable.ratioWidth(Get.context) * 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 7),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (var index = 0; index < controller.totalLokasi; index++)
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
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
                                            width: GlobalVariable.ratioWidth(Get.context) * 15,
                                            height: GlobalVariable.ratioWidth(Get.context) * 20,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 5),
                                            child: CustomText(controller.totalLokasi == 1 ? "" : (index + 1).toString(),
                                                color: index == 0 ? Color(ListColor.color4) : Colors.white, fontWeight: FontWeight.w600, fontSize: 7),
                                          )
                                        ],
                                      ),
                                      controller.totalLokasi > 1 && index != (controller.totalLokasi - 1)
                                          // ? Container(height: 10)
                                          ? Dash(
                                              direction: Axis.vertical,
                                              length: GlobalVariable.ratioWidth(Get.context) * 20,
                                              dashLength: GlobalVariable.ratioWidth(Get.context) * 4,
                                              dashThickness: GlobalVariable.ratioWidth(Get.context) * 2,
                                              dashBorderRadius: 10,
                                              dashColor: Color(ListColor.colorLightGrey10),
                                            )
                                          : SizedBox.shrink()
                                    ],
                                  )
                              ],
                            ),
                            Container(width: GlobalVariable.ratioWidth(Get.context) * 9),
                            Expanded(
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
                                            Expanded(
                                                child: Container(
                                              height: GlobalVariable.ratioWidth(Get.context) * 28,
                                              child: MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
                                                      side: BorderSide(color: Color(ListColor.colorLightGrey2), width: 1)),
                                                  minWidth: 0,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: GlobalVariable.ratioWidth(Get.context) * 5,
                                                      horizontal: GlobalVariable.ratioWidth(Get.context) * 10),
                                                  onPressed: () async {
                                                    controller.onClickAddress(index);
                                                  },
                                                  child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Obx(() => CustomText(
                                                          controller.selectLokasi[index.toString()] == null
                                                              ? "Cari Alamat"
                                                              : controller.selectLokasi[index.toString()][controller.namaKey],
                                                          color: controller.selectLokasi[index.toString()] == null
                                                              ? Color(ListColor.colorLightGrey2)
                                                              : Colors.black,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        )),
                                                  )),
                                            )),
                                            Container(width: GlobalVariable.ratioWidth(Get.context) * 8),
                                            GestureDetector(
                                                onTap: () {
                                                  controller.clearLokasi(index);
                                                },
                                                child: Container())
                                          ],
                                        ),
                                        controller.totalLokasi > 1 && index != (controller.totalLokasi - 1)
                                            ? Container(height: GlobalVariable.ratioWidth(Get.context) * 12)
                                            : SizedBox.shrink()
                                      ],
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(height: GlobalVariable.ratioWidth(Get.context) * 10)
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
