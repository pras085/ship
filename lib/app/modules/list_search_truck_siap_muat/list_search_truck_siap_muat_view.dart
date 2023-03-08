import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_animation.dart';
import 'package:muatmuat/app/modules/list_search_truck_siap_muat/list_search_truck_siap_muat_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/button_filter_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:latlong/latlong.dart';

import 'list_search_truck_siap_muat_model.dart';

class ListSearchTruckSiapMuatView
    extends GetView<ListSearchTruckSiapMuatController> {
  AppBar _appBar = AppBar(
    title: CustomText('Demo'),
  );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        // return Future.value(false);
        return Future.value(true);
      },
      child: SafeArea(
          child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(_appBar.preferredSize.height + 10),
          child: Container(
              height: (_appBar.preferredSize.height + 10),
              color: Color(ListColor.color4),
              child: Stack(alignment: Alignment.center, children: [
                Positioned(
                  top: 5,
                  right: 0,
                  child: Image(
                    image: AssetImage("assets/fallin_star_3_icon.png"),
                    height: (_appBar.preferredSize.height + 10),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: ClipOval(
                          child: Material(
                              shape: CircleBorder(),
                              color: Colors.white,
                              child: InkWell(
                                  onTap: () {
                                    // controller.onWillPop();
                                    Get.back();
                                  },
                                  child: Container(
                                      width: 30,
                                      height: 30,
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        size: 30 * 0.7,
                                        color: Color(ListColor.color4),
                                      ))))),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 13),
                        child: CustomText(
                          "Lokasi Truk Siap Muat",
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      )),
                      Obx(
                        () => !controller.showLoading.value &&
                                controller.listSearchTrukSiapMuat.length > 0
                            ? GestureDetector(
                                onTap: () {
                                  controller.showSort();
                                },
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: controller.sort.keys.isNotEmpty
                                          ? Colors.white
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/sorting_icon.svg",
                                        color: controller.sort.keys.isNotEmpty
                                            ? Color(ListColor.color4)
                                            : Colors.white)))
                            : SizedBox.shrink(),
                      )
                    ],
                  ),
                )
              ])),
        ),
        body: Stack(
          children: [
            Positioned.fill(child: _buildMap(context)),
            Positioned.fill(
                child: Obx(() => controller.showLoading.value
                    ? SizedBox.shrink()
                    : controller.listSearchTrukSiapMuat.length > 0
                        ? snappingSheetDialog()
                        : emptySearchWidget(
                            controller.areaPickup.value,
                            controller.destinasi.values.first,
                            controller.jenisTruk.values.first,
                            controller.jenisCarrier.values.first))),
            Positioned.fill(
                child: Obx(() => !controller.showLoading.value
                    ? SizedBox.shrink()
                    : LoadingAnimation(
                        controller.showImage.value,
                        controller.firstActive.value,
                        controller.secondActive.value,
                        controller.thirdActive.value))),
            Positioned.fill(
                child: Obx(() => !controller.showLoadingDetail.value
                    ? SizedBox.shrink()
                    : Container(
                        color: Color(ListColor.colorLightGrey),
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ))),
          ],
        ),
      )),
    );
  }

  Widget _buildMap(BuildContext context) {
    return Obx(
      () => FlutterMap(
        mapController: controller.mapController,
        options: MapOptions(
            interactiveFlags: InteractiveFlag.pinchMove |
                InteractiveFlag.pinchZoom |
                InteractiveFlag.drag,
            maxZoom: 18.0,
            plugins: [PopupMarkerPlugin()],
            center: GlobalVariable.centerMap,
            onTap: (_) {
              controller.popupController.hidePopup();
              // controller.popupControllerCircle.hidePopup();
              controller.currentActiveMarker.value = 0;
            }),
        layers: [
          GlobalVariable.tileLayerOptions,
          PopupMarkerLayerOptions(
              markers: controller.listMarkerAreaPickup
                  .map<Marker>((data) => data as Marker)
                  .toList(),
              popupSnap: PopupSnap.markerTop,
              popupController: controller.popupControllerAreaPickup,
              popupBuilder: (_, marker) {
                return Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 142,
                  // height: GlobalVariable.ratioHeight(Get.context) * 31,
                  padding: EdgeInsets.all(
                      GlobalVariable.ratioWidth(Get.context) * 7),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText("Alamat Pickup",
                          overflow: TextOverflow.ellipsis,
                          fontSize: 8,
                          color: Color(ListColor.color4),
                          fontWeight: FontWeight.w600),
                      SizedBox(height: 3),
                      CustomText(controller.areaPickup.value,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          fontSize: 9,
                          color: Color(ListColor.colorGrey3)),
                    ],
                  ),
                );
              }),
          PopupMarkerLayerOptions(
              markers: controller.listMarker
                  .map<Marker>((data) => data as Marker)
                  .toList(),
              popupSnap: PopupSnap.markerTop,
              popupController: controller.popupController,
              popupBuilder: (_, marker) {
                ListSearchTruckSiapMuatModel trukSiapMuat =
                    controller.listSearchTrukSiapMuat[
                        controller.listMarker.indexOf(marker)];
                return Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 142,
                  // height: GlobalVariable.ratioHeight(Get.context) * 82,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: GlobalVariable.ratioWidth(Get.context) * 28,
                            height: GlobalVariable.ratioWidth(Get.context) * 28,
                            child: _circleAvatar(
                                trukSiapMuat.avatar, trukSiapMuat.initial),
                          ),
                          SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 7),
                          Expanded(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  !trukSiapMuat.isGold
                                      ? SizedBox.shrink()
                                      : Container(
                                          margin: EdgeInsets.only(
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  2),
                                          child: Image(
                                            image: AssetImage(
                                                "assets/ic_gold.png"),
                                            height: GlobalVariable.ratioHeight(
                                                    Get.context) *
                                                8,
                                          ),
                                        ),
                                  Expanded(
                                      child: CustomText(
                                          trukSiapMuat.namaTransporter,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 8,
                                          color:
                                              Color(ListColor.colorDarkGrey4),
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                              SizedBox(height: 3),
                              CustomText(trukSiapMuat.posisiTruk,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 8,
                                  color: Color(ListColor.colorGrey3))
                            ],
                          ))
                        ],
                      ),
                      SizedBox(
                          height: GlobalVariable.ratioHeight(Get.context) * 11),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.openDetailTransporter(trukSiapMuat);
                            },
                            child: Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 18,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 18,
                                child: SvgPicture.asset(
                                    "assets/ic_tooltip_detail_transporter.svg")),
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 6,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.openDetailLokasi(trukSiapMuat);
                            },
                            child: Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 18,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 18,
                                child: SvgPicture.asset(
                                    "assets/ic_tooltip_detail_lokasi.svg")),
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 6,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.showContact(trukSiapMuat);
                            },
                            child: Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 18,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 18,
                                child: SvgPicture.asset(
                                    "assets/ic_tooltip_contact_transporter.svg")),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: GlobalVariable.ratioHeight(Get.context) * 5),
                      CustomText(
                          "${trukSiapMuat.jumlahTruk} Unit diupdate pada pukul ${trukSiapMuat.lastUpdateWaktu}",
                          fontWeight: FontWeight.w600,
                          fontSize: 6,
                          color: Color(ListColor.color4))
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }

  Widget snappingSheetDialog() {
    return Obx(
      () => SnappingSheet(
        controller: controller.snappingController,
        lockOverflowDrag: true,
        snappingPositions: controller.listSnapping.value,
        grabbing: Obx(() => GrabbingWidget(
              controller.showRound.value,
              controller.jumlahTruk.value,
              controller.areaPickup.value,
              controller.destinasi.values.first,
              controller.jenisTruk.values.first,
              controller.jenisCarrier.values.first,
            )),
        grabbingHeight: GlobalVariable.ratioHeight(Get.context) * 120,
        // initialSnappingPosition: controller.listSnapping[0],
        initialSnappingPosition: SnappingPosition.pixels(
          positionPixels: MediaQuery.of(Get.context).size.height * 3 / 5,
          snappingCurve: Curves.easeOutExpo, // Curves.elasticOut,
          snappingDuration:
              Duration(milliseconds: 300), // Duration(milliseconds: 1750),
        ),
        sheetAbove: null,
        sheetBelow: SnappingSheetContent(
            draggable: true,
            childScrollController: controller.scrollController,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.white,
                      spreadRadius: 20,
                      blurRadius: 2,
                      offset: Offset(0, 10)),
                ],
              ),
              child: SmartRefresher(
                enablePullDown: false,
                enablePullUp: true,
                controller: controller.refreshController,
                onLoading: () async {
                  await controller.getListProcess(
                      ((controller.listSearchTrukSiapMuat.length /
                                  controller.maximumLimit) +
                              1)
                          .toInt());
                },
                onRefresh: () async {
                  await controller.getListProcess(1);
                },
                child: SingleChildScrollView(
                  // controller: controller.scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 17),
                        child: ButtonFilterWidget(
                            onTap: () => controller.showFilterOption()),
                      ),
                      SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 12),
                      for (var index = 0;
                          index < controller.listSearchTrukSiapMuat.length;
                          index++)
                        Container(
                          width: MediaQuery.of(Get.context).size.width,
                          margin: EdgeInsets.only(
                              bottom:
                                  GlobalVariable.ratioHeight(Get.context) * 12,
                              left: GlobalVariable.ratioWidth(Get.context) * 17,
                              right:
                                  GlobalVariable.ratioWidth(Get.context) * 17),
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Color(ListColor.colorLightGrey)
                                    .withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(ListColor.colorLightBlue6),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12))),
                                padding: EdgeInsets.fromLTRB(
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                    GlobalVariable.ratioWidth(Get.context) * 9,
                                    GlobalVariable.ratioWidth(Get.context) * 13,
                                    GlobalVariable.ratioWidth(Get.context) * 7),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _circleAvatar(
                                        controller.listSearchTrukSiapMuat[index]
                                            .avatar,
                                        controller.listSearchTrukSiapMuat[index]
                                            .initial),
                                    SizedBox(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16),
                                    Expanded(
                                        child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            !controller
                                                    .listSearchTrukSiapMuat[
                                                        index]
                                                    .isGold
                                                ? SizedBox.shrink()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        right: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            3),
                                                    child: Image(
                                                      image: AssetImage(
                                                          "assets/ic_gold.png"),
                                                      height: GlobalVariable
                                                              .ratioHeight(
                                                                  Get.context) *
                                                          15,
                                                    ),
                                                  ),
                                            Expanded(
                                              child: CustomText(
                                                  controller
                                                      .listSearchTrukSiapMuat[
                                                          index]
                                                      .namaTransporter,
                                                  height: 1.2,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(ListColor
                                                      .colorLightGrey4)),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 2),
                                        CustomText(
                                            controller
                                                .listSearchTrukSiapMuat[index]
                                                .kotaTransporter,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(ListColor.colorGrey3))
                                      ],
                                    )),
                                    Container(
                                        child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        CustomText(
                                            controller
                                                .listSearchTrukSiapMuat[index]
                                                .lastUpdateTanggal,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600,
                                            color: Color(ListColor.color4)),
                                        CustomText(
                                            controller
                                                .listSearchTrukSiapMuat[index]
                                                .lastUpdateWaktu,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600,
                                            color: Color(ListColor.color4)),
                                      ],
                                    )),
                                    SizedBox(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            10),
                                    GestureDetector(
                                        onTap: () {
                                          controller.optionGroupMitra(
                                              controller.listSearchTrukSiapMuat[
                                                  index],
                                              index);
                                        },
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              16,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              16,
                                          child: Icon(Icons.more_vert,
                                              size: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16),
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioHeight(Get.context) *
                                          13),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          32,
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                3),
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            9,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            9,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            border: Border.all(
                                                color: Color(ListColor.color4),
                                                width: 2),
                                            color: Color(ListColor.color4)),
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomText(
                                        controller.listSearchTrukSiapMuat[index]
                                            .areaPickup,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(ListColor.colorLightGrey4),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            6.25),
                                    child: Dash(
                                      direction: Axis.vertical,
                                      length: 13,
                                      dashLength: 5,
                                      dashThickness: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          1.5,
                                      dashColor: Color(ListColor.color4),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16),
                                child: Row(
                                  children: [
                                    Container(
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          32,
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                3),
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            9,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            9,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            border: Border.all(
                                                color: Color(ListColor.color4),
                                                width: 2),
                                            color: Colors.white),
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomText(
                                        controller.listSearchTrukSiapMuat[index]
                                            .ekspektasiDestinasi,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(ListColor.colorLightGrey4),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioHeight(Get.context) *
                                          13),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          32,
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: 17,
                                        height: 17,
                                        child: SvgPicture.asset(
                                            "assets/ic_posisi_truk.svg"),
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomText(
                                        controller.listSearchTrukSiapMuat[index]
                                            .posisiTruk,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 12,
                                        height: 1.2,
                                        maxLines: 2,
                                        fontWeight: FontWeight.w500,
                                        color: Color(ListColor.colorLightGrey4),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioHeight(Get.context) *
                                          13),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16),
                                child: Row(
                                  children: [
                                    Container(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            32,
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: 17,
                                          height: 17,
                                          child: SvgPicture.asset(
                                              "assets/number_truck_icon.svg"),
                                        )),
                                    CustomText(
                                      controller.listSearchTrukSiapMuat[index]
                                              .siapMuat
                                              .toString() +
                                          " Unit",
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(ListColor.colorLightGrey4),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioHeight(Get.context) *
                                          13),
                              Container(
                                height: 0.5,
                                color: Color(ListColor.colorLightGrey2),
                                width: double.infinity,
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                      vertical: GlobalVariable.ratioHeight(
                                              Get.context) *
                                          7),
                                  alignment: Alignment.centerRight,
                                  width: double.infinity,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.openDetailLokasi(controller
                                          .listSearchTrukSiapMuat[index]);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              23,
                                          vertical: GlobalVariable.ratioHeight(
                                                  Get.context) *
                                              6),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Color(ListColor.color4)),
                                      child: CustomText("Detail",
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ))
                            ],
                          ),
                        )
                    ],
                  ),
                ),
                // child: ListView.builder(
                //   controller: controller.scrollController,
                //   itemCount: controller.listSearchTrukSiapMuat.length,
                //   itemBuilder: (content, index) {
                //     return Container(
                //       width: MediaQuery.of(Get.context).size.width,
                //       margin: EdgeInsets.only(
                //           bottom: GlobalVariable.ratioHeight(Get.context) * 12,
                //           left: GlobalVariable.ratioWidth(Get.context) * 17,
                //           right: GlobalVariable.ratioWidth(Get.context) * 17),
                //       decoration: BoxDecoration(
                //         boxShadow: <BoxShadow>[
                //           BoxShadow(
                //             color: Color(ListColor.colorLightGrey)
                //                 .withOpacity(0.5),
                //             blurRadius: 10,
                //             spreadRadius: 2,
                //           ),
                //         ],
                //         borderRadius: BorderRadius.circular(12),
                //         color: Colors.white,
                //       ),
                //       child: Column(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           Container(
                //             decoration: BoxDecoration(
                //                 color: Color(ListColor.colorLightBlue6),
                //                 borderRadius: BorderRadius.only(
                //                     topLeft: Radius.circular(12),
                //                     topRight: Radius.circular(12))),
                //             padding: EdgeInsets.fromLTRB(
                //                 GlobalVariable.ratioWidth(Get.context) * 16,
                //                 GlobalVariable.ratioWidth(Get.context) * 9,
                //                 GlobalVariable.ratioWidth(Get.context) * 13,
                //                 GlobalVariable.ratioWidth(Get.context) * 7),
                //             child: Row(
                //               mainAxisSize: MainAxisSize.max,
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               children: [
                //                 _circleAvatar(
                //                     controller
                //                         .listSearchTrukSiapMuat[index].avatar,
                //                     controller
                //                         .listSearchTrukSiapMuat[index].initial),
                //                 SizedBox(
                //                     width:
                //                         GlobalVariable.ratioWidth(Get.context) *
                //                             16),
                //                 Expanded(
                //                     child: Column(
                //                   mainAxisSize: MainAxisSize.min,
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Row(
                //                       mainAxisSize: MainAxisSize.max,
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.center,
                //                       children: [
                //                         !controller
                //                                 .listSearchTrukSiapMuat[index]
                //                                 .isGold
                //                             ? SizedBox.shrink()
                //                             : Container(
                //                                 margin: EdgeInsets.only(
                //                                     right: GlobalVariable
                //                                             .ratioWidth(
                //                                                 Get.context) *
                //                                         3),
                //                                 child: Image(
                //                                   image: AssetImage(
                //                                       "assets/ic_gold.png"),
                //                                   height: GlobalVariable
                //                                           .ratioHeight(
                //                                               Get.context) *
                //                                       15,
                //                                 ),
                //                               ),
                //                         Expanded(
                //                           child: CustomText(
                //                               controller
                //                                   .listSearchTrukSiapMuat[index]
                //                                   .namaTransporter,
                //                               height: 1.2,
                //                               fontWeight: FontWeight.w600,
                //                               color: Color(
                //                                   ListColor.colorLightGrey4)),
                //                         )
                //                       ],
                //                     ),
                //                     SizedBox(height: 2),
                //                     CustomText(
                //                         controller.listSearchTrukSiapMuat[index]
                //                             .kotaTransporter,
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.w500,
                //                         color: Color(ListColor.colorGrey3))
                //                   ],
                //                 )),
                //                 Container(
                //                     child: Column(
                //                   mainAxisSize: MainAxisSize.min,
                //                   crossAxisAlignment: CrossAxisAlignment.end,
                //                   children: [
                //                     CustomText(
                //                         controller.listSearchTrukSiapMuat[index]
                //                             .lastUpdateTanggal,
                //                         fontSize: 8,
                //                         fontWeight: FontWeight.w600,
                //                         color: Color(ListColor.color4)),
                //                     CustomText(
                //                         controller.listSearchTrukSiapMuat[index]
                //                             .lastUpdateWaktu,
                //                         fontSize: 8,
                //                         fontWeight: FontWeight.w600,
                //                         color: Color(ListColor.color4)),
                //                   ],
                //                 )),
                //                 SizedBox(
                //                     width:
                //                         GlobalVariable.ratioWidth(Get.context) *
                //                             10),
                //                 GestureDetector(
                //                     onTap: () {
                //                       controller.optionGroupMitra(
                //                           controller
                //                               .listSearchTrukSiapMuat[index],
                //                           index);
                //                     },
                //                     child: Container(
                //                       alignment: Alignment.centerRight,
                //                       width: GlobalVariable.ratioWidth(
                //                               Get.context) *
                //                           16,
                //                       height: GlobalVariable.ratioWidth(
                //                               Get.context) *
                //                           16,
                //                       child: Icon(Icons.more_vert,
                //                           size: GlobalVariable.ratioWidth(
                //                                   Get.context) *
                //                               16),
                //                     ))
                //               ],
                //             ),
                //           ),
                //           SizedBox(
                //               height:
                //                   GlobalVariable.ratioHeight(Get.context) * 13),
                //           Container(
                //             margin: EdgeInsets.symmetric(
                //                 horizontal:
                //                     GlobalVariable.ratioWidth(Get.context) *
                //                         16),
                //             child: Row(
                //               mainAxisSize: MainAxisSize.max,
                //               children: [
                //                 Container(
                //                   width:
                //                       GlobalVariable.ratioWidth(Get.context) *
                //                           32,
                //                   alignment: Alignment.centerLeft,
                //                   child: Container(
                //                     margin: EdgeInsets.only(
                //                         left: GlobalVariable.ratioWidth(
                //                                 Get.context) *
                //                             3),
                //                     width:
                //                         GlobalVariable.ratioWidth(Get.context) *
                //                             9,
                //                     height:
                //                         GlobalVariable.ratioWidth(Get.context) *
                //                             9,
                //                     decoration: BoxDecoration(
                //                         borderRadius: BorderRadius.all(
                //                             Radius.circular(20)),
                //                         border: Border.all(
                //                             color: Color(ListColor.color4),
                //                             width: 2),
                //                         color: Color(ListColor.color4)),
                //                   ),
                //                 ),
                //                 Expanded(
                //                   child: CustomText(
                //                     controller.listSearchTrukSiapMuat[index]
                //                         .areaPickup,
                //                     overflow: TextOverflow.ellipsis,
                //                     fontSize: 12,
                //                     fontWeight: FontWeight.w500,
                //                     color: Color(ListColor.colorLightGrey4),
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //           Container(
                //             margin: EdgeInsets.symmetric(
                //                 horizontal:
                //                     GlobalVariable.ratioWidth(Get.context) *
                //                         16),
                //             child: Align(
                //               alignment: Alignment.centerLeft,
                //               child: Container(
                //                 margin: EdgeInsets.only(
                //                     left:
                //                         GlobalVariable.ratioWidth(Get.context) *
                //                             6.25),
                //                 child: Dash(
                //                   direction: Axis.vertical,
                //                   length: 13,
                //                   dashLength: 5,
                //                   dashThickness:
                //                       GlobalVariable.ratioWidth(Get.context) *
                //                           1.5,
                //                   dashColor: Color(ListColor.color4),
                //                 ),
                //               ),
                //             ),
                //           ),
                //           Container(
                //             margin: EdgeInsets.symmetric(
                //                 horizontal:
                //                     GlobalVariable.ratioWidth(Get.context) *
                //                         16),
                //             child: Row(
                //               children: [
                //                 Container(
                //                   width:
                //                       GlobalVariable.ratioWidth(Get.context) *
                //                           32,
                //                   alignment: Alignment.centerLeft,
                //                   child: Container(
                //                     margin: EdgeInsets.only(
                //                         left: GlobalVariable.ratioWidth(
                //                                 Get.context) *
                //                             3),
                //                     width:
                //                         GlobalVariable.ratioWidth(Get.context) *
                //                             9,
                //                     height:
                //                         GlobalVariable.ratioWidth(Get.context) *
                //                             9,
                //                     decoration: BoxDecoration(
                //                         borderRadius: BorderRadius.all(
                //                             Radius.circular(20)),
                //                         border: Border.all(
                //                             color: Color(ListColor.color4),
                //                             width: 2),
                //                         color: Colors.white),
                //                   ),
                //                 ),
                //                 Expanded(
                //                   child: CustomText(
                //                     controller.listSearchTrukSiapMuat[index]
                //                         .ekspektasiDestinasi,
                //                     overflow: TextOverflow.ellipsis,
                //                     fontSize: 12,
                //                     fontWeight: FontWeight.w500,
                //                     color: Color(ListColor.colorLightGrey4),
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //           SizedBox(
                //               height:
                //                   GlobalVariable.ratioHeight(Get.context) * 13),
                //           Container(
                //             margin: EdgeInsets.symmetric(
                //                 horizontal:
                //                     GlobalVariable.ratioWidth(Get.context) *
                //                         16),
                //             child: Row(
                //               mainAxisSize: MainAxisSize.max,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Container(
                //                   width:
                //                       GlobalVariable.ratioWidth(Get.context) *
                //                           32,
                //                   alignment: Alignment.centerLeft,
                //                   child: Container(
                //                     width: 17,
                //                     height: 17,
                //                     child: SvgPicture.asset(
                //                         "assets/ic_posisi_truk.svg"),
                //                   ),
                //                 ),
                //                 Expanded(
                //                   child: CustomText(
                //                     controller.listSearchTrukSiapMuat[index]
                //                         .posisiTruk,
                //                     overflow: TextOverflow.ellipsis,
                //                     fontSize: 12,
                //                     height: 1.2,
                //                     maxLines: 2,
                //                     fontWeight: FontWeight.w500,
                //                     color: Color(ListColor.colorLightGrey4),
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //           SizedBox(
                //               height:
                //                   GlobalVariable.ratioHeight(Get.context) * 13),
                //           Container(
                //             margin: EdgeInsets.symmetric(
                //                 horizontal:
                //                     GlobalVariable.ratioWidth(Get.context) *
                //                         16),
                //             child: Row(
                //               children: [
                //                 Container(
                //                     width:
                //                         GlobalVariable.ratioWidth(Get.context) *
                //                             32,
                //                     alignment: Alignment.centerLeft,
                //                     child: Container(
                //                       width: 17,
                //                       height: 17,
                //                       child: SvgPicture.asset(
                //                           "assets/number_truck_icon.svg"),
                //                     )),
                //                 CustomText(
                //                   controller.listSearchTrukSiapMuat[index]
                //                           .siapMuat
                //                           .toString() +
                //                       " Unit",
                //                   overflow: TextOverflow.ellipsis,
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w500,
                //                   color: Color(ListColor.colorLightGrey4),
                //                 )
                //               ],
                //             ),
                //           ),
                //           SizedBox(
                //               height:
                //                   GlobalVariable.ratioHeight(Get.context) * 13),
                //           Container(
                //             height: 0.5,
                //             color: Color(ListColor.colorLightGrey2),
                //             width: double.infinity,
                //           ),
                //           Container(
                //               padding: EdgeInsets.symmetric(
                //                   horizontal:
                //                       GlobalVariable.ratioWidth(Get.context) *
                //                           16,
                //                   vertical:
                //                       GlobalVariable.ratioHeight(Get.context) *
                //                           7),
                //               alignment: Alignment.centerRight,
                //               width: double.infinity,
                //               child: GestureDetector(
                //                 onTap: () {
                //                   controller.openDetailLokasi(
                //                       controller.listSearchTrukSiapMuat[index]);
                //                 },
                //                 child: Container(
                //                   padding: EdgeInsets.symmetric(
                //                       horizontal: GlobalVariable.ratioWidth(
                //                               Get.context) *
                //                           23,
                //                       vertical: GlobalVariable.ratioHeight(
                //                               Get.context) *
                //                           6),
                //                   decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(20),
                //                       color: Color(ListColor.color4)),
                //                   child: CustomText("Detail",
                //                       color: Colors.white,
                //                       fontSize: 12,
                //                       fontWeight: FontWeight.w600),
                //                 ),
                //               ))
                //         ],
                //       ),
                //     );
                //     //mitraTile2(controller.listMitra[index]);
                //   },
                // ),
              ),
              // child: SingleChildScrollView(
              //   controller: controller.scrollController,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Container(
              //         margin: EdgeInsets.only(
              //             left: GlobalVariable.ratioWidth(Get.context) * 17),
              //         child: ButtonFilterWidget(
              //             onTap: () => controller.showFilterOption()),
              //       ),
              //       SizedBox(
              //           height: GlobalVariable.ratioWidth(Get.context) * 12),
              //       for (var index = 0;
              //           index < controller.listSearchTrukSiapMuat.length;
              //           index++)
              //         Container(
              //           width: MediaQuery.of(Get.context).size.width,
              //           margin: EdgeInsets.only(
              //               bottom:
              //                   GlobalVariable.ratioHeight(Get.context) * 12,
              //               left: GlobalVariable.ratioWidth(Get.context) * 17,
              //               right:
              //                   GlobalVariable.ratioWidth(Get.context) * 17),
              //           decoration: BoxDecoration(
              //             boxShadow: <BoxShadow>[
              //               BoxShadow(
              //                 color: Color(ListColor.colorLightGrey)
              //                     .withOpacity(0.5),
              //                 blurRadius: 10,
              //                 spreadRadius: 2,
              //               ),
              //             ],
              //             borderRadius: BorderRadius.circular(12),
              //             color: Colors.white,
              //           ),
              //           child: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               Container(
              //                 decoration: BoxDecoration(
              //                     color: Color(ListColor.colorLightBlue6),
              //                     borderRadius: BorderRadius.only(
              //                         topLeft: Radius.circular(12),
              //                         topRight: Radius.circular(12))),
              //                 padding: EdgeInsets.fromLTRB(
              //                     GlobalVariable.ratioWidth(Get.context) * 16,
              //                     GlobalVariable.ratioWidth(Get.context) * 9,
              //                     GlobalVariable.ratioWidth(Get.context) * 13,
              //                     GlobalVariable.ratioWidth(Get.context) * 7),
              //                 child: Row(
              //                   mainAxisSize: MainAxisSize.max,
              //                   crossAxisAlignment: CrossAxisAlignment.center,
              //                   children: [
              //                     _circleAvatar(
              //                         controller.listSearchTrukSiapMuat[index]
              //                             .avatar,
              //                         controller.listSearchTrukSiapMuat[index]
              //                             .initial),
              //                     SizedBox(
              //                         width: GlobalVariable.ratioWidth(
              //                                 Get.context) *
              //                             16),
              //                     Expanded(
              //                         child: Column(
              //                       mainAxisSize: MainAxisSize.min,
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Row(
              //                           mainAxisSize: MainAxisSize.max,
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.center,
              //                           children: [
              //                             !controller
              //                                     .listSearchTrukSiapMuat[
              //                                         index]
              //                                     .isGold
              //                                 ? SizedBox.shrink()
              //                                 : Container(
              //                                     margin: EdgeInsets.only(
              //                                         right: GlobalVariable
              //                                                 .ratioWidth(Get
              //                                                     .context) *
              //                                             3),
              //                                     child: Image(
              //                                       image: AssetImage(
              //                                           "assets/ic_gold.png"),
              //                                       height: GlobalVariable
              //                                               .ratioHeight(
              //                                                   Get.context) *
              //                                           15,
              //                                     ),
              //                                   ),
              //                             Expanded(
              //                               child: CustomText(
              //                                   controller
              //                                       .listSearchTrukSiapMuat[
              //                                           index]
              //                                       .namaTransporter,
              //                                   height: 1.2,
              //                                   fontWeight: FontWeight.w600,
              //                                   color: Color(ListColor
              //                                       .colorLightGrey4)),
              //                             )
              //                           ],
              //                         ),
              //                         SizedBox(height: 2),
              //                         CustomText(
              //                             controller
              //                                 .listSearchTrukSiapMuat[index]
              //                                 .kotaTransporter,
              //                             fontSize: 12,
              //                             fontWeight: FontWeight.w500,
              //                             color: Color(ListColor.colorGrey3))
              //                       ],
              //                     )),
              //                     Container(
              //                         child: Column(
              //                       mainAxisSize: MainAxisSize.min,
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.end,
              //                       children: [
              //                         CustomText(
              //                             controller
              //                                 .listSearchTrukSiapMuat[index]
              //                                 .lastUpdateTanggal,
              //                             fontSize: 8,
              //                             fontWeight: FontWeight.w600,
              //                             color: Color(ListColor.color4)),
              //                         CustomText(
              //                             controller
              //                                 .listSearchTrukSiapMuat[index]
              //                                 .lastUpdateWaktu,
              //                             fontSize: 8,
              //                             fontWeight: FontWeight.w600,
              //                             color: Color(ListColor.color4)),
              //                       ],
              //                     )),
              //                     SizedBox(
              //                         width: GlobalVariable.ratioWidth(
              //                                 Get.context) *
              //                             10),
              //                     GestureDetector(
              //                         onTap: () {
              //                           controller.optionGroupMitra(
              //                               controller.listSearchTrukSiapMuat[
              //                                   index],
              //                               index);
              //                         },
              //                         child: Container(
              //                           alignment: Alignment.centerRight,
              //                           width: GlobalVariable.ratioWidth(
              //                                   Get.context) *
              //                               16,
              //                           height: GlobalVariable.ratioWidth(
              //                                   Get.context) *
              //                               16,
              //                           child: Icon(Icons.more_vert,
              //                               size: GlobalVariable.ratioWidth(
              //                                       Get.context) *
              //                                   16),
              //                         ))
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(
              //                   height:
              //                       GlobalVariable.ratioHeight(Get.context) *
              //                           13),
              //               Container(
              //                 margin: EdgeInsets.symmetric(
              //                     horizontal:
              //                         GlobalVariable.ratioWidth(Get.context) *
              //                             16),
              //                 child: Row(
              //                   mainAxisSize: MainAxisSize.max,
              //                   children: [
              //                     Container(
              //                       width: GlobalVariable.ratioWidth(
              //                               Get.context) *
              //                           32,
              //                       alignment: Alignment.centerLeft,
              //                       child: Container(
              //                         margin: EdgeInsets.only(
              //                             left: GlobalVariable.ratioWidth(
              //                                     Get.context) *
              //                                 3),
              //                         width: GlobalVariable.ratioWidth(
              //                                 Get.context) *
              //                             9,
              //                         height: GlobalVariable.ratioWidth(
              //                                 Get.context) *
              //                             9,
              //                         decoration: BoxDecoration(
              //                             borderRadius: BorderRadius.all(
              //                                 Radius.circular(20)),
              //                             border: Border.all(
              //                                 color: Color(ListColor.color4),
              //                                 width: 2),
              //                             color: Color(ListColor.color4)),
              //                       ),
              //                     ),
              //                     Expanded(
              //                       child: CustomText(
              //                         controller.listSearchTrukSiapMuat[index]
              //                             .areaPickup,
              //                         overflow: TextOverflow.ellipsis,
              //                         fontSize: 12,
              //                         fontWeight: FontWeight.w500,
              //                         color: Color(ListColor.colorLightGrey4),
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //               Container(
              //                 margin: EdgeInsets.symmetric(
              //                     horizontal:
              //                         GlobalVariable.ratioWidth(Get.context) *
              //                             16),
              //                 child: Align(
              //                   alignment: Alignment.centerLeft,
              //                   child: Container(
              //                     margin: EdgeInsets.only(
              //                         left: GlobalVariable.ratioWidth(
              //                                 Get.context) *
              //                             6.25),
              //                     child: Dash(
              //                       direction: Axis.vertical,
              //                       length: 13,
              //                       dashLength: 5,
              //                       dashThickness: GlobalVariable.ratioWidth(
              //                               Get.context) *
              //                           1.5,
              //                       dashColor: Color(ListColor.color4),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               Container(
              //                 margin: EdgeInsets.symmetric(
              //                     horizontal:
              //                         GlobalVariable.ratioWidth(Get.context) *
              //                             16),
              //                 child: Row(
              //                   children: [
              //                     Container(
              //                       width: GlobalVariable.ratioWidth(
              //                               Get.context) *
              //                           32,
              //                       alignment: Alignment.centerLeft,
              //                       child: Container(
              //                         margin: EdgeInsets.only(
              //                             left: GlobalVariable.ratioWidth(
              //                                     Get.context) *
              //                                 3),
              //                         width: GlobalVariable.ratioWidth(
              //                                 Get.context) *
              //                             9,
              //                         height: GlobalVariable.ratioWidth(
              //                                 Get.context) *
              //                             9,
              //                         decoration: BoxDecoration(
              //                             borderRadius: BorderRadius.all(
              //                                 Radius.circular(20)),
              //                             border: Border.all(
              //                                 color: Color(ListColor.color4),
              //                                 width: 2),
              //                             color: Colors.white),
              //                       ),
              //                     ),
              //                     Expanded(
              //                       child: CustomText(
              //                         controller.listSearchTrukSiapMuat[index]
              //                             .ekspektasiDestinasi,
              //                         overflow: TextOverflow.ellipsis,
              //                         fontSize: 12,
              //                         fontWeight: FontWeight.w500,
              //                         color: Color(ListColor.colorLightGrey4),
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(
              //                   height:
              //                       GlobalVariable.ratioHeight(Get.context) *
              //                           13),
              //               Container(
              //                 margin: EdgeInsets.symmetric(
              //                     horizontal:
              //                         GlobalVariable.ratioWidth(Get.context) *
              //                             16),
              //                 child: Row(
              //                   mainAxisSize: MainAxisSize.max,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Container(
              //                       width: GlobalVariable.ratioWidth(
              //                               Get.context) *
              //                           32,
              //                       alignment: Alignment.centerLeft,
              //                       child: Container(
              //                         width: 17,
              //                         height: 17,
              //                         child: SvgPicture.asset(
              //                             "assets/ic_posisi_truk.svg"),
              //                       ),
              //                     ),
              //                     Expanded(
              //                       child: CustomText(
              //                         controller.listSearchTrukSiapMuat[index]
              //                             .posisiTruk,
              //                         overflow: TextOverflow.ellipsis,
              //                         fontSize: 12,
              //                         height: 1.2,
              //                         maxLines: 2,
              //                         fontWeight: FontWeight.w500,
              //                         color: Color(ListColor.colorLightGrey4),
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(
              //                   height:
              //                       GlobalVariable.ratioHeight(Get.context) *
              //                           13),
              //               Container(
              //                 margin: EdgeInsets.symmetric(
              //                     horizontal:
              //                         GlobalVariable.ratioWidth(Get.context) *
              //                             16),
              //                 child: Row(
              //                   children: [
              //                     Container(
              //                         width: GlobalVariable.ratioWidth(
              //                                 Get.context) *
              //                             32,
              //                         alignment: Alignment.centerLeft,
              //                         child: Container(
              //                           width: 17,
              //                           height: 17,
              //                           child: SvgPicture.asset(
              //                               "assets/number_truck_icon.svg"),
              //                         )),
              //                     CustomText(
              //                       controller.listSearchTrukSiapMuat[index]
              //                               .siapMuat
              //                               .toString() +
              //                           " Unit",
              //                       overflow: TextOverflow.ellipsis,
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w500,
              //                       color: Color(ListColor.colorLightGrey4),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(
              //                   height:
              //                       GlobalVariable.ratioHeight(Get.context) *
              //                           13),
              //               Container(
              //                 height: 0.5,
              //                 color: Color(ListColor.colorLightGrey2),
              //                 width: double.infinity,
              //               ),
              //               Container(
              //                   padding: EdgeInsets.symmetric(
              //                       horizontal: GlobalVariable.ratioWidth(
              //                               Get.context) *
              //                           16,
              //                       vertical: GlobalVariable.ratioHeight(
              //                               Get.context) *
              //                           7),
              //                   alignment: Alignment.centerRight,
              //                   width: double.infinity,
              //                   child: GestureDetector(
              //                     onTap: () {
              //                       controller.openDetailLokasi(controller
              //                           .listSearchTrukSiapMuat[index]);
              //                     },
              //                     child: Container(
              //                       padding: EdgeInsets.symmetric(
              //                           horizontal: GlobalVariable.ratioWidth(
              //                                   Get.context) *
              //                               23,
              //                           vertical: GlobalVariable.ratioHeight(
              //                                   Get.context) *
              //                               6),
              //                       decoration: BoxDecoration(
              //                           borderRadius:
              //                               BorderRadius.circular(20),
              //                           color: Color(ListColor.color4)),
              //                       child: CustomText("Detail",
              //                           color: Colors.white,
              //                           fontSize: 12,
              //                           fontWeight: FontWeight.w600),
              //                     ),
              //                   ))
              //             ],
              //           ),
              //         )
              //     ],
              //   ),
              // )
            )),
        onSheetMoved: (sheetPosition) {
          controller.showFilter.value = (sheetPosition.pixels > 300);
          controller.currSheetPosition.value = sheetPosition.pixels;
        },
        onSnapCompleted: (sheetPosition, snappingPosition) {
          controller.showRound.value =
              controller.listSnapping[1] != snappingPosition;
        },
      ),
    );
  }

  Widget _circleAvatar(String urlImage, String initials) {
    return Material(
        shape: CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: Container(
          width: GlobalVariable.ratioWidth(Get.context) * 32,
          height: GlobalVariable.ratioWidth(Get.context) * 32,
          child: urlImage == ""
              ? _defaultAvatar(initials: initials)
              : CachedNetworkImage(
                  errorWidget: (context, value, err) => _defaultAvatar(),
                  imageUrl: GlobalVariable.urlImage + urlImage,
                  imageBuilder: (context, imageProvider) => Container(
                    width: GlobalVariable.ratioWidth(Get.context) * 32,
                    height: GlobalVariable.ratioWidth(Get.context) * 32,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                ),
        ));
  }

  Widget _defaultAvatar({String initials = ""}) {
    return Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: initials.isEmpty ? Colors.white : Color(ListColor.color4),
            borderRadius: BorderRadius.all(Radius.circular(35))),
        child: CustomText(
            initials.substring(0, initials.length > 2 ? 2 : initials.length),
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16));
  }

  Widget emptySearchWidget(String areaPickup, String destinasi,
      String jenisTruk, String jenisCarrier) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 60),
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
                width: GlobalVariable.ratioWidth(Get.context) * 82,
                image: AssetImage(
                    "assets/search_lokasi_truk_siap_muat_empty.png")),
            Container(height: GlobalVariable.ratioHeight(Get.context) * 18),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text:
                        "Pencarian untuk\n$areaPickup - $destinasi,\n$jenisTruk/$jenisCarrier tidak ditemukan.\n",
                    style: TextStyle(
                        fontSize: GlobalVariable.ratioHeight(Get.context) * 12,
                        height: 1.4,
                        color: Color(ListColor.colorLightGrey4),
                        fontWeight: FontWeight.w500)),
                TextSpan(
                    text: "Ganti Pencarian Anda",
                    style: TextStyle(
                        fontSize: GlobalVariable.ratioHeight(Get.context) * 12,
                        height: 1.4,
                        color: Color(ListColor.color4),
                        fontWeight: FontWeight.w500),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.back())
              ]),
            ),
          ],
        ));
  }
}

class GrabbingWidget extends StatelessWidget {
  GrabbingWidget(
    this.showRound,
    this.jumlahTruk,
    this.areaPickup,
    this.destinasi,
    this.jenisTruk,
    this.jenisCarrier,
  );

  bool showRound;
  int jumlahTruk;
  String areaPickup;
  String destinasi;
  String jenisTruk;
  String jenisCarrier;
  var currSheetPosition;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: GlobalVariable.ratioHeight(context) * 118,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            !showRound ? null : BorderRadius.vertical(
              top: Radius.circular(
                GlobalVariable.ratioHeight(context) * 12,
              ),
        ),
        boxShadow: [
          BoxShadow(blurRadius: GlobalVariable.ratioHeight(context) * 25, color: Colors.black.withOpacity(0.2)),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioHeight(context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(
                  top: GlobalVariable.ratioHeight(context) * 3,
                  bottom: GlobalVariable.ratioHeight(context) * 13),
              width: 40,
              height: GlobalVariable.ratioHeight(context) * 3,
              decoration: BoxDecoration(
                color: Color(ListColor.colorLightGrey16),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText("Hasil Pencarian",
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(ListColor.colorLightGrey4),
                withoutExtraPadding: true,
              ),
              SizedBox(
                height: GlobalVariable.ratioHeight(context) * 5,
              ),
              CustomText(
                "Ditemukan $jumlahTruk unit truk siap muat untuk $areaPickup - $destinasi, $jenisTruk/$jenisCarrier",
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.4,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                color: Color(ListColor.colorGrey4),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: CustomText("Ganti Pencarian >",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.4,
                  color: Color(ListColor.color4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
