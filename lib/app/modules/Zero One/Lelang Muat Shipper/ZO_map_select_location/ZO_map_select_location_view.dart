import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_select_location/ZO_map_select_location_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoMapSelectLocationView extends GetView<ZoMapSelectLocationController> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    return Container(
      color: Colors.white,
      child: SafeArea(
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
                Obx(
                  () => Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              GlobalVariable.ratioFontSize(context) * 16,
                              GlobalVariable.ratioFontSize(context) * 0,
                              GlobalVariable.ratioFontSize(context) * 16,
                              GlobalVariable.ratioFontSize(context) * 0),
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
                                child: Obx(
                                  () => CustomText(
                                      controller.informationMarker.value
                                          .formattedAddress,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: GlobalVariable.ratioFontSize(
                                              context) *
                                          14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                              if (controller.informationMarker.value
                                      .formattedAddress ==
                                  "")
                                SizedBox(
                                  width: 5,
                                ),
                              if (controller.informationMarker.value
                                      .formattedAddress ==
                                  "")
                                Obx(
                                  () => Container(
                                      width: 20,
                                      height: 20,
                                      child: controller.informationMarker.value
                                                  .formattedAddress !=
                                              ""
                                          ? SizedBox.shrink()
                                          : CircularProgressIndicator(
                                              strokeWidth: 2.0,
                                            )),
                                )
                            ],
                          ),
                        ),
                      ]),
                ),
                // Container(
                //     width: MediaQuery.of(context).size.width,
                //     height: 2,
                //     color: Color(ListColor.colorLightBlue5))
              ]),
            ),
          ),
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 50,
              child: buildMap(context)),
        ),
      ),
    );
  }

  Widget buildMap(BuildContext context) {
    return Stack(children: [
      FlutterMap(
        mapController: controller.mapController.value,
        options: MapOptions(
          interactiveFlags: InteractiveFlag.pinchMove |
              InteractiveFlag.pinchZoom |
              InteractiveFlag.drag,
          maxZoom: GlobalVariable.zoomMap,
          center: GlobalVariable.centerMap,
          onPositionChanged: (position, hasGesture) {
            controller.setPositionMarker(
                LatLng(position.center.latitude, position.center.longitude));
          },
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
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
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: CustomText(
                                      "LelangMuatBuatLelangBuatLelangLabelTitleErorPinLokasi"
                                          .tr,
                                      fontSize: GlobalVariable.ratioFontSize(
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
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: 12,
                                    )))
                          ],
                        ))),
          ),
          Align(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset(0, -20),
                child: controller.imageMarker,
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(context) * 37,
                  0,
                  GlobalVariable.ratioWidth(context) * 37,
                  GlobalVariable.ratioWidth(Get.context) * 16),
              padding: EdgeInsets.all(10),
              child: Obx(
                () => OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Color((controller.locationValid.value &&
                              controller.informationMarker.value
                                      .formattedAddress !=
                                  "")
                          ? ListColor.color4
                          : ListColor.colorGrey),
                      side: BorderSide(
                          width: 2,
                          color: Color((controller.locationValid.value &&
                                  controller.informationMarker.value
                                          .formattedAddress !=
                                      "")
                              ? ListColor.color4
                              : ListColor.colorGrey)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )),
                  onPressed: () {
                    if (controller.locationValid.value &&
                        controller.informationMarker.value.formattedAddress !=
                            "") controller.onApplyButton();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: CustomText("SLMMLabelButtonApply".tr,
                        fontSize: GlobalVariable.ratioFontSize(context) * 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          )
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     padding: EdgeInsets.all(10),
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(10),
          //           topRight: Radius.circular(10)),
          //     ),
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text('SLMMLabelTitleLocation'.tr,
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w600, fontSize: 18)),
          //         controller.informationMarker.value.formattedAddress !=
          //                 ""
          //             ? Column(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   Text(controller.informationMarker.value
          //                       .formattedAddress),
          //                   Container(
          //                     width: MediaQuery.of(context).size.width,
          //                     child: FlatButton(
          //                       onPressed: () {
          //                         controller.getBack();
          //                       },
          //                       color: Color(ListColor.colorBlue),
          //                       child: Text(
          //                         "SLMMLsbrlConfirm".tr,
          //                         style: TextStyle(color: Colors.white),
          //                       ),
          //                     ),
          //                   )
          //                 ],
          //               )
          //             : Container(
          //                 width: MediaQuery.of(context).size.width,
          //                 child: Center(
          //                     child: Container(
          //                         width: 30,
          //                         height: 30,
          //                         child: CircularProgressIndicator())),
          //               )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    ]);
  }
}
