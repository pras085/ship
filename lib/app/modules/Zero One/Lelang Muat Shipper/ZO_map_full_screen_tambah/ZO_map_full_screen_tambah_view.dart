import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_full_screen_tambah/ZO_map_full_screen_tambah_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ZoMapFullScreenTambahView
    extends GetView<ZoMapFullScreenTambahController> {
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () {},
          child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                      offset: Offset(0, 8)),
                ], color: Colors.white),
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  // Obx(
                  //   () =>
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5),
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
                                            // Get.back();
                                            controller.onApplyButton();
                                          },
                                          child: Container(
                                              width:
                                                  GlobalVariable.ratioFontSize(
                                                          context) *
                                                      28,
                                              height:
                                                  GlobalVariable.ratioFontSize(
                                                          context) *
                                                      28,
                                              child: Center(
                                                  child: Icon(
                                                Icons.arrow_back_ios_rounded,
                                                size: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    19,
                                                color: Colors.white,
                                              ))))),
                                ),
                              ),
                              SizedBox(
                                width: GlobalVariable.ratioWidth(context) * 14,
                              ),
                              Expanded(
                                child:
                                    // Obx(
                                    //   () =>
                                    Center(
                                  child: CustomText(
                                      // controller.informationMarker.value
                                      //     .formattedAddress,
                                      "LelangMuatBuatLelangBuatLelangLabelTitleAturPinLokasi"
                                          .tr,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: GlobalVariable.ratioFontSize(
                                              context) *
                                          14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: GlobalVariable.ratioWidth(context) * 43,
                              ),
                              // ),
                              // if (controller.informationMarker.value
                              //         .formattedAddress ==
                              //     "")
                              //   SizedBox(
                              //     width: 5,
                              //   ),
                              // if (controller.informationMarker.value
                              //         .formattedAddress ==
                              //     "")
                              //   Obx(
                              //     () => Container(
                              //         width: 20,
                              //         height: 20,
                              //         child: controller.informationMarker.value
                              //                     .formattedAddress !=
                              //                 ""
                              //             ? SizedBox.shrink()
                              //             : CircularProgressIndicator(
                              //                 strokeWidth: 2.0,
                              //               )),
                              //   )
                            ],
                          ),
                        ),
                      ]),
                  // ),
                ]),
              ),
            ),
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 50,
                child: buildMap(context)),
          ),
        ),
      ),
    );
  }

  Widget buildMap(BuildContext context) {
    return Obx(() => Stack(children: [
          if (controller.listCurentLocation.length > 0)
            FlutterMap(
              mapController: controller.mapController.value,
              options: MapOptions(
                interactiveFlags: InteractiveFlag.pinchMove |
                    InteractiveFlag.pinchZoom |
                    InteractiveFlag.drag,
                maxZoom: GlobalVariable.zoomMap,
                center: controller.listCurentLocation[0],
                // onPositionChanged: (position, hasGesture) {
                //   controller.setPositionMarker(LatLng(
                //       position.center.latitude, position.center.longitude));
                //   controller.ltlg.value = LatLng(
                //       position.center.latitude, position.center.longitude);
                // },
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']),
                MarkerLayerOptions(
                  markers: [
                    if (controller.listCurentLocation.length > 1)
                      for (var idx = 0;
                          idx < controller.listCurentLocation.length;
                          idx++)
                        Marker(
                          width: GlobalVariable.ratioFontSize(context) * 26.27,
                          height: GlobalVariable.ratioFontSize(context) * 34,
                          point: controller.listCurentLocation.value[idx],
                          builder: (ctx) => GestureDetector(
                            onTap: () {
                              // if (controller.locationValid.value &&
                              //     controller.informationMarker.value
                              //             .formattedAddress !=
                              //         "" &&
                              //     !controller.isCanChose.value) {
                              //   controller.boolif.removeAt(idx);
                              //   controller.boolif.insert(idx, true);
                              //   controller.listCurentLocation[idx] =
                              //       controller.ltlg.value;
                              //   controller.idx.value = idx;
                              //   controller.isCanChose.value = true;
                              // }
                            },
                            child: (controller.boolif.value[idx] == false)
                                ? SvgPicture.asset(
                                    controller.iconLocation[idx],
                                  )
                                : SizedBox.shrink(),
                          ),
                        )
                    else if (controller.listCurentLocation.length != 0)
                      Marker(
                        width: GlobalVariable.ratioFontSize(context) * 26.27,
                        height: GlobalVariable.ratioFontSize(context) * 34,
                        point: controller.listCurentLocation.value[0],
                        builder: (ctx) => GestureDetector(
                          onTap: () {
                            // if (controller.locationValid.value &&
                            //     controller.informationMarker.value
                            //             .formattedAddress !=
                            //         "") {
                            //   controller.boolif.removeAt(0);
                            //   controller.boolif.insert(0, true);
                            //   controller.listCurentLocation[0] =
                            //       controller.ltlg.value;
                            //   controller.idx.value = 0;
                            // }
                          },
                          child: (controller.boolif.value[0] == false)
                              ? SvgPicture.asset(
                                  "assets/pin7.svg",
                                )
                              : SizedBox.shrink(),
                        ),
                      )
                  ],
                ),
              ],
            ),
          Stack(
            children: [
              Obx(
                () => !controller.showWarning.value
                    ? SizedBox.shrink()
                    : Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            width: MediaQuery.of(Get.context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 6),
                            margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
                            decoration: BoxDecoration(
                              color: Color(ListColor.colorRed3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: CustomText(
                                          "LelangMuatBuatLelangBuatLelangLabelTitleErorPinLokasi"
                                              .tr,
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      context) *
                                                  12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(ListColor.colorRed))),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 8),
                                    child: GestureDetector(
                                        onTap: () {
                                          controller.showWarning.value = false;
                                          // controller.listCurentLocation[
                                          //         controller.idx.value] =
                                          //     controller.latLngPositionMarker;
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.black,
                                          size: 12,
                                        )))
                              ],
                            ))),
              ),
              // CustomText(controller.boolif[controller.idx.value].toString()),
              // Align(
              //     alignment: Alignment.center,
              //     child: Transform.translate(
              //         offset: Offset(0, -20),
              //         child: GestureDetector(
              //           onTap: () {
              //             // if (controller.locationValid.value &&
              //             //     controller.informationMarker.value
              //             //             .formattedAddress !=
              //             //         "" &&
              //             //     controller.isCanChose.value) {
              //             //   controller.boolif.removeAt(controller.idx.value);
              //             //   controller.boolif
              //             //       .insert(controller.idx.value, false);
              //             //   // controller.boolif[controller.idx.value];

              //             //   controller.listCurentLocation
              //             //       .removeAt(controller.idx.value);
              //             //   controller.listCurentLocation.insert(
              //             //       controller.idx.value, controller.ltlg.value);

              //             //   controller.listReturnLokasiAddress
              //             //       .removeAt(controller.idx.value);
              //             //   controller.listReturnLokasiAddress.insert(
              //             //       controller.idx.value,
              //             //       controller
              //             //           .informationMarker.value.formattedAddress);

              //             //   controller.provinsiList
              //             //       .removeAt(controller.idx.value);
              //             //   controller.provinsiList.insert(controller.idx.value,
              //             //       controller.informationMarker.value.cityName);

              //             //   controller.kota.removeAt(controller.idx.value);
              //             //   controller.kota.insert(
              //             //       controller.idx.value,
              //             //       controller
              //             //           .informationMarker.value.districtName);

              //             //   controller.listReturnLatlong
              //             //       .removeAt(controller.idx.value);
              //             //   controller.listReturnLatlong.insert(
              //             //       controller.idx.value, controller.ltlg.value);
              //             //   controller.isCanChose.value = false;
              //             // }
              //           },
              //           child: Obx(
              //             () => (controller.boolif[controller.idx.value])
              //                 ? (controller.listCurentLocation.length > 1)
              //                     ? SvgPicture.asset(
              //                         controller
              //                             .iconLocation[controller.idx.value],
              //                         width: GlobalVariable.ratioFontSize(
              //                                 context) *
              //                             26.27,
              //                         height: GlobalVariable.ratioFontSize(
              //                                 context) *
              //                             34,
              //                       )
              //                     : SvgPicture.asset(
              //                         "assets/pin7.svg",
              //                         width: GlobalVariable.ratioFontSize(
              //                                 context) *
              //                             26.27,
              //                         height: GlobalVariable.ratioFontSize(
              //                                 context) *
              //                             34,
              //                       )
              //                 : SizedBox.shrink(),
              //           ),
              //         ))),

              Align(alignment: Alignment.bottomCenter, child: lokasiinput()

                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   margin: EdgeInsets.fromLTRB(
                  //       GlobalVariable.ratioWidth(Get.context) * 37,
                  //       GlobalVariable.ratioWidth(Get.context) * 16,
                  //       GlobalVariable.ratioWidth(Get.context) * 37,
                  //       GlobalVariable.ratioWidth(Get.context) * 16),
                  //   padding: EdgeInsets.all(10),
                  //   child: Obx(
                  //     () => OutlinedButton(
                  //       style: OutlinedButton.styleFrom(
                  //           backgroundColor: Color(
                  //               (controller.locationValid.value &&
                  //                       controller.informationMarker.value
                  //                               .formattedAddress !=
                  //                           "" &&
                  //                       !controller.isCanChose.value)
                  //                   ? ListColor.color4
                  //                   : ListColor.colorGrey),
                  //           side: BorderSide(
                  //               width: 2,
                  //               color: Color((controller.locationValid.value &&
                  //                       controller.informationMarker.value
                  //                               .formattedAddress !=
                  //                           "" &&
                  //                       !controller.isCanChose.value)
                  //                   ? ListColor.color4
                  //                   : ListColor.colorGrey)),
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.all(Radius.circular(20)),
                  //           )),
                  //       onPressed: () {
                  //         if (controller.locationValid.value &&
                  //             controller
                  //                     .informationMarker.value.formattedAddress !=
                  //                 "" &&
                  //             !controller.isCanChose.value)
                  //           controller.onApplyButton();
                  //       },
                  //       child: Container(
                  //         padding:
                  //             EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  //         child: CustomText("SLMMLabelButtonApply".tr,
                  //             fontSize:
                  //                 GlobalVariable.ratioFontSize(context) * 12,
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.white),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  )
            ],
          ),
        ]));
  }

  lokasiinput() {
    return Obx(() => Container(
          width: MediaQuery.of(Get.context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                  GlobalVariable.ratioFontSize(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 13,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //LelangMuatBuatLelangBuatLelangLabelTitleLokasiDestinasi
                    Center(
                      child: CustomText(
                        controller.pickupDestinasi.value == "pickup"
                            ? "LelangMuatTabAktifTabAktifLabelTitlePickupLocation"
                                .tr
                            : "LelangMuatBuatLelangBuatLelangLabelTitleLokasiDestinasi"
                                .tr,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        fontWeight: FontWeight.w700,
                        color: Color(ListColor.colorBlue),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 23,
                    ),
                    if (controller.listCurentLocation.length > 0)
                      for (var i = 0;
                          i < controller.listCurentLocation.length;
                          i++)
                        if (controller.pickupDestinasi.value == "pickup")
                          forminputan(
                            i,
                            ValueKey("pickupForm $i"),
                          )
                        else
                          forminputan(
                            i,
                            ValueKey("destinasiForm $i"),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  forminputan(index, keynya) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // if (controller.listCurentLocation.length - 1 != index)
            //   SizedBox(
            //     height: GlobalVariable.ratioFontSize(Get.context) * 10,
            //   ),
            Container(
              child: SvgPicture.asset(
                controller.iconLocation[index],
                width: GlobalVariable.ratioFontSize(Get.context) * 17,
                height: GlobalVariable.ratioFontSize(Get.context) * 22,
              ),
            ),
            if (controller.listCurentLocation.length - 1 != index)
              Container(
                padding: EdgeInsets.only(
                    left: GlobalVariable.ratioFontSize(Get.context) * 5),
                width: GlobalVariable.ratioFontSize(Get.context) * 17,
                child: SvgPicture.asset(
                  "assets/garis_alur_perjalanan.svg",
                  // width: GlobalVariable.ratioWidth(Get.context) * 12,
                  height: GlobalVariable.ratioFontSize(Get.context) * 30,
                ),
              )
          ],
        ),
        // Container(
        //   child: SvgPicture.asset(
        //     controller.iconLocation[index],
        //     width: GlobalVariable.ratioFontSize(Get.context) * 17,
        //     height: GlobalVariable.ratioFontSize(Get.context) * 22,
        //   ),
        // ),
        SizedBox(
          width: GlobalVariable.ratioWidth(Get.context) * 15,
        ),
        controller.isLoading[index]
            ? SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(),
              )
            : Expanded(
                child: Container(
                child: CustomTextField(
                    key: keynya,
                    context: Get.context,
                    readOnly: true,
                    onTap: () {
                      if (index == 0) {
                        if (controller.pickupDestinasi.value == "pickup") {
                          controller.cariLokasi("assets/pin1.svg", 0);
                        } else {
                          controller.cariLokasiDestinasi("assets/pin1.svg", 0);
                        }
                      }
                      if (index == 1) {
                        if (controller.pickupDestinasi.value == "pickup") {
                          controller.cariLokasi("assets/pin2_biru.svg", 1);
                        } else {
                          controller.cariLokasiDestinasi(
                              "assets/pin2_biru.svg", 1);
                        }
                      }
                      if (index == 2) {
                        if (controller.pickupDestinasi.value == "pickup") {
                          controller.cariLokasi("assets/pin3_biru.svg", 2);
                        } else {
                          controller.cariLokasiDestinasi(
                              "assets/pin3_biru.svg", 2);
                        }
                      }
                      if (index == 3) {
                        if (controller.pickupDestinasi.value == "pickup") {
                          controller.cariLokasi("assets/pin4_biru.svg", 3);
                        } else {
                          controller.cariLokasiDestinasi(
                              "assets/pin4_biru.svg", 3);
                        }
                      }
                      if (index == 4) {
                        if (controller.pickupDestinasi.value == "pickup") {
                          controller.cariLokasi("assets/pin5_biru.svg", 4);
                        } else {
                          controller.cariLokasiDestinasi(
                              "assets/pin5_biru.svg", 4);
                        }
                      }
                    },
                    controller: controller.controllerForm[index],
                    inputFormatters: [LengthLimitingTextInputFormatter(255)],
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.colorLightGrey4),
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 12),
                    newContentPadding: EdgeInsets.symmetric(
                        horizontal:
                            GlobalVariable.ratioFontSize(Get.context) * 10,
                        vertical:
                            GlobalVariable.ratioFontSize(Get.context) * 9),
                    textSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                    newInputDecoration: InputDecoration(
                      isDense: true,
                      isCollapsed: true,
                      hintText:
                          "LelangMuatBuatLelangBuatLelangLabelTitlePlaceholderChooseLocation"
                              .tr, // "Cari Area Pick Up",
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(
                          color: Color(ListColor.colorLightGrey2),
                          fontWeight: FontWeight.w600,
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 12),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(ListColor.colorLightGrey19),
                            width: 1.0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(ListColor.colorLightGrey19),
                            width: 1.0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(ListColor.colorLightGrey19),
                            width: 1.0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    )),
              )),
        SizedBox(
          width: GlobalVariable.ratioFontSize(Get.context) * 8,
        ),

        GestureDetector(
          onTap: () {
            controller.controllerForm[index].text = "";
            controller.listReturnLokasiAddress.removeAt(index);
            controller.listReturnLokasiAddress.insert(index, "");
            controller.listReturnLatlong.removeAt(index);
            controller.listReturnLatlong.insert(index, "");
            controller.provinsiList.removeAt(index);
            controller.provinsiList.insert(index, "");
            controller.kota.removeAt(index);
            controller.kota.insert(index, "");
            controller.placeID.removeAt(index);
            controller.placeID.insert(index, "");
          },
          child: Container(
              child: Icon(
            Icons.close_rounded,
            color: Color(ListColor.colorDarkGrey3),
            size: GlobalVariable.ratioFontSize(Get.context) * 20,
          )),
        )
      ],
    );
  }

  garisLokasi(index) {
    return Positioned(
      top: GlobalVariable.ratioFontSize(Get.context) * 20,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (controller.listCurentLocation.length - 1 != index)
            Container(
              padding: EdgeInsets.only(
                  left: GlobalVariable.ratioFontSize(Get.context) * 5),
              width: GlobalVariable.ratioFontSize(Get.context) * 17,
              child: SvgPicture.asset(
                "assets/garis_alur_perjalanan.svg",
                // width: GlobalVariable.ratioWidth(Get.context) * 12,
                // height: GlobalVariable.ratioFontSize(Get.context) * 20,
              ),
            ),
          // SizedBox(
          //   width: GlobalVariable.ratioWidth(Get.context) * 15,
          // ),
          // Expanded(child: SizedBox.shrink())
        ],
      ),
    );
  }
}
