import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_list_lokasi/select_list_lokasi_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:latlong/latlong.dart';

class SelectListLokasiView extends GetView<SelectListLokasiController> {
  double _heightAppBar = AppBar().preferredSize.height;

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
                      child: Obx(
                        () => Text(
                          "Atur Lokasi " +
                              (controller.title.value == "lokasi"
                                  ? "Pickup"
                                  : "Bongkar"),
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                        zoom: 13.0,
                        interactiveFlags: InteractiveFlag.none
                        // minZoom: 13.0,
                        // maxZoom: 13.0,
                        ),
                    layers: [
                      TileLayerOptions(
                          urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c']),
                      MarkerLayerOptions(markers: [
                        for (var index = 0;
                            index < controller.selectLokasi.keys.length;
                            index++)
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: controller.selectLokasi.values
                                .toList()[index]["Lokasi"],
                            builder: (ctx) => Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                // Icon(
                                //   Icons.location_on,
                                //   color: Color(index == 0
                                //       ? ListColor.colorYellow
                                //       : ListColor.color4),
                                //   size: 30,
                                // ),
                                SvgPicture.asset(
                                  index == 0
                                      ? GlobalVariable.imagePath +
                                          "marker_first.svg"
                                      : GlobalVariable.imagePath +
                                          "marker_second.svg",
                                  width: 10,
                                  height: 25,
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Text(
                                        controller.totalLokasi == 1
                                            ? ""
                                            : (int.parse(controller
                                                        .selectLokasi.keys
                                                        .toList()[index]) +
                                                    1)
                                                .toString(),
                                        style: TextStyle(
                                            color: index == 0
                                                ? Color(ListColor.color4)
                                                : Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)))
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
                      for (var index = 0;
                          index < controller.totalLokasi;
                          index++)
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
                                      index == 0
                                          ? GlobalVariable.imagePath +
                                              "marker_first.svg"
                                          : GlobalVariable.imagePath +
                                              "marker_second.svg",
                                      width: 10,
                                      height: 25,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 2),
                                      child: Text(
                                          controller.totalLokasi == 1
                                              ? ""
                                              : (index + 1).toString(),
                                          style: TextStyle(
                                              color: index == 0
                                                  ? Color(ListColor.color4)
                                                  : Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                    )
                                  ],
                                ),
                                Container(width: 8),
                                Expanded(
                                    child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
                                            side: BorderSide(
                                                color: Colors.black, width: 1)),
                                        minWidth: 0,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 12),
                                        onPressed: () async {
                                          controller.onClickAddress(index);
                                        },
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Obx(() => Text(
                                              controller.selectLokasi[index.toString()] ==
                                                      null
                                                  ? "-- Pilih Lokasi --"
                                                  : controller.selectLokasi[
                                                          index.toString()]
                                                      [controller.namaKey],
                                              style: TextStyle(
                                                  color: controller.selectLokasi[
                                                              index
                                                                  .toString()] ==
                                                          null
                                                      ? Color(ListColor.colorGrey)
                                                      : Colors.black))),
                                        ))),
                                Container(width: 8),
                                GestureDetector(
                                    onTap: () {
                                      controller.clearLokasi(index);
                                    },
                                    child: Icon(Icons.close))
                              ],
                            ),
                            controller.totalLokasi > 1 &&
                                    index != (controller.totalLokasi - 1)
                                ? Container(height: 10)
                                : SizedBox.shrink()
                          ],
                        )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
