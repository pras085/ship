import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/modules/lokasi_truk_siap_muat/lokasi_truk_siap_muat_status_enum.dart';
import 'package:muatmuat/app/widgets/appbar_custom1.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/modules/lokasi_truk_siap_muat/lokasi_truk_siap_muat_controller.dart';

class LokasiTrukSiapMuatView extends GetView<LokasiTrukSiapMuatController> {

  // SnappingPosition snappingPositionHide = SnappingPosition.factor(
  //     positionFactor: 0.0,
  //     grabbingContentOffset: GrabbingContentOffset.top,
  //     snappingCurve: Curves.easeOutExpo,
  // snappingDuration: Duration(milliseconds: 300));
  SnappingPosition snappingPositionHide = SnappingPosition.pixels(
      positionPixels: 64,
      snappingCurve: Curves.easeOutExpo,
      snappingDuration: Duration(milliseconds: 300));
  SnappingPosition snappingPositionMin = SnappingPosition.pixels(
      positionPixels: 330,
      snappingCurve: Curves.easeOutExpo,
      snappingDuration: Duration(milliseconds: 300));
  SnappingPosition snappingPositionMax = SnappingPosition.factor(
      positionFactor: 1,
      grabbingContentOffset: GrabbingContentOffset.bottom,
      snappingCurve: Curves.easeOutExpo,
      snappingDuration: Duration(milliseconds: 300));

  double _grabbingHeight = 20;
  double _thresholdHide = 65;
  double _thresholdMax = Get.height - 120;

  @override
  Widget build(BuildContext context) {
    Widget contentWidget = _contentWidget(controller.currState.value);

    WidgetsBinding.instance.addPostFrameCallback((_) => controller.afterDone());
    return WillPopScope(
      onWillPop: () {
        return controller.onWillPop();
      },
      child: Container(
          color: Color(ListColor.color4),
          child: SafeArea(
              child: Scaffold(
                  key: controller.scaffoldKey.value,
                  appBar: AppBarCustom1(
                    title: 'Lokasi Truk Siap Muat',
                    centerTitle: false,
                    preferredSize:
                        Size.fromHeight(AppBar().preferredSize.height),
                  ),
                  body: Stack(
                    children: [
                      // Timeline.tileBuilder(
                      //     scrollDirection: Axis.horizontal,
                      //     builder: TimelineTileBuilder.connected(
                      //         contentsAlign: ContentsAlign.basic,
                      //         indicatorBuilder: (context, index) =>
                      //             DotIndicator(
                      //                 color: index <= 1
                      //                     ? Colors.blue
                      //                     : Colors.grey),
                      //         connectorBuilder: (context, index, type) =>
                      //             SolidLineConnector(
                      //                 color: index < 1
                      //                     ? Colors.blue
                      //                     : Colors.grey),
                      //         contentsBuilder: (context, index) => Padding(
                      //               padding: EdgeInsets.all(16),
                      //               child: Container(
                      //                   width: 48,
                      //                   child: Text('31 Mar 2021',
                      //                       maxLines: 2,
                      //                       textAlign: TextAlign.center)),
                      //             ),
                      //         itemCount: 12))
                      Obx(() => SnappingSheet(
                            child: _buildMap(Get.context),
                            controller: controller.snappingSheetController,
                            lockOverflowDrag: true,
                            initialSnappingPosition: snappingPositionMin,
                            snappingPositions: [
                              snappingPositionHide,
                              snappingPositionMin,
                              snappingPositionMax,
                            ],
                            grabbing:
                                _grabbingWidget(controller.currState.value),
                            // LokasiTrukSiapMuatGrabbingWidget(controller.currState.value)),
                            grabbingHeight: _grabbingHeight,
                            // _grabbingHeight(controller.currState.value),
                            sheetAbove: null,
                            sheetBelow: SnappingSheetContent(
                                draggable: true,
                                childScrollController:
                                    controller.snappingScrollController,
                                child: Container(
                                  color: Colors.white,
                                  child: AnimatedSwitcher(
                                      duration: Duration(seconds: 1),
                                      child: contentWidget),
                                )),
                            // child: _contentWidget(
                            //     controller.currState.value)))),
                            onSheetMoved: (sheetPosition) {
                              if (sheetPosition.pixels < _thresholdHide) {
                                controller.currState.value =
                                    LokasiTrukSiapMuatStatus.HIDE;
                              } else if (sheetPosition.pixels > _thresholdMax) {
                                controller.currState.value =
                                    LokasiTrukSiapMuatStatus.MAX;
                              } else {
                                controller.currState.value =
                                    LokasiTrukSiapMuatStatus.MIN;
                              }
                              contentWidget =
                                  _contentWidget(controller.currState.value);
                            },
                          )),
                    ],
                  )))),
    );
  }

  Widget _grabbingWidget(LokasiTrukSiapMuatStatus currState) {
    Widget result = Container(color: Color(ListColor.colorWhite));
    switch (currState) {
      case LokasiTrukSiapMuatStatus.HIDE:
        {
          result = _grabbingWidgetHide();
          break;
        }
      case LokasiTrukSiapMuatStatus.MIN:
        {
          result = _grabbingWidgetMin();
          break;
        }
      case LokasiTrukSiapMuatStatus.MAX:
        {
          result = _grabbingWidgetMax();
          break;
        }
    }
    return result;
  }

  // double _grabbingHeight(LokasiTrukSiapMuatStatus currState) {
  //   double result = 20;
  //   switch (currState) {
  //     case LokasiTrukSiapMuatStatus.HIDE:
  //       {
  //         result = 124;
  //         break;
  //       }
  //     case LokasiTrukSiapMuatStatus.MIN:
  //       {
  //         result = 20;
  //         break;
  //       }
  //     case LokasiTrukSiapMuatStatus.MAX:
  //       {
  //         result = 20;
  //         break;
  //       }
  //   }
  //   return result;
  // }

  Widget _contentWidget(LokasiTrukSiapMuatStatus currState) {
    // print('Debug: ' + 'currState = ' + currState.toString());
    Widget result = Container(color: Color(ListColor.colorWhite));
    switch (currState) {
      case LokasiTrukSiapMuatStatus.HIDE:
        {
          result = _contentWidgetHide();
          break;
        }
      case LokasiTrukSiapMuatStatus.MIN:
        {
          result = _contentWidgetMin();
          break;
        }
      case LokasiTrukSiapMuatStatus.MAX:
        {
          result = _contentWidgetMax();
          break;
        }
    }
    return result;
  }

  Widget _grabbingWidgetHide() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(17)),
          boxShadow: [
            BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.2))
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _grabbingBar(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Expanded(
          //       child: _title(),
          //     ),
          //     IconButton(
          //         icon: Icon(Icons.arrow_upward),
          //         iconSize: 28,
          //         color: Color(ListColor.color4),
          //         onPressed: () {
          //           controller.snappingSheetController
          //               .snapToPosition(snappingPositionMin);
          //           controller.currState.value = LokasiTrukSiapMuatStatus.MIN;
          //         }),
          //     SizedBox(width: 16),
          //     IconButton(
          //         icon: Icon(Icons.arrow_upward),
          //         iconSize: 28,
          //         color: Color(ListColor.color4),
          //         onPressed: () {
          //           controller.snappingSheetController
          //               .snapToPosition(snappingPositionMax);
          //           controller.currState.value = LokasiTrukSiapMuatStatus.MAX;
          //         }),
          //   ],
          // )
        ],
      ),
    );
  }

  Widget _grabbingWidgetMin() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(17)),
          boxShadow: [
            BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.2))
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _grabbingBar(),
          // Container(
          //   width: Get.width,
          //   alignment: Alignment.centerLeft,
          //   child: _title(),
          // )
        ],
      ),
    );
  }

  Widget _grabbingWidgetMax() {
    return Container(
      decoration: BoxDecoration(color: Colors.white,
          // borderRadius: BorderRadius.vertical(top: Radius.circular(17)),
          boxShadow: [
            BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.2))
          ]),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                  padding: EdgeInsets.only(top: 10), child: _grabbingBar())),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Color(ListColor.colorLightGrey).withOpacity(0.5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 10,
                  offset: Offset(0, 0.75),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentWidgetHide() {
    return Container(
      color: Color(ListColor.colorWhite),
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _title(),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Transform.rotate(
                  angle: math.pi,
                  child: SvgPicture.asset(
                    "assets/ic_ltsm arrow_down.svg",
                    width: Get.width,
                    height: 40,
                    color: Color(ListColor.color4),
                  )),
            ),
            onTap: () {
              if (controller.snappingSheetController.isAttached)
              {
                controller.snappingSheetController
                  .snapToPosition(snappingPositionMin);
                controller.currState.value = LokasiTrukSiapMuatStatus.MIN;
              }
            },
          ),
          // IconButton(
          //     icon: Icon(Icons.arrow_upward),
          //     iconSize: 28,
          //     color: Color(ListColor.color4),
          //     onPressed: () {
          //       controller.snappingSheetController
          //           .snapToPosition(snappingPositionMin);
          //       controller.currState.value = LokasiTrukSiapMuatStatus.MIN;
          //     }),
          SizedBox(width: 8),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Transform.rotate(
                angle: math.pi / 4,
                child: Icon(
                  Icons.arrow_upward,
                  size: 32,
                  color: Color(ListColor.color4),
                ),
              ),
            ),
            onTap: () {
              if (controller.snappingSheetController.isAttached)
              {
                controller.snappingSheetController
                    .snapToPosition(snappingPositionMax);
                controller.currState.value = LokasiTrukSiapMuatStatus.MAX;
              }
            },
          ),
          // IconButton(
          //     icon: Icon(Icons.arrow_upward),
          //     iconSize: 28,
          //     color: Color(ListColor.color4),
          //     onPressed: () {
          //       controller.snappingSheetController
          //           .snapToPosition(snappingPositionMax);
          //       controller.currState.value = LokasiTrukSiapMuatStatus.MAX;
          //     }),
          SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _contentWidgetMin() {
    return Container(
        color: Color(ListColor.colorWhite),
        child: SingleChildScrollView(
          controller: controller.snappingScrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: Get.width,
                alignment: Alignment.centerLeft,
                child: _title(),
              ),
              // Container(
              //     width: 328 * MediaQuery.of(Get.context).devicePixelRatio,
              //     height: 88 * MediaQuery.of(Get.context).devicePixelRatio,
              //     // width: 328 * Get.width / 360,
              //     // height: 88 * Get.height / 698,
              //     child: Text(
              //         MediaQuery.of(Get.context).devicePixelRatio.toString()),
              //     color: Colors.yellow),
              Container(
                  padding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(Get.context) * 16,
                      GlobalVariable.ratioWidth(Get.context) * 17,
                      GlobalVariable.ratioWidth(Get.context) * 16,
                      GlobalVariable.ratioWidth(Get.context) * 27),
                  child: _panelSearch())
            ],
          ),
        ));
  }

  Widget _contentWidgetMax() {
    return Container(
        padding: EdgeInsets.fromLTRB(18, 12, 18, 12),
        color: Color(ListColor.colorWhite),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _panelSearch(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                ),
                child: SvgPicture.asset(
                  "assets/image_ltsm_truk.svg",
                  width: Get.width,
                  height: GlobalVariable.ratioWidth(Get.context) * 250,
                ),
              ),
            ),
            CustomText("Cari Truk Siap Muat",
                color: Color(ListColor.colorLightGrey14),
                fontSize: 12,
                fontWeight: FontWeight.w600),
            CustomText(
                "Total truk siap muat di seluruh Indonesia: " +
                    NumberFormat('#,###')
                        .format(int.parse(controller.jumlahTruk.value ?? "0")),
                color: Color(ListColor.colorLightGrey14),
                fontSize: 12,
                fontWeight: FontWeight.w600),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 30)
          ],
        ));
  }

  Widget _buildMap(BuildContext context) {
    return FlutterMap(
      mapController: controller.mapController.value,
      options: MapOptions(
          center: controller.position.value,
          interactiveFlags: InteractiveFlag.drag | InteractiveFlag.pinchZoom,
          zoom: GlobalVariable.zoomMap,
          maxZoom: 18.0,
          onTap: (_) {}),
      layers: [
        GlobalVariable.tileLayerOptions,
        MarkerLayerOptions(
            markers: controller.markerList
                .map<Marker>((data) => data as Marker)
                .toList()),
        // PolylineLayerOptions(polylines: [
        //   Polyline(
        //       points: controller.listRoute
        //           .map((data) => LatLng(data.latitude, data.longitude))
        //           .toList(),
        //       strokeWidth: 4.0,
        //       color: Colors.green),
        // ]),
        // PopupMarkerLayerOptions(
        //     markers: controller.listMarker
        //         .map<Marker>((data) => data as Marker)
        //         .toList(),
        //     popupSnap: PopupSnap.markerTop,
        //     popupController: _popupController,
        //     popupBuilder: (_, marker) {
        //       return Card(
        //           child: Container(
        //               padding: EdgeInsets.all(10),
        //               width: 300,
        //               child: Column(
        //                   mainAxisSize: MainAxisSize.min,
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Row(mainAxisSize: MainAxisSize.min, children: [
        //                       GestureDetector(
        //                         onTap: () {
        //                           Get.toNamed(Routes.SETTING);
        //                         },
        //                         child: Icon(
        //                           Icons.circle,
        //                           color: Color(ListColor.color4),
        //                           size: 40,
        //                         ),
        //                       ),
        //                       Expanded(
        //                         child: Column(
        //                           mainAxisSize: MainAxisSize.min,
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //                             Text(
        //                               controller.nameMarker(marker.point),
        //                               style: TextStyle(
        //                                   fontWeight: FontWeight.w700,
        //                                   fontSize: 12),
        //                             ),
        //                             Text(
        //                               controller.addressMarker(marker.point),
        //                               style: TextStyle(
        //                                   color: Color(ListColor.colorGrey),
        //                                   fontSize: 12),
        //                             ),
        //                             // Text("Latlng: " +
        //                             //     marker.point.latitude.toString() +
        //                             //     ", " +
        //                             //     marker.point.longitude.toString()),
        //                           ],
        //                         ),
        //                       ),
        //                     ]),
        //                     SizedBox(
        //                       height: 30,
        //                     ),
        //                     Row(
        //                       mainAxisSize: MainAxisSize.min,
        //                       children: [
        //                         Icon(
        //                           Icons.person,
        //                           color: Color(ListColor.color4),
        //                           size: 20,
        //                         ),
        //                         SizedBox(
        //                           width: 10,
        //                         ),
        //                         Icon(
        //                           Icons.edit,
        //                           color: Color(ListColor.color4),
        //                           size: 20,
        //                         ),
        //                         SizedBox(
        //                           width: 10,
        //                         ),
        //                         Icon(
        //                           Icons.call,
        //                           color: Color(ListColor.color4),
        //                           size: 20,
        //                         ),
        //                       ],
        //                     )
        //                   ])));
        //     }),
        // PopupMarkerLayerOptions(
        //     markers: controller.listMarkerCircle
        //         .map<Marker>((data) => data as Marker)
        //         .toList(),
        //     popupSnap: PopupSnap.markerTop,
        //     popupController: _popupControllerCircle,
        //     popupBuilder: (_, marker) {
        //       return Container();
        //     }),
      ],
    );
  }

  // Widget _textFormField(
  //     {Widget prefixIcon,
  //     Widget suffixIcon,
  //     bool isEnable = true,
  //     double marginBottom = 10,
  //     bool isPhoneNumber = false,
  //     bool isNumber = false,
  //     bool isMultiLine = false,
  //     TextEditingController textEditingController,
  //     Color focusBorderColor = const Color(0xFF176CF7),
  //     Color enableBorderColor = const Color(0xFFC6CBD4),
  //     String initialValue,
  //     String title,
  //     Function validator,
  //     String hintText = "",
  //     bool isSetTitleToHint = false,
  //     void Function(String) onChanged}) {
  //   return TextFormFieldWidget(
  //       isNumber: isNumber,
  //       errorColor: Colors.red,
  //       isSetTitleToHint: isSetTitleToHint,
  //       onChanged: onChanged,
  //       isMultiLine: isMultiLine,
  //       titleTextStyle: TextStyle(
  //           fontWeight: FontWeight.w700,
  //           fontSize: 16,
  //           color: Color(ListColor.colorGrey3)),
  //       hintText: hintText,
  //       title: title,
  //       validator: validator,
  //       initialValue: initialValue,
  //       textEditingController: textEditingController,
  //       isPhoneNumber: isPhoneNumber,
  //       isShowCodePhoneNumber: false,
  //       isEnable: isEnable,
  //       prefixIcon: prefixIcon,
  //       suffixIcon: suffixIcon,
  //       fillColor: Colors.white,
  //       focusedBorderColor: focusBorderColor,
  //       enableBorderColor: enableBorderColor,
  //       disableBorderColor: Color(ListColor.colorLightGrey10),
  //       contentTextStyle: TextStyle(fontWeight: FontWeight.w600),
  //       marginBottom: marginBottom,
  //       hintTextStyle: TextStyle(
  //           color: Color(ListColor.colorLightGrey2),
  //           fontWeight: FontWeight.w600));
  // }

  Widget _grabbingBar() {
    return Container(
      margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 3),
      width: Get.width / 10,
      height: GlobalVariable.ratioWidth(Get.context) * 3,
      decoration: BoxDecoration(
        color: Color(ListColor.colorLightGrey16),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * 18, 
        GlobalVariable.ratioWidth(Get.context) * 10, 
        GlobalVariable.ratioWidth(Get.context) * 18, 
        GlobalVariable.ratioWidth(Get.context) * 20,
      ),
      child: CustomText(
        'Lokasi Truk Siap Muat',
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Color(ListColor.color4),
      ),
    );
  }

  Widget _panelSearch() {
    return Obx(() => Column(
          children: [
            Container(
              padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 2),
              decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(controller.isEmptyAlamat.value
                        ? ListColor.colorRed
                        : ListColor.colorLightGrey2)),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 8),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                    width: GlobalVariable.ratioWidth(Get.context) * 48,
                    alignment: Alignment.topCenter,
                    child: Stack(alignment: Alignment.topCenter, children: [
                      Container(
                        padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 24),
                        child: SvgPicture.asset(
                          "assets/ic_ltsm_line.svg",
                          height: GlobalVariable.ratioWidth(Get.context) * 40,
                        ),
                        color: Colors.transparent,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 2),
                        child: SvgPicture.asset(
                          "assets/marker_transporter_icon.svg",
                          width: GlobalVariable.ratioWidth(Get.context) * 36,
                        ),
                        color: Colors.transparent,
                      ),
                      Container(
                          padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 55),
                          child: SvgPicture.asset(
                            "assets/ic_ltsm_dest.svg",
                            width: GlobalVariable.ratioWidth(Get.context) * 32,
                          ),
                          color: Colors.transparent,
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                        // color: Colors.yellow,
                        padding: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 13),
                        // height: 88,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            textFieldAddress(),
                            Divider(
                                height: GlobalVariable.ratioWidth(Get.context) * 1,
                                color: Color(ListColor.colorLightGrey18)),
                            textFieldDest()
                          ],
                        )))
              ]),
            ),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 10),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: textFieldTrukCarrier("Truk")),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 10),
                Expanded(child: textFieldTrukCarrier("Carrier")),
              ],
            ),
            SizedBox(height: GlobalVariable.ratioHeight(Get.context) * 18),
            buttonSearch(),
          ],
        ));
  }

  Widget textFieldAddress() {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: CustomTextField(
                  context: Get.context,
                  enabled: false,
                  controller: controller.textEditingAddressController,
                  textSize: 12,
                  // newContentPadding: EdgeInsets.fromLTRB(42, 10, 10, 10),
                  style: TextStyle(
                      color: Color(ListColor.colorBlack),
                      fontWeight: FontWeight.w600),
                  newInputDecoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Masukkan alamat pengambilan barang",
                      hintStyle: TextStyle(
                          color: Color(ListColor.colorLightGrey2),
                          fontWeight: FontWeight.w600)))),
        ],
      ),
      onTap: () {
        controller.selectAddress();
      },
    );
  }

  Widget textFieldDest() {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: CustomTextField(
                  context: Get.context,
                  enabled: false,
                  controller: controller.textEditingDestController,
                  // newContentPadding: EdgeInsets.fromLTRB(42, 10, 10, 10),
                  textSize: 12,
                  style: TextStyle(
                      color: Color(ListColor.colorBlack),
                      fontWeight: FontWeight.w600),
                  newInputDecoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Pilih kota tujuan",
                      hintStyle: TextStyle(
                          color: Color(ListColor.colorLightGrey2),
                          fontWeight: FontWeight.w600)))),
          SvgPicture.asset(
            "assets/ic_ltsm arrow_down.svg",
            width: Get.width,
            height: 30,
          ),
        ],
      ),
      onTap: () {
        controller.selectDest();
      },
    );
  }

  Widget textFieldTrukCarrier(String type) {
    return GestureDetector(
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(15, 2, 2, 2),
          decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: Color((type == "Truk"
                        ? controller.isEmptyTruk.value
                        : controller.isEmptyCarrier.value)
                    ? ListColor.colorRed
                    : ListColor.colorLightGrey2)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child: CustomTextField(
                context: Get.context,
                enabled: false,
                controller: type == "Truk"
                    ? controller.textEditingTrukController
                    : controller.textEditingCarrierController,
                // newContentPadding: EdgeInsets.fromLTRB(42, 10, 10, 10),
                textSize: 14,
                style: TextStyle(
                    color: Color(ListColor.colorLightGrey4),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                newInputDecoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: type == "Truk" ? "Jenis Truk" : "Jenis Carrier",
                    hintStyle: TextStyle(
                        color: Color(ListColor.colorLightGrey4),
                        fontWeight: FontWeight.w600)),
              )),
              SvgPicture.asset(
                "assets/ic_ltsm arrow_down.svg",
                width: Get.width,
                height: 30,
              ),
            ],
          )),
      onTap: () {
        type == "Truk"
            ? controller.selectHeadCarrier("0")
            : controller.selectHeadCarrier("1");
      },
    );
  }

  Widget buttonSearch() {
    return MaterialButton(
      height: 48,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24))),
      color: Color(ListColor.color4),
      child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(Get.context).size.width,
          child: CustomText(
            "Cari Truk Siap Muat",
            fromCenter: true,
            textAlign: TextAlign.center,
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          )),
      onPressed: () {
        controller.isEmptyAlamat.value = false;
        controller.isEmptyTruk.value = false;
        controller.isEmptyCarrier.value = false;
        if (controller.textEditingAddressController.text.trim().isEmpty ||
            controller.textEditingDestController.text.trim().isEmpty) {
          controller.isEmptyAlamat.value = true;
        }
        if (controller.textEditingTrukController.text.trim().isEmpty) {
          controller.isEmptyTruk.value = true;
        }
        if (controller.textEditingCarrierController.text.trim().isEmpty) {
          controller.isEmptyCarrier.value = true;
        }
        if (!controller.isEmptyAlamat.value &&
            !controller.isEmptyTruk.value &&
            !controller.isEmptyCarrier.value) {
          controller.cariTrukSiapMuat();
        }
      },
    );
  }
}
