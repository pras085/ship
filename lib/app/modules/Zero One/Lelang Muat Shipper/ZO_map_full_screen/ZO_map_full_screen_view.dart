import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_full_screen/ZO_map_full_screen_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ZoMapFullScreenView extends GetView<ZoMapFullScreenController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {},
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(64),
            child: Container(
              height: 64,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ], color: Colors.white),
              child: Stack(alignment: Alignment.bottomCenter, children: [
                Column(mainAxisSize: MainAxisSize.max, children: [
                  Container(
                    height: 64,
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          child: ClipOval(
                            child: Material(
                                shape: CircleBorder(),
                                color: Color(ListColor.color4),
                                child: InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                        width: GlobalVariable.ratioFontSize(
                                                context) *
                                            28,
                                        height: GlobalVariable.ratioFontSize(
                                                context) *
                                            28,
                                        child: Center(
                                            child: Icon(
                                          Icons.arrow_back_ios_rounded,
                                          size: GlobalVariable.ratioFontSize(
                                                  context) *
                                              19,
                                          color: Colors.white,
                                        ))))),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          child: Center(
                            child: CustomText(
                              "LelangMuatDetailLelangDetailLelangLabelTitleOpenMap"
                                  .tr,
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  GlobalVariable.ratioFontSize(context) * 14,
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ]),
              ]),
            ),
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 50,
                  child: buildMap(context)),
              lokasiDetail(),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Obx(
              //     () => controller.loadList.value
              //         ? Container(
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.only(
              //                     topLeft: Radius.circular(12),
              //                     topRight: Radius.circular(12)),
              //                 color: Colors.white),
              //             width: MediaQuery.of(context).size.width,
              //             // height: 100,
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Container(
              //                   margin: EdgeInsets.only(right: 20),
              //                   child: SizedBox(
              //                       width: 30,
              //                       height: 30,
              //                       child: CircularProgressIndicator()),
              //                 ),
              //                 CustomText("Loading"),
              //               ],
              //             ))
              //         : SlidingUpPanel(
              //             backdropEnabled: false,
              //             maxHeight: MediaQuery.of(context).size.height * 0.6,
              //             borderRadius: BorderRadius.only(
              //                 topLeft: Radius.circular(12),
              //                 topRight: Radius.circular(12)),
              //             collapsed: Container(
              //                 decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.only(
              //                         topLeft: Radius.circular(12),
              //                         topRight: Radius.circular(12)),
              //                     color: Colors.white),
              //                 width: MediaQuery.of(context).size.width,
              //                 // height: 500,
              //                 child: Center(
              //                   child: CustomText(
              //                     "^ Slide Up",
              //                     fontSize:
              //                         GlobalVariable.ratioWidth(context) * 14,
              //                     fontWeight: FontWeight.w700,
              //                     color: Color(ListColor.colorBlue),
              //                     textAlign: TextAlign.center,
              //                   ),
              //                 )),
              //             panel: Container(
              //               padding: EdgeInsets.fromLTRB(
              //                 GlobalVariable.ratioWidth(context) * 16,
              //                 GlobalVariable.ratioWidth(context) * 22,
              //                 GlobalVariable.ratioWidth(context) * 16,
              //                 GlobalVariable.ratioWidth(context) * 0,
              //               ),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 children: [
              //                   Center(
              //                     child: CustomText(
              //                       controller.title.value,
              //                       fontSize:
              //                           GlobalVariable.ratioWidth(context) * 14,
              //                       fontWeight: FontWeight.w700,
              //                       color: Color(ListColor.colorBlue),
              //                       textAlign: TextAlign.center,
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     height:
              //                         GlobalVariable.ratioWidth(context) * 34,
              //                   ),
              //                   ListView.builder(
              //                     shrinkWrap: true,
              //                     itemCount:
              //                         controller.listDataMap.value.length,
              //                     itemBuilder: (content, index) {
              //                       return Container(
              //                         child: Column(
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.start,
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.start,
              //                           children: [
              //                             Row(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.start,
              //                               children: [
              //                                 Column(
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                   mainAxisAlignment:
              //                                       MainAxisAlignment.start,
              //                                   children: [
              //                                     if (controller.listDataMap
              //                                             .value.length >
              //                                         1)
              //                                       Container(
              //                                         child: SvgPicture.asset(
              //                                           controller.iconLocation[
              //                                               index],
              //                                           width: GlobalVariable
              //                                                   .ratioWidth(Get
              //                                                       .context) *
              //                                               24,
              //                                           height: GlobalVariable
              //                                                   .ratioWidth(Get
              //                                                       .context) *
              //                                               24,
              //                                         ),
              //                                       )
              //                                     else
              //                                       Container(
              //                                         child: SvgPicture.asset(
              //                                           "assets/pin_kuning_satu_lokasi.svg",
              //                                           width: GlobalVariable
              //                                                   .ratioWidth(Get
              //                                                       .context) *
              //                                               24,
              //                                           height: GlobalVariable
              //                                                   .ratioWidth(Get
              //                                                       .context) *
              //                                               24,
              //                                         ),
              //                                       ),
              //                                     if (controller.listDataMap
              //                                                 .value.length -
              //                                             1 !=
              //                                         index)
              //                                       Padding(
              //                                         padding: EdgeInsets.only(
              //                                             left: GlobalVariable
              //                                                     .ratioWidth(
              //                                                         context) *
              //                                                 10),
              //                                         child: Container(
              //                                           child: SvgPicture.asset(
              //                                             "assets/garis_alur_perjalanan.svg",
              //                                             // width: GlobalVariable.ratioWidth(Get.context) * 12,
              //                                             height: GlobalVariable
              //                                                     .ratioWidth(Get
              //                                                         .context) *
              //                                                 34,
              //                                           ),
              //                                         ),
              //                                       ),
              //                                   ],
              //                                 ),
              //                                 SizedBox(
              //                                   width:
              //                                       GlobalVariable.ratioWidth(
              //                                               context) *
              //                                           15,
              //                                 ),
              //                                 Expanded(
              //                                   child: CustomText(
              //                                     controller.listDataMap
              //                                         .value[index]["Address"],
              //                                     fontSize:
              //                                         GlobalVariable.ratioWidth(
              //                                                 context) *
              //                                             14,
              //                                     fontWeight: FontWeight.w600,
              //                                   ),
              //                                 )
              //                               ],
              //                             ),
              //                             SizedBox(
              //                               height: GlobalVariable.ratioWidth(
              //                                       context) *
              //                                   12,
              //                             )
              //                           ],
              //                         ),
              //                       );
              //                     },
              //                   ),
              //                 ],
              //               ),
              //             )),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMap(BuildContext context) {
    return Obx(
      () => FlutterMap(
        mapController: controller.mapController,
        options: MapOptions(
          center: controller.listDataMap.value.length != 0
              ? LatLng(
                  double.parse(
                      controller.listDataMap.value[0]["Latitude"] == null
                          ? "0"
                          : controller.listDataMap.value[0]["Latitude"]),
                  double.parse(
                      controller.listDataMap.value[0]["Longitude"] == null
                          ? "0"
                          : controller.listDataMap.value[0]["Longitude"]))
              : LatLng(0, 0),
          zoom: controller.listDataMap.value.length > 1 ? 5.0 : 10.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(
            markers: [
              if (controller.listDataMap.value.length > 1)
                for (var idx = 0;
                    idx < controller.listDataMap.value.length;
                    idx++)
                  Marker(
                    width: GlobalVariable.ratioFontSize(context) * 26.27,
                    height: GlobalVariable.ratioFontSize(context) * 34,
                    point: LatLng(
                        double.parse(controller.listDataMap.value[idx]
                                    ["Latitude"] ==
                                null
                            ? "0"
                            : controller.listDataMap.value[idx]["Latitude"]),
                        double.parse(controller.listDataMap.value[idx]
                                    ["Longitude"] ==
                                null
                            ? "0"
                            : controller.listDataMap.value[idx]["Longitude"])),
                    builder: (ctx) => Container(
                      child: SvgPicture.asset(
                        controller.iconLocation[idx],
                      ),
                    ),
                  )
              else if (controller.listDataMap.value.length != 0)
                Marker(
                  width: GlobalVariable.ratioFontSize(context) * 26.27,
                  height: GlobalVariable.ratioFontSize(context) * 34,
                  point: LatLng(
                      double.parse(
                          controller.listDataMap.value[0]["Latitude"] == null
                              ? "0"
                              : controller.listDataMap.value[0]["Latitude"]),
                      double.parse(
                          controller.listDataMap.value[0]["Longitude"] == null
                              ? "0"
                              : controller.listDataMap.value[0]["Longitude"])),
                  builder: (ctx) => Container(
                    child: SvgPicture.asset(
                      "assets/pin7.svg",
                    ),
                  ),
                )
            ],
          ),
          // PolylineLayerOptions(polylines: [
          //   Polyline(
          //       points: controller.listRoute.value,
          //       strokeWidth: 4,
          //       color: Colors.purple)
          // ])
        ],
      ),
    );
  }

  lokasiDetail() {
    return Container(
        width: MediaQuery.of(Get.context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 4,
              ),
              height: GlobalVariable.ratioWidth(Get.context) * 3,
              width: GlobalVariable.ratioWidth(Get.context) * 38,
              color: Color(ListColor.colorLightGrey16),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 13,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: CustomText(
                      controller.title.value,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                      fontWeight: FontWeight.w700,
                      color: Color(ListColor.colorBlue),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: GlobalVariable.ratioWidth(Get.context) * 34,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.listDataMap.value.length,
                    itemBuilder: (content, index) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (controller.listDataMap.value.length > 1)
                                      Container(
                                        child: SvgPicture.asset(
                                          controller.iconLocation[index],
                                          width: GlobalVariable.ratioFontSize(
                                                  Get.context) *
                                              28,
                                          height: GlobalVariable.ratioFontSize(
                                                  Get.context) *
                                              28,
                                        ),
                                      )
                                    else
                                      Container(
                                        child: SvgPicture.asset(
                                          "assets/pin7.svg",
                                          width: GlobalVariable.ratioFontSize(
                                                  Get.context) *
                                              28,
                                          height: GlobalVariable.ratioFontSize(
                                                  Get.context) *
                                              28,
                                        ),
                                      ),
                                    if (controller.listDataMap.value.length -
                                            1 !=
                                        index)
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: GlobalVariable.ratioFontSize(
                                                    Get.context) *
                                                13),
                                        child: Container(
                                          child: SvgPicture.asset(
                                            "assets/garis_alur_perjalanan.svg",
                                            // width: GlobalVariable.ratioWidth(Get.context) * 12,
                                            height:
                                                GlobalVariable.ratioFontSize(
                                                        Get.context) *
                                                    30,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15,
                                ),
                                Expanded(
                                  child: CustomText(
                                    controller.listDataMap.value[index]
                                        ["Address"],
                                    fontSize: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 0,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
