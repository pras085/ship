import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/modules/location_truck_ready/location_truck_ready_controller.dart';
import 'package:muatmuat/app/modules/location_truck_ready/location_truck_ready_result_model.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LocationTruckReadyView extends GetView<LocationTruckReadyController> {
  var _slidingUpController = PanelController();
  FocusNode _focusNodeDestExpand = FocusNode();
  PopupController _popupController = PopupController();
  PopupController _popupControllerCircle = PopupController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.afterDone());
    return WillPopScope(
      onWillPop: () {
        return controller.onWillPop();
      },
      child: Scaffold(
          key: controller.scaffoldKey.value,
          body: Form(
            key: _formKey,
            child: SafeArea(
              child: Container(
                child: Stack(
                  children: [
                    Obx(() => _buildMap(context)), //buildMap(context)),
                    Obx(() => Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: ClipOval(
                                    child: Material(
                                        shape: CircleBorder(),
                                        color: Colors.white,
                                        child: InkWell(
                                            onTap: () async {
                                              controller.scrollController.value;
                                              //controller.showPerDistrict();
                                            },
                                            child: Container(
                                                width: 50,
                                                height: 50,
                                                child: Center(
                                                    child: Icon(
                                                  Icons.location_city,
                                                  size: 30,
                                                  color:
                                                      Color(ListColor.color4),
                                                ))))),
                                  ),
                                ),
                                SizedBox(height: 10),
                                // Visibility(
                                //   child: _detailTransporterWidget(context),
                                //   visible:
                                //       controller.isShowDetail.value ? true : false,
                                // ),
                                // Visibility(
                                //   child: _allLocationTransporterWidget(context),
                                //   visible: controller.isShowAllLocation.value
                                //       ? true
                                //       : false,
                                // ),
                                Visibility(
                                  child: _showAllListTransporter(context),
                                  visible: controller.isShowAllTransporter()
                                      ? true
                                      : false,
                                ),
                                controller.isShowDetail.value
                                    ? _detailTransporterWidget(context)
                                    : (controller.isShowAllLocation.value
                                        ? _allLocationTransporterWidget(context)
                                        : Container()),
                                // controller.isShowDetail.value
                                //     ? _detailTransporterWidget(context)
                                //     : (controller.isShowAllLocation.value
                                //         ? _allLocationTransporterWidget(context)
                                //         : _showAllListTransporter(context)),
                              ]),
                        )),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: ClipOval(
                            child: Material(
                                shape: CircleBorder(),
                                color: Colors.white,
                                child: InkWell(
                                    onTap: () async {
                                      if (await controller.onWillPop())
                                        Get.back();
                                    },
                                    child: Container(
                                        width: 50,
                                        height: 50,
                                        child: Center(
                                            child: Icon(
                                          Icons.arrow_back,
                                          size: 30,
                                          color: Color(ListColor.color4),
                                        ))))),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget _buildMap(BuildContext context) {
    return FlutterMap(
      mapController: controller.mapController.value,
      options: MapOptions(
          maxZoom: 18.0,
          plugins: [PopupMarkerPlugin()],
          onTap: (_) {
            _popupController.hidePopup();
            _popupControllerCircle.hidePopup();
          }),
      layers: [
        GlobalVariable.tileLayerOptions,
        // MarkerLayerOptions(
        //     markers: controller.listMarker
        //         .map<Marker>((data) => data as Marker)
        //         .toList()),
        PolylineLayerOptions(polylines: [
          Polyline(
              points: controller.listRoute
                  .map((data) => LatLng(data.latitude, data.longitude))
                  .toList(),
              strokeWidth: 4.0,
              color: Colors.green),
        ]),
        PopupMarkerLayerOptions(
            markers: controller.listMarker
                .map<Marker>((data) => data as Marker)
                .toList(),
            popupSnap: PopupSnap.markerTop,
            popupController: _popupController,
            popupBuilder: (_, marker) {
              return Card(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      width: 300,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.SETTING);
                                },
                                child: Icon(
                                  Icons.circle,
                                  color: Color(ListColor.color4),
                                  size: 40,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        controller.nameMarker(marker.point),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12),

                                    CustomText(
                                        controller.addressMarker(marker.point),
                                        color: Color(ListColor.colorGrey),
                                        fontSize: 12),

                                    // Text("Latlng: " +
                                    //     marker.point.latitude.toString() +
                                    //     ", " +
                                    //     marker.point.longitude.toString()),
                                  ],
                                ),
                              ),
                            ]),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Color(ListColor.color4),
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.edit,
                                  color: Color(ListColor.color4),
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.call,
                                  color: Color(ListColor.color4),
                                  size: 20,
                                ),
                              ],
                            )
                          ])));
            }),
        PopupMarkerLayerOptions(
            markers: controller.listMarkerCircle
                .map<Marker>((data) => data as Marker)
                .toList(),
            popupSnap: PopupSnap.markerTop,
            popupController: _popupControllerCircle,
            popupBuilder: (_, marker) {
              return Container();
            }),
      ],
    );
  }

  Widget _listDetailTruck(
      String owner,
      String address,
      String areaPickup,
      String areaDestination,
      String typeOfTruckName,
      int numberOfTruck,
      int index) {
    return Container(
        width: MediaQuery.of(Get.context).size.width * 0.8,
        // margin: EdgeInsets.all(10),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(10)),
        //     border: Border.all(width: 1, color: Color(ListColor.colorGrey))),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border:
                    Border.all(width: 1, color: Color(ListColor.colorGrey))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(Icons.circle, size: 40),
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(owner,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18),
                                  Container(
                                    child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: CustomText(address,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                color:
                                                    Color(ListColor.colorGrey)),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color:
                                                    Color(ListColor.colorBlue),
                                                border: Border.all(
                                                    color: Color(
                                                        ListColor.colorBlue),
                                                    width: 2)),
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.transparent,
                                              child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  onTap: () {
                                                    controller
                                                        .showAllLocationTransporter(
                                                            index);
                                                  },
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 5),
                                                      child: CustomText(
                                                          'LocationTruckReadyIndexLabelAllLocation'
                                                              .tr,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .w800))),
                                            ),
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(Get.context).size.width,
                      height: 1,
                      color: Color(ListColor.colorGrey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // _getDetailInfo(
                                //     "Lokasi truk siap muat", areaPickup),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                _getDetailInfo("Kota tujuan", areaDestination),
                                SizedBox(
                                  height: 10,
                                ),
                                _getDetailInfo(
                                    "Jenis truk - Carrier", typeOfTruckName),
                                SizedBox(
                                  height: 10,
                                ),
                                _getDetailInfo(
                                    "Jumlah unit", numberOfTruck.toString()),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(Get.context).size.width,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    "TD-012",
                                    color: Color(ListColor.color4),
                                  ),
                                  CustomText(
                                      "Last Update 05/01/2021 11.00 WIB"),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                width: 1, color: Color(ListColor.colorGrey)),
                            bottom:
                                BorderSide(width: 0, color: Colors.transparent),
                            right: BorderSide(
                                width: 1, color: Color(ListColor.colorGrey)),
                            left:
                                BorderSide(width: 0, color: Colors.transparent),
                          ),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10)),
                          color: Colors.transparent,
                          child: InkWell(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10)),
                              onTap: () {
                                controller.showDetailTransporter(index);
                              },
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: AutoSizeText('Detail',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)))),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          //color: Color(ListColor.colorGrey),
                          border: Border(
                            top: BorderSide(
                                width: 1, color: Color(ListColor.colorGrey)),
                            bottom:
                                BorderSide(width: 0, color: Colors.transparent),
                            right: BorderSide(
                                width: 1, color: Color(ListColor.colorGrey)),
                            left: BorderSide(
                                width: 1, color: Color(ListColor.colorGrey)),
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {},
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: AutoSizeText('Profile',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)))),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          //color: Color(ListColor.colorGrey),
                          border: Border(
                            top: BorderSide(
                                width: 1, color: Color(ListColor.colorGrey)),
                            bottom:
                                BorderSide(width: 0, color: Colors.transparent),
                            right:
                                BorderSide(width: 0, color: Colors.transparent),
                            left: BorderSide(
                                width: 1, color: Color(ListColor.colorGrey)),
                          ),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10)),
                          color: Colors.transparent,
                          child: InkWell(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10)),
                              onTap: () {},
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: AutoSizeText('Hubungi',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)))),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _listDetailDistrict(
      String owner,
      String address,
      String areaPickup,
      String areaDestination,
      String typeOfTruckName,
      int numberOfTruck,
      int index) {
    return Container(
        width: MediaQuery.of(Get.context).size.width * 0.8,
        // margin: EdgeInsets.all(10),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(10)),
        //     border: Border.all(width: 1, color: Color(ListColor.colorGrey))),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border:
                    Border.all(width: 1, color: Color(ListColor.colorGrey))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(Icons.circle, size: 40),
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(owner,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18),
                                  Container(
                                    child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(address,
                                              color:
                                                  Color(ListColor.colorGrey)),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color:
                                                    Color(ListColor.colorBlue),
                                                border: Border.all(
                                                    color: Color(
                                                        ListColor.colorBlue),
                                                    width: 2)),
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.transparent,
                                              child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  onTap: () {
                                                    controller
                                                        .showAllLocationTransporter(
                                                            index);
                                                  },
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 5),
                                                      child: CustomText(
                                                          'LocationTruckReadyIndexLabelAllLocation'
                                                              .tr,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .w800))),
                                            ),
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(Get.context).size.width,
                      height: 1,
                      color: Color(ListColor.colorGrey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // _getDetailInfo(
                                //     "Lokasi truk siap muat", areaPickup),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                _getDetailInfo("Kota tujuan", areaDestination),
                                SizedBox(
                                  height: 10,
                                ),
                                _getDetailInfo(
                                    "Jenis truk - Carrier", typeOfTruckName),
                                SizedBox(
                                  height: 10,
                                ),
                                _getDetailInfo(
                                    "Jumlah unit", numberOfTruck.toString()),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(Get.context).size.width,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    "TD-012",
                                    color: Color(ListColor.color4),
                                  ),
                                  CustomText(
                                      "Last Update 05/01/2021 11.00 WIB"),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                width: 1, color: Color(ListColor.colorGrey)),
                            bottom:
                                BorderSide(width: 0, color: Colors.transparent),
                            right: BorderSide(
                                width: 1, color: Color(ListColor.colorGrey)),
                            left:
                                BorderSide(width: 0, color: Colors.transparent),
                          ),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10)),
                          color: Colors.transparent,
                          child: InkWell(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10)),
                              onTap: () {
                                controller.showDetailTransporter(index);
                              },
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: AutoSizeText('Detail',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)))),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          //color: Color(ListColor.colorGrey),
                          border: Border(
                            top: BorderSide(
                                width: 1, color: Color(ListColor.colorGrey)),
                            bottom:
                                BorderSide(width: 0, color: Colors.transparent),
                            right: BorderSide(
                                width: 1, color: Color(ListColor.colorGrey)),
                            left: BorderSide(
                                width: 1, color: Color(ListColor.colorGrey)),
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {},
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: AutoSizeText('Profile',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)))),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          //color: Color(ListColor.colorGrey),
                          border: Border(
                            top: BorderSide(
                                width: 1, color: Color(ListColor.colorGrey)),
                            bottom:
                                BorderSide(width: 0, color: Colors.transparent),
                            right:
                                BorderSide(width: 0, color: Colors.transparent),
                            left: BorderSide(
                                width: 1, color: Color(ListColor.colorGrey)),
                          ),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10)),
                          color: Colors.transparent,
                          child: InkWell(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10)),
                              onTap: () {},
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: AutoSizeText('Hubungi',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)))),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _listDetailAllLocation(
      String owner,
      String address,
      String areaPickup,
      String areaDestination,
      String typeOfTruckName,
      int numberOfTruck,
      int index) {
    return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(width: 1, color: Color(ListColor.colorGrey))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _getDetailInfo("Lokasi truk siap muat", areaPickup),
                          SizedBox(
                            height: 10,
                          ),
                          _getDetailInfo("Kota tujuan", areaDestination),
                          SizedBox(
                            height: 10,
                          ),
                          _getDetailInfo(
                              "Jenis truk - Carrier", typeOfTruckName),
                          SizedBox(
                            height: 10,
                          ),
                          _getDetailInfo(
                              "Jumlah unit", numberOfTruck.toString()),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(Get.context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              "TD-012",
                              color: Color(ListColor.color4),
                            ),
                            CustomText("Last Update 05/01/2021 11.00 WIB"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            width: 1, color: Color(ListColor.colorGrey)),
                        bottom: BorderSide(width: 0, color: Colors.transparent),
                        right: BorderSide(
                            width: 1, color: Color(ListColor.colorGrey)),
                        left: BorderSide(width: 0, color: Colors.transparent),
                      ),
                    ),
                    child: Material(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(10)),
                      color: Colors.transparent,
                      child: InkWell(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10)),
                          onTap: () {
                            controller
                                .showDetailTransporterFromAllLocation(index);
                          },
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child: AutoSizeText('Detail',
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)))),
                    ),
                  ),
                ),
                // Expanded(
                //   child: Container(
                //     decoration: BoxDecoration(
                //       //color: Color(ListColor.colorGrey),
                //       border: Border(
                //         top: BorderSide(
                //             width: 1, color: Color(ListColor.colorGrey)),
                //         bottom: BorderSide(width: 0, color: Colors.transparent),
                //         right: BorderSide(
                //             width: 1, color: Color(ListColor.colorGrey)),
                //         left: BorderSide(
                //             width: 1, color: Color(ListColor.colorGrey)),
                //       ),
                //     ),
                //     child: Material(
                //       color: Colors.transparent,
                //       child: InkWell(
                //           onTap: () {},
                //           child: Container(
                //               padding: EdgeInsets.all(10),
                //               child: AutoSizeText('Profile',
                //                   textAlign: TextAlign.center,
                //                   maxLines: 1,
                //                   style:
                //                       TextStyle(fontWeight: FontWeight.w600)))),
                //     ),
                //   ),
                // ),
                // Expanded(
                //   child: Container(
                //     decoration: BoxDecoration(
                //       //color: Color(ListColor.colorGrey),
                //       border: Border(
                //         top: BorderSide(
                //             width: 1, color: Color(ListColor.colorGrey)),
                //         bottom: BorderSide(width: 0, color: Colors.transparent),
                //         right: BorderSide(width: 0, color: Colors.transparent),
                //         left: BorderSide(
                //             width: 1, color: Color(ListColor.colorGrey)),
                //       ),
                //     ),
                //     child: Material(
                //       borderRadius:
                //           BorderRadius.only(bottomRight: Radius.circular(10)),
                //       color: Colors.transparent,
                //       child: InkWell(
                //           borderRadius: BorderRadius.only(
                //               bottomRight: Radius.circular(10)),
                //           onTap: () {},
                //           child: Container(
                //               padding: EdgeInsets.all(10),
                //               child: AutoSizeText('Hubungi',
                //                   textAlign: TextAlign.center,
                //                   maxLines: 1,
                //                   style:
                //                       TextStyle(fontWeight: FontWeight.w600)))),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ));
  }

  Widget _getDetailInfo(String title, String detail) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: (MediaQuery.of(Get.context).size.width - 80) * 2 / 5,
            child: CustomText(title, color: Color(ListColor.color4))),
        SizedBox(
          width: 10,
        ),
        Expanded(child: CustomText(detail, fontWeight: FontWeight.w700)),
      ],
    );

    // return Expanded(
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(title, style: TextStyle(color: Color(ListColor.colorLightGrey))),
    //       Text(detail, style: TextStyle(fontWeight: FontWeight.w700)),
    //     ],
    //   ),
    // );
  }

  Widget _getDetailTransporter(String title, String detail) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: (MediaQuery.of(Get.context).size.width - 80) * 2 / 5,
            child: CustomText(title, color: Color(ListColor.colorGrey))),
        SizedBox(
          width: 10,
        ),
        Expanded(child: CustomText(detail, fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _getTextFieldFromDest(String title,
      TextEditingController textEditingController, String markerIcon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Container(
        //     margin: EdgeInsets.only(top: 10, bottom: 5),
        //     child: Text(title,
        //         style: TextStyle(color: Colors.black, fontSize: 18))),
        Container(
            // margin: EdgeInsets.only(right: isShort ? 100 : 0),
            child: Row(
          children: [
            Image(
              image: AssetImage("assets/" + markerIcon),
              width: 20,
              height: 20,
              fit: BoxFit.fitWidth,
            ),
            Expanded(
              child: CustomTextField(
                context: Get.context,
                controller: textEditingController,
                enabled: false,
                newContentPadding: EdgeInsets.all(10.0),
                newInputDecoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: title,
                  fillColor: Colors.white,
                  errorStyle: TextStyle(color: Colors.white),
                  errorMaxLines: 2,
                  filled: true,
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }

  Widget _showAllListTransporter(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Color(0x54000000),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomText('LTRResultLabelSearchResult'.tr,
            fontSize: 18, fontWeight: FontWeight.w700),
        SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            controller.gotoSearchCityFromDest();
          },
          child: Container(
            color: Colors.white,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // _getTextField("Address",
                  //     controller.textEditingAddressFromController.value, null),
                  _getTextFieldFromDest(
                      'LTRSearchLabelPickup'.tr,
                      controller.textEditingCityFromController.value,
                      controller.markerFrom.value),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Colors.grey,
                  ),
                  _getTextFieldFromDest(
                    'LTRSearchLabelDestination'.tr,
                    controller.textEditingCityDestController.value,
                    controller.markerDest.value,
                  ),
                ]),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 350,
          child: ListView.builder(
            controller: controller.scrollController.value,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.listLocationTruckReadyResultModel.length,
            itemBuilder: (context, index) {
              return _listDetailTruck(
                  controller.listLocationTruckReadyResultModel[index].title,
                  controller.listLocationTruckReadyResultModel[index].address,
                  controller.listLocationTruckReadyResultModel[index]
                      .locationNameTransporter,
                  controller.listLocationTruckReadyResultModel[index]
                      .locationNameDestination,
                  controller
                      .listLocationTruckReadyResultModel[index].typeOfTruckName,
                  controller
                      .listLocationTruckReadyResultModel[index].numberOfTruck,
                  index);
              // return Container(
              //     padding: EdgeInsets.all(10),
              //     child: ListTile(
              //       title: Text('Truck $index'),
              //     ));
            },
          ),
        )
      ]),
    );
  }

  Widget _detailTransporterWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Color(0x54000000),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ]),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(Icons.circle, size: 80),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(controller.detailTransporter.value.title,
                          fontWeight: FontWeight.w800, fontSize: 18),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          CustomText(
                              controller
                                  .detailTransporter.value.typeOfTransporter,
                              fontSize: 14,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = Colors.yellow),
                          CustomText(
                              controller
                                  .detailTransporter.value.typeOfTransporter,
                              color: Colors.orange,
                              fontSize: 14),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(mainAxisSize: MainAxisSize.max, children: [
                        _buttonWidget("Profil Transporter", () {}, false),
                        SizedBox(width: 10),
                        _buttonWidget("Hubungi", () {}, true),
                      ]),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: Color(ListColor.colorGrey), width: 1),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 5))
                      ]),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _getDetailTransporter(
                                      "Lokasi truk siap muat",
                                      controller.detailTransporter.value
                                          .locationNameTransporter),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _getDetailTransporter(
                                      "Kota tujuan",
                                      controller.detailTransporter.value
                                          .locationNameDestination),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _getDetailTransporter(
                                      "Jenis truk - Carrier",
                                      controller.detailTransporter.value
                                          .typeOfTruckName),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _getDetailTransporter(
                                      "Jumlah unit",
                                      controller
                                          .detailTransporter.value.numberOfTruck
                                          .toString()),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(Get.context).size.width,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      "TD-012",
                                      color: Color(ListColor.color4),
                                    ),
                                    CustomText(
                                        "Last Update 05/01/2021 11.00 WIB"),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ))
          ]),
    );
  }

  Widget _allLocationTransporterWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Color(0x54000000),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(Icons.circle, size: 80),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(controller.detailTransporter.value.title,
                      fontWeight: FontWeight.w800, fontSize: 18),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      CustomText(
                          controller.detailTransporter.value.typeOfTransporter,
                          fontSize: 14,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.yellow),
                      CustomText(
                          controller.detailTransporter.value.typeOfTransporter,
                          color: Colors.orange,
                          fontSize: 14),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisSize: MainAxisSize.max, children: [
                    _buttonWidget("Profil Transporter", () {}, false),
                    SizedBox(width: 10),
                    _buttonWidget("Hubungi", () {}, true),
                  ]),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: controller.listAllLocationTransporterTruckReady.length,
            itemBuilder: (context, index) {
              return _listDetailAllLocation(
                  controller.listAllLocationTransporterTruckReady[index].title,
                  controller
                      .listAllLocationTransporterTruckReady[index].address,
                  controller.listAllLocationTransporterTruckReady[index]
                      .locationNameTransporter,
                  controller.listAllLocationTransporterTruckReady[index]
                      .locationNameDestination,
                  controller.listAllLocationTransporterTruckReady[index]
                      .typeOfTruckName,
                  controller.listAllLocationTransporterTruckReady[index]
                      .numberOfTruck,
                  index);
              // return Container(
              //     padding: EdgeInsets.all(10),
              //     child: ListTile(
              //       title: Text('Truck $index'),
              //     ));
            },
          ),
        )
      ]),
    );
  }

  Widget _buttonWidget(
      String title, Function function, bool isBackgroundWhite) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isBackgroundWhite ? Colors.white : Color(ListColor.colorBlue),
          border: Border.all(color: Color(ListColor.colorBlue), width: 2)),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: function,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: CustomText(title,
                    color: isBackgroundWhite
                        ? Color(ListColor.colorBlue)
                        : Colors.white,
                    fontWeight: FontWeight.w800))),
      ),
    );
  }
}
