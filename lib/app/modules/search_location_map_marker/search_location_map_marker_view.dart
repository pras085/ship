import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/search_location_map_marker/search_location_map_marker_controller.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

import '../../../global_variable.dart';

class SearchLocationMapMarkerView
    extends GetView<SearchLocationMapMarkerController> {
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
            preferredSize:
                Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
            child: Container(
              height: GlobalVariable.ratioWidth(Get.context) * 56,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 8)),
              ], color: Colors.white),
              child: Stack(alignment: Alignment.bottomCenter, children: [
                Column(mainAxisSize: MainAxisSize.max, children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 16),
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
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24,
                                          child: Center(
                                              child: Icon(
                                            Icons.arrow_back_ios_rounded,
                                            size: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                12,
                                            color: Colors.white,
                                          ))))),
                            ),
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 12,
                          ),
                          Expanded(
                            child: controller.informationMarker.value.formattedAddress != ""?
                            Obx(
                              () => CustomText(
                                  controller
                                      .informationMarker.value.formattedAddress,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ):CustomText('Sedang Memuat Alamat...')
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Obx(
                            () => Container(
                                width: 20,
                                height: 20,
                                child: controller.informationMarker.value.formattedAddress != ""
                                    ? SizedBox.shrink()
                                    : CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                      )),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
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
          GlobalVariable.tileLayerOptions,
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
                                      "Mohon memasukkan pin lokasi truk siap muat dengan benar",
                                      fontSize: 12,
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
                offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * -29),
                child: controller.imageMarker,
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                  bottom: GlobalVariable.ratioWidth(Get.context) * 17),
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
                    width: GlobalVariable.ratioWidth(Get.context) * 291,
                    height: GlobalVariable.ratioWidth(Get.context) * 32,
                    child: Center(
                      child: CustomText("SLMMLabelButtonApply".tr,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ]);
  }
}
