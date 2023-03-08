import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/detail_permintaan_muat/detail_permintaan_muat_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_detail.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:latlong/latlong.dart';

class MapDetailPermintaanMuatComponent extends StatefulWidget {
  // final ProfilePerusahaanModel model;
  final String title;

  MapDetailPermintaanMuatComponent({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  _MapDetailPermintaanMuatComponentState createState() => _MapDetailPermintaanMuatComponentState();
}

class _MapDetailPermintaanMuatComponentState extends State<MapDetailPermintaanMuatComponent> {
  final mapController = MapController();
  // List latlong;
  // List lokasi;
  // List destinasi;
  DetailPermintaanMuatController detailC = Get.find();
  // ProfilePerusahaanController controller = Get.find();
  var asalData;
  @override
  void initState() {
    super.initState();
    // 0 : Pickup/Muat
    // 1 : Destinasi/Bongkar
    asalData = Get.arguments;

    // latlong = data['latlong'];
    // lokasi = data['latlong'];
    // //
    log(':::: MAP ${detailC.lokasi} && ${detailC.destinasi}');
    log(':::: MAP ${detailC.latlngLokasi} && ${detailC.latlngDestinasi}');
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        var listPoint = <LatLng>[];
        if(asalData == 1){
          for (var i = 0; i < detailC.latlngDestinasi.length; i++)
            listPoint.add(detailC.latlngDestinasi[i]);
        } else {
          for (var i = 0; i < detailC.latlngLokasi.length; i++)
            listPoint.add(detailC.latlngLokasi[i]);
        }
        await mapController.onReady;
        mapController.fitBounds(LatLngBounds.fromPoints(listPoint), options: FitBoundsOptions(padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 16)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ListColor.colorWhite),
      appBar: AppBarDetail(
        title: 'Lihat Peta',
      ),
      body:
          asalData == 1
              ? Stack(
                  children: [
                    Positioned.fill(
                      child: FlutterMap(
                        options: MapOptions(
                          center: GlobalVariable.centerMap,
                        ),
                        mapController: mapController,
                        layers: [
                          GlobalVariable.tileLayerOptions,
                          MarkerLayerOptions(
                            markers: [
                              for (var i = 0; i < detailC.latlngDestinasi.length; i++)
                                Marker(
                                  width: GlobalVariable.ratioWidth(context) * 22,
                                  height: GlobalVariable.ratioWidth(context) * 27,
                                  point: detailC.latlngDestinasi[i],
                                  builder: (ctx) {
                                    return Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        SvgPicture.asset(
                                          detailC.latlngDestinasi.length == 1
                                              ? "assets/pin_truck_icon.svg"
                                              : i == 0
                                                  ? "assets/pin_yellow_icon.svg"
                                                  : "assets/pin_blue_icon.svg",
                                          width: GlobalVariable.ratioWidth(Get.context) * 22,
                                          height: GlobalVariable.ratioWidth(Get.context) * 27,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 6),
                                          child: CustomText(
                                            detailC.latlngDestinasi.length == 1 ? "" : (i + 1).toString(),
                                            color: i == 0 ? Color(ListColor.color4) : Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 7,
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 12),
                            topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 12),
                          ),
                        ),
                        color: Colors.white,
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                            GlobalVariable.ratioWidth(context) * 16,
                            0,
                            GlobalVariable.ratioWidth(context) * 16,
                            GlobalVariable.ratioWidth(context) * 19
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 4),
                                  color: Color(ListColor.colorLightGrey16),
                                ),
                                width: GlobalVariable.ratioWidth(context) * 38,
                                height: GlobalVariable.ratioWidth(context) * 2.74,
                                margin: EdgeInsets.only(
                                  top: GlobalVariable.ratioWidth(context) * 3,
                                  bottom: GlobalVariable.ratioWidth(context) * 13.26,
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: GlobalVariable.ratioWidth(context) * 18,
                                ),
                                child: CustomText(
                                  widget.title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(ListColor.colorBlue),
                                ),
                              ),
                              SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
                              for (var i = 0; i < detailC.destinasi.length; i++)
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    i == 0
                                    ? SizedBox.shrink()
                                    : Container(
                                      margin: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(Get.context) * 8,
                                      ),
                                      child: Dash(
                                        direction: Axis.vertical,
                                        dashColor: Color(ListColor.colorLightGrey10),
                                        length: GlobalVariable.ratioWidth(Get.context) * 18,
                                        dashGap: GlobalVariable.ratioWidth(Get.context) * 1,
                                        dashLength: GlobalVariable.ratioWidth(Get.context) * 5,
                                        dashBorderRadius: GlobalVariable.ratioWidth(Get.context) * 1,
                                        dashThickness: GlobalVariable.ratioWidth(Get.context) * 2,
                                      )
                                    ),
                                    Container(
                                      height: GlobalVariable.ratioWidth(context) * 24,
                                      width: GlobalVariable.ratioWidth(context) * 328,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              SvgPicture.asset(
                                                detailC.destinasi.length == 1
                                                    ? "assets/pin_truck_icon.svg"
                                                    : i == 0
                                                        ? "assets/pin_yellow_icon.svg"
                                                        : "assets/pin_blue_icon.svg",
                                                width: GlobalVariable.ratioWidth(Get.context) * 18,
                                                height: GlobalVariable.ratioWidth(Get.context) * 24,
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 6),
                                                child: CustomText(
                                                  detailC.destinasi.length == 1 ? "" : (i + 1).toString(),
                                                  color: i == 0 ? Color(ListColor.color4) : Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 7,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: GlobalVariable.ratioWidth(context) * 16),
                                          Expanded(
                                            child: CustomText(
                                              detailC.destinasi[i],
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Color(ListColor.colorDarkGrey3),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    Positioned.fill(
                      child: FlutterMap(
                        options: MapOptions(
                          center: GlobalVariable.centerMap,
                        ),
                        mapController: mapController,
                        layers: [
                          GlobalVariable.tileLayerOptions,
                          MarkerLayerOptions(
                            markers: [
                              for (var i = 0; i < detailC.latlngLokasi.length; i++)
                                Marker(
                                  width: GlobalVariable.ratioWidth(context) * 18,
                                  height: GlobalVariable.ratioWidth(context) * 24,
                                  point: detailC.latlngLokasi[i],
                                  builder: (ctx) {
                                    return Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        SvgPicture.asset(
                                          detailC.latlngLokasi.length == 1
                                              ? "assets/pin_truck_icon.svg"
                                              : i == 0
                                                  ? "assets/pin_yellow_icon.svg"
                                                  : "assets/pin_blue_icon.svg",
                                          width: GlobalVariable.ratioWidth(Get.context) * 18,
                                          height: GlobalVariable.ratioWidth(Get.context) * 24,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 5),
                                          child: CustomText(
                                            detailC.latlngLokasi.length == 1 ? "" : (i + 1).toString(),
                                            color: i == 0 ? Color(ListColor.color4) : Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8,
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 12),
                            topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 12),
                          ),
                        ),
                        color: Colors.white,
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                            GlobalVariable.ratioWidth(context) * 16,
                            0,
                            GlobalVariable.ratioWidth(context) * 16,
                            GlobalVariable.ratioWidth(context) * 19
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 4),
                                  color: Color(ListColor.colorLightGrey16),
                                ),
                                width: GlobalVariable.ratioWidth(context) * 38,
                                height: GlobalVariable.ratioWidth(context) * 2.74,
                                margin: EdgeInsets.only(
                                  top: GlobalVariable.ratioWidth(context) * 3,
                                  bottom: GlobalVariable.ratioWidth(context) * 13.26,
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: GlobalVariable.ratioWidth(context) * 18,
                                ),
                                child: CustomText(
                                  widget.title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(ListColor.colorBlue),
                                ),
                              ),
                              SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
                              for (var i = 0; i < detailC.lokasi.length; i++)
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    i == 0
                                    ? SizedBox.shrink()
                                    : Container(
                                      margin: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(Get.context) * 8,
                                      ),
                                      child: Dash(
                                        direction: Axis.vertical,
                                        dashColor: Color(ListColor.colorLightGrey10),
                                        length: GlobalVariable.ratioWidth(Get.context) * 18,
                                        dashGap: GlobalVariable.ratioWidth(Get.context) * 1,
                                        dashLength: GlobalVariable.ratioWidth(Get.context) * 5,
                                        dashBorderRadius: GlobalVariable.ratioWidth(Get.context) * 1,
                                        dashThickness: GlobalVariable.ratioWidth(Get.context) * 2,
                                      )
                                    ),
                                    Container(
                                      width: GlobalVariable.ratioWidth(context) * 328,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              SvgPicture.asset(
                                                detailC.lokasi.length == 1
                                                    ? "assets/pin_truck_icon.svg"
                                                    : i == 0
                                                        ? "assets/pin_yellow_icon.svg"
                                                        : "assets/pin_blue_icon.svg",
                                                width: GlobalVariable.ratioWidth(Get.context) * 18,
                                                height: GlobalVariable.ratioWidth(Get.context) * 24,
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 6),
                                                child: CustomText(
                                                  detailC.lokasi.length == 1 ? "" : (i + 1).toString(),
                                                  color: i == 0 ? Color(ListColor.color4) : Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 7,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: GlobalVariable.ratioWidth(context) * 16),
                                          Expanded(
                                            child: CustomText(
                                              detailC.lokasi[i],
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Color(ListColor.colorDarkGrey3),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
