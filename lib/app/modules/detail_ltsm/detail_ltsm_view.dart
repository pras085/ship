import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/detail_ltsm/detail_ltsm_controller.dart';
import 'package:muatmuat/app/modules/detail_ltsm/marker_truck.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_detail.dart';
import 'package:muatmuat/app/widgets/button_filter_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:flutter_dash/flutter_dash.dart';

class DetailLTSMView extends GetView<DetailLTSMController> {
  final double _widthHeightAvatar = 95;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
        onWillPop: controller.onWillPop,
        child: Container(
          color: Colors.white,
          child: Obx(
            () => Scaffold(
              appBar: AppBarDetail(
                onClickBack: () async {
                  var result = await controller.onWillPop();
                  if (result) {
                    Get.back();
                  }
                },
                title: controller.isDetailLocationOnly.value
                    ? "LTSMSDLTitle".tr
                    : "LTSMSSLTitle".tr,
                prefixIcon: [
                  controller.isDetailLocationOnly.value
                      ? SizedBox.shrink()
                      : Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              controller.showSort();
                            },
                            child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: controller.isUsingSort.value
                                      ? Color(ListColor.color4)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                    "assets/sorting_icon.svg",
                                    color: controller.isUsingSort.value
                                        ? Colors.white
                                        : Color(ListColor.color4))),
                          ),
                        ),
                ],
              ),
              body: SafeArea(
                child: SnappingSheet(
                  controller: controller.snappingSheetController,
                  lockOverflowDrag: true,
                  child: _buildMap(context),
                  sheetAbove: null,
                  onSheetMoved: (pos) {
                    controller.setPositionSnapping(
                        pos.relativeToSnappingPositions);
                  },
                  onSnapCompleted: (data, pos) {
                    controller.checkWhenEndSnapping();
                  },
                  grabbingHeight: GlobalVariable.ratioWidth(context) * 121,
                  grabbing: Obx(
                    () => Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x54000000),
                            spreadRadius: GlobalVariable.ratioWidth(context) * 2,
                            blurRadius: GlobalVariable.ratioWidth(context) * 80,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 10),
                          topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 10),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                margin: EdgeInsets.only(
                                    top: GlobalVariable
                                            .ratioHeight(
                                                Get.context) *
                                        3),
                                child: Container(
                                  width:
                                      GlobalVariable.ratioWidth(
                                              Get.context) *
                                          38,
                                  height:
                                      GlobalVariable.ratioHeight(
                                              Get.context) *
                                          3,
                                  decoration: BoxDecoration(
                                      color: Color(ListColor
                                          .colorLightGrey),
                                      borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  GlobalVariable.ratioWidth(context) * 20))),
                                )),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: GlobalVariable.ratioWidth(
                                          Get.context) *
                                      20,
                                  vertical: GlobalVariable.ratioWidth(context) * 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                children: [
                                  _defaultAvatar(
                                      widthHeightAvatar:
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              68),
                                  SizedBox(
                                    width: GlobalVariable.ratioWidth(
                                            Get.context) *
                                        14,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            controller.transporterName,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                        !controller.isGoldTransporter
                                            ? SizedBox.shrink()
                                            : Row(
                                                mainAxisSize:
                                                    MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                children: [
                                                  Image(
                                                    image: AssetImage(
                                                        "assets/ic_gold.png"),
                                                    width: GlobalVariable
                                                            .ratioWidth(Get
                                                                .context) *
                                                        14,
                                                  ),
                                                  SizedBox(
                                                    width: GlobalVariable
                                                            .ratioHeight(Get
                                                                .context) *
                                                        6,
                                                  ),
                                                  CustomText(
                                                      'GlobalFilterGoldenTransporter'
                                                          .tr,
                                                      color: Color(
                                                          0xFFD49A29),
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight
                                                              .bold),
                                                  SizedBox(
                                                    width: GlobalVariable
                                                            .ratioHeight(Get
                                                                .context) *
                                                        6,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .showGoldInfo();
                                                      },
                                                      child: Icon(
                                                          Icons
                                                              .info_outline,
                                                          color: Color(
                                                              ListColor
                                                                  .colorBlue),
                                                          size: GlobalVariable
                                                                  .ratioHeight(
                                                                      Get.context) *
                                                              10))
                                                ],
                                              ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            _buttonPrioritySecondary(() {
                                              Get.toNamed(
                                                  Routes.TRANSPORTER,
                                                  arguments: [
                                                    controller
                                                        .transporterID
                                                  ]);
                                            }, "LTSMSLabelProfile".tr,
                                                "LTSMSLabelCall".tr),
                                            SizedBox(
                                              width: GlobalVariable
                                                      .ratioWidth(
                                                          Get.context) *
                                                  8,
                                            ),
                                            _buttonPriorityPrimary(() {
                                              controller.showContact(
                                                  controller
                                                      .listMarker.first);
                                            }, "LTSMSLabelCall".tr,
                                                "LTSMSLabelProfile".tr),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  snappingPositions: controller.listSnapLocation,
                  sheetBelow: SnappingSheetContent(
                    draggable: false,
                    // childScrollController: controller.scrollController,
                    child: SingleChildScrollView(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: GlobalVariable.ratioWidth(context) * 20,
                                  blurRadius: GlobalVariable.ratioWidth(context) * 2,
                                  offset: Offset(0, GlobalVariable.ratioWidth(context) * 10)),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Obx(
                                () => controller.isDetailLocationOnly.value
                                    ? SizedBox.shrink()
                                    : Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        child: ButtonFilterWidget(
                                          onTap: () {
                                            controller.showFilter();
                                          },
                                          isActive: controller
                                              .isUsingFilter.value,
                                        ),
                                      ),
                              ),
                              Obx(() => controller.isDetailLocationOnly.value ? SizedBox.shrink() : SizedBox(
                                height: GlobalVariable.ratioWidth(context) * 5,
                              )),
                              Obx(
                                () => controller.isShowLoadingManual.value
                                    ? Center(
                                        child: Container(
                                        width: GlobalVariable.ratioWidth(context) * 30,
                                        height: GlobalVariable.ratioWidth(context) * 30,
                                        child: CircularProgressIndicator(),
                                      ))
                                    : controller.listMarker.length == 0
                                        ? Center(
                                            child: Column(
                                            mainAxisSize:
                                                MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    "assets/ic_no_data.png"),
                                                height: GlobalVariable
                                                        .ratioHeight(
                                                            Get.context) *
                                                    82,
                                              ),
                                              SizedBox(
                                                  height: (GlobalVariable
                                                              .ratioHeight(Get
                                                                  .context) *
                                                          19) -
                                                      FontTopPadding
                                                          .getSize(14)),
                                              CustomText(
                                                  "Tidak Ada Data \nLokasi Truk Siap Muat",
                                                  fontSize: 14,
                                                  height: 1.2,
                                                  textAlign:
                                                      TextAlign.center,
                                                  color: Color(ListColor
                                                      .colorGrey3),
                                                  fontWeight:
                                                      FontWeight.w600)
                                            ],
                                          ))
                                        : ListView.builder(
                                            controller: controller
                                                .scrollController,
                                            shrinkWrap: true,
                                            itemCount: controller
                                                .listMarker.length,
                                            itemBuilder: (context, pos) {
                                              return _perItem(controller
                                                  .listMarker[pos]);
                                            }),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buttonPriorityPrimary(Function onTapPriority,
      String labelButtonPriority, String labelButtonPriorityShadow) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          minimumSize: Size.zero,
          backgroundColor: Color(ListColor.color4),
          side: BorderSide(width: 2, color: Color(ListColor.color4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          )),
      onPressed: () {
        if (onTapPriority != null) onTapPriority();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 6,
            vertical: GlobalVariable.ratioHeight(Get.context) * 6),
        child: Stack(alignment: Alignment.center, children: [
          CustomText(labelButtonPriorityShadow,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.transparent),
          CustomText(labelButtonPriority,
              fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
        ]),
      ),
    );
  }

  Widget _perItem(MarkerTruck marker) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 20,
          vertical: GlobalVariable.ratioHeight(Get.context) * 6),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(ListColor.colorLightGrey).withOpacity(0.5),
          blurRadius: GlobalVariable.ratioWidth(Get.context) * 10,
          spreadRadius: GlobalVariable.ratioWidth(Get.context) * 2,
          offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 5),
        ),
      ], borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 14,
                vertical: GlobalVariable.ratioWidth(Get.context) * 10),
            decoration: BoxDecoration(
                color: Color(ListColor.colorLightBlue6),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                    topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomText(marker.baseLTSMMarkerModel.kode,
                      color: Color(ListColor.colorLightGrey4),
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 10,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(
                      "LTSMSLabelLastChange".tr,
                      color: Color(ListColor.color4),
                      fontSize: 9,
                    ),
                    CustomText(
                      marker.baseLTSMMarkerModel.lastUpdate,
                      color: Color(ListColor.color4),
                      fontSize: 9,
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding:
                EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                bottomRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 32,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 2),
                        width: GlobalVariable.ratioWidth(Get.context) * 9,
                        height: GlobalVariable.ratioWidth(Get.context) * 9,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(ListColor.color4),
                            border: Border.all(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 2,
                                color: Color(ListColor.color4))),
                      ),
                    ),
                    Expanded(
                      child: CustomText(
                        marker.baseLTSMMarkerModel.address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(ListColor.colorGrey4),
                      ),
                    )
                  ],
                ),
                Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 32,
                  padding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 5),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Dash(
                      direction: Axis.vertical,
                      length: GlobalVariable.ratioHeight(Get.context) * 14,
                      dashLength: 4,
                      dashThickness: 3,
                      dashBorderRadius: 10,
                      dashColor: Color(ListColor.color4),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 32,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 2),
                        width: GlobalVariable.ratioWidth(Get.context) * 9,
                        height: GlobalVariable.ratioWidth(Get.context) * 9,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 2,
                                color: Color(ListColor.color4))),
                      ),
                    ),
                    Expanded(
                      child: CustomText(marker.baseLTSMMarkerModel.destinasi,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(ListColor.colorGrey4)),
                    ),
                  ],
                ),
                SizedBox(
                  height: GlobalVariable.ratioHeight(Get.context) * 14,
                ),
                _itemLTSM("assets/truck_position_icon.svg",
                    marker.baseLTSMMarkerModel.truckPosition,
                    prefixWidget: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.checkDetail(marker);
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: CustomText(
                              "LTSMSLabelLookMap".tr,
                              fontSize: 12,
                              color: Color(ListColor.color4),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    )),
                SizedBox(
                  height: GlobalVariable.ratioHeight(Get.context) * 14,
                ),
                _itemLTSM(
                    "assets/number_truck_icon.svg",
                    marker.baseLTSMMarkerModel.truck +
                        " - " +
                        marker.baseLTSMMarkerModel.jumlahTruk +
                        " Unit"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemLTSM(String urlIcon, String title, {Widget prefixWidget}) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              width: GlobalVariable.ratioWidth(Get.context) * 32,
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(urlIcon,
                  width: GlobalVariable.ratioWidth(Get.context) * 13)),
          Expanded(
              child: CustomText(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12,
                  color: Color(ListColor.colorGrey4),
                  fontWeight: FontWeight.w500)),
          prefixWidget == null ? SizedBox.shrink() : prefixWidget
        ],
      ),
    );
  }

  TextStyle _textStyleContentPerItem() => TextStyle();

  Widget _buttonPrioritySecondary(Function onTapPriority,
      String labelButtonPriority, String labelButtonPriorityShadow) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          minimumSize: Size.zero,
          backgroundColor: Colors.white,
          side: BorderSide(width: 2, color: Color(ListColor.color4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          )),
      onPressed: () {
        // Get.back();
        if (onTapPriority != null) onTapPriority();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 6,
            vertical: GlobalVariable.ratioHeight(Get.context) * 6),
        child: Stack(alignment: Alignment.center, children: [
          CustomText(labelButtonPriorityShadow,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.transparent),
          CustomText(labelButtonPriority,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(ListColor.color4)),
        ]),
      ),
    );
  }

  Widget _defaultAvatar({double widthHeightAvatar}) {
    widthHeightAvatar =
        widthHeightAvatar == null ? _widthHeightAvatar : widthHeightAvatar;
    return Container(
      width: widthHeightAvatar,
      height: widthHeightAvatar,
      decoration: BoxDecoration(
        color: Color(ListColor.colorPurple),
        shape: BoxShape.circle,
      ),
      child: Center(
          child: SvgPicture.asset("assets/detail_transporter_default_icon.svg",
              width: widthHeightAvatar / 2, height: widthHeightAvatar / 2)),
    );
  }

  Widget _buildMap(BuildContext context) {
    return Obx(
      () => FlutterMap(
        mapController: controller.mapController.value,
        options: MapOptions(
            interactiveFlags: InteractiveFlag.pinchMove |
                InteractiveFlag.pinchZoom |
                InteractiveFlag.drag,
            maxZoom: 18.0,
            center: GlobalVariable.centerMap,
            zoom: GlobalVariable.zoomMap,
            plugins: [PopupMarkerPlugin()],
            onTap: (_) {
              controller.hideAllPopUp();
            }),
        layers: [
          GlobalVariable.tileLayerOptions,
          PopupMarkerLayerOptions(
              markers: controller.listMarker
                  .map<MarkerTruck>((data) => data as MarkerTruck)
                  .toList(),
              popupSnap: PopupSnap.markerTop,
              popupController: controller.popupController,
              popupBuilder: (_, marker) {
                WidgetsBinding.instance.addPostFrameCallback(
                    (_) => controller.onWhenPopup(marker as MarkerTruck));
                if (marker is MarkerTruck) {
                  MarkerTruck mk = marker as MarkerTruck;
                  return Card(
                      child: Container(
                          padding: EdgeInsets.all(
                              GlobalVariable.ratioWidth(Get.context) * 8),
                          width: GlobalVariable.ratioWidth(Get.context) * 142,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  _defaultAvatar(
                                      widthHeightAvatar:
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              28),
                                  SizedBox(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        controller.isGoldTransporter
                                            ? Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Image(
                                                    image: AssetImage(
                                                        "assets/ic_gold.png"),
                                                    height: GlobalVariable
                                                            .ratioHeight(
                                                                Get.context) *
                                                        8,
                                                  ),
                                                  Expanded(
                                                    child: CustomText(
                                                        mk.baseLTSMMarkerModel
                                                            .transporterName,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        fontSize: 8,
                                                        color: Color(ListColor
                                                            .colorDarkGrey4),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              )
                                            : CustomText(
                                                mk.baseLTSMMarkerModel
                                                    .transporterName,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 8,
                                                color: Color(
                                                    ListColor.colorDarkGrey4),
                                                fontWeight: FontWeight.w600),
                                        SizedBox(height: 3),
                                        CustomText(
                                            mk.baseLTSMMarkerModel
                                                .truckPosition,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 7,
                                            color: Color(ListColor.colorGrey3)),
                                        // Text("Latlng: " +
                                        //     marker.point.latitude.toString() +
                                        //     ", " +
                                        //     marker.point.longitude.toString()),
                                      ],
                                    ),
                                  ),
                                ]),
                                SizedBox(
                                    height: GlobalVariable.ratioHeight(
                                            Get.context) *
                                        10),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.goToDetailTransporter(mk);
                                      },
                                      child: SvgPicture.asset(
                                          "assets/user_circle_icon.svg",
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              18,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              18),
                                    ),
                                    SizedBox(
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          6,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.showContact(mk);
                                      },
                                      child: SvgPicture.asset(
                                          "assets/phone_circle_icon.svg",
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              18,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              18),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: GlobalVariable.ratioHeight(
                                            Get.context) *
                                        5),
                                CustomText(
                                    "${mk.baseLTSMMarkerModel.jumlahTruk} " +
                                        "LTSMSLabelUnitAt".tr +
                                        " ${mk.baseLTSMMarkerModel.lastUpdateWaktu}",
                                    fontSize: 6,
                                    color: Color(ListColor.color4),
                                    fontWeight: FontWeight.w600),
                              ])));
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }
}
