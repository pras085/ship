import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/detail_manajemen_lokasi/detail_manajemen_lokasi_controller.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/edit_manajemen_lokasi_info_permintaan_muat/edit_manajemen_lokasi_info_permintaan_muat_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class DetailManajemenLokasiView
    extends GetView<DetailManajemenLokasiController> {
  double _widthContent(BuildContext context) =>
      MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
      onWillPop: () {
        controller.onWillPop();
        return Future.value(false);
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(64),
                child: Container(
                  height: GlobalVariable.ratioWidth(Get.context) * 56,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Stack(alignment: Alignment.bottomCenter, children: [
                    Container(
                      height: GlobalVariable.ratioWidth(Get.context) * 56,
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16),
                                  child: CustomBackButton(
                                      context: Get.context,
                                      backgroundColor:
                                          Color(ListColor.colorBlue),
                                      iconColor: Color(ListColor.colorWhite),
                                      onTap: () {
                                        controller.onWillPop();
                                      }),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     controller.onWillPop();
                                //   },
                                //   child: Container(
                                //     height: GlobalVariable.ratioWidth(Get.context) *56,
                                //     padding: EdgeInsets.symmetric(
                                //         horizontal: GlobalVariable.ratioWidth(
                                //                 Get.context) *
                                //             16),
                                //     child: ClipOval(
                                //       child: Material(
                                //           shape: CircleBorder(),
                                //           color: Color(ListColor.color4),
                                //           child: Container(
                                //               width: 30,
                                //               height: 30,
                                //               child: Center(
                                //                   child: Icon(
                                //                 Icons.arrow_back_ios_rounded,
                                //                 size: 20,
                                //                 color: Colors.white,
                                //               )))),
                                //     ),
                                //   ),
                                // ),

                                Align(
                                  alignment: Alignment.center,
                                  child: CustomText(
                                      "LocationManagementLabelDetailLocation"
                                          .tr,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16),
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (controller.loading.value) return;
                                        controller.loading.value = true;
                                        var result = await GetToPage.toNamed<
                                                EditManajemenLokasiInfoPermintaanMuatController>(
                                            Routes
                                                .EDIT_MANAJEMEN_LOKASI_INFO_PERMINTAAN_MUAT,
                                            arguments: {
                                              EditManajemenLokasiInfoPermintaanMuatController
                                                      .manajemenLokasiModelKey:
                                                  controller
                                                      .detailManajemenLokasiModel
                                                      .manajemenLokasiModel,
                                              EditManajemenLokasiInfoPermintaanMuatController
                                                      .typeEditManajemenLokasiInfoPermintaanMuatKey:
                                                  TypeEditManajemenLokasiInfoPermintaanMuat
                                                      .UPDATE
                                            });
                                        if (result != null) {
                                          CustomToast.show(
                                              context: Get.context,
                                              message:
                                                  "LocationManagementAlertEditLocation"
                                                      .tr);
                                          controller.isChange = true;
                                          controller.getDetail();
                                        } else {
                                          controller.loading.value = false;
                                        }
                                      },
                                      child: CustomText(
                                          "LocationManagementBottomSheetEdit"
                                              .tr,
                                          color: Color(ListColor.color4),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                )
                              ],
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
              body: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Stack(children: [
                      Positioned.fill(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 7,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    _buildMap(),
                                    GestureDetector(
                                      onTap: () {
                                        controller.goToSearchMarkerMap();
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                7,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.fromLTRB(
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                    (GlobalVariable.ratioHeight(Get.context) *
                                            25) -
                                        FontTopPadding.getSize(12),
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                    GlobalVariable.ratioHeight(Get.context) *
                                        22),
                                child: _listTextFormWidget(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned.fill(
                          child: Obx(() => !controller.loading.value
                              ? SizedBox.shrink()
                              : Container(
                                  color: Colors.grey.withAlpha(30),
                                  child: Center(
                                      child: CircularProgressIndicator()))))
                    ]),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget _listTextFormWidget(BuildContext context) {
    return Obx(
      () => Form(
        key: controller.formKey.value,
        onChanged: () {
          controller.isChange = true;
          print('Debug: ' +
              'onChanged isChange = ' +
              controller.isChange.toString());
          if (controller.isValidateOnChange)
            controller.formKey.value.currentState.validate();
        },
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => _itemWithoutTextField(
                  title: "LocationManagementLabelLocationName".tr,
                  value: controller.namaLokasi.value,
                ),
              ),
              _separator(),
              Obx(
                () => _itemWithoutTextField(
                    title: "LocationManagementLabelLocation".tr,
                    value: controller.lokasi.value,
                    isLocation: true),
              ),
              _separator(),
              Obx(
                () => _itemWithoutTextField(
                    title: "LocationManagementLabelDetailLocation".tr,
                    value: controller.detailLokasi.value),
              ),
              _separator(),
              Obx(
                () => _itemWithoutTextField(
                    title: "LocationManagementLabelProvince".tr,
                    value: controller.province.value),
              ),
              _separator(),
              Obx(
                () => _itemWithoutTextField(
                    title: "LocationManagementLabelCity".tr,
                    value: controller.city.value),
              ),
              _separator(),
              Obx(
                () => _itemWithoutTextField(
                    title: "LocationManagementLabelDistrict".tr,
                    value: controller.district.value),
              ),
              _separator(),
              Obx(
                () => _itemWithoutTextField(
                    title: "LocationManagementLabelPostalCode".tr,
                    value: controller.postalCode.value),
              ),
              _separator(),
              Obx(
                () => _itemWithoutTextField(
                    title: "LocationManagementLabelPICName".tr,
                    value: controller.namaPIC.value),
              ),
              _separator(),
              Obx(
                () => _itemWithoutTextField(
                    title: "LocationManagementLabelPICPhoneNumber".tr,
                    value: controller.noTelpPIC.value),
              ),
            ]),
      ),
    );
  }

  Widget _separator() {
    return SizedBox(
      height: GlobalVariable.ratioHeight(Get.context) * 18,
    );
  }

  Widget _itemWithoutTextField(
      {@required String title,
      @required String value,
      bool isLocation = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(title,
            fontSize: 14,
            color: Color(ListColor.colorGrey3),
            fontWeight: FontWeight.w700),
        SizedBox(
          height: (GlobalVariable.ratioHeight(Get.context) * 8) -
              FontTopPadding.getSize(14),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            isLocation
                ? Container(
                    padding: EdgeInsets.fromLTRB(
                        0,
                        GlobalVariable.ratioHeight(Get.context) * 4,
                        GlobalVariable.ratioWidth(Get.context) * 8,
                        0),
                    child: Container(
                        child: SvgPicture.asset(
                      "assets/ic_marker.svg",
                      width: GlobalVariable.ratioWidth(Get.context) * 13,
                    )),
                    // Icon(
                    //   Icons.location_on,
                    //   color: Color(ListColor.color4),
                    //   size: GlobalVariable.ratioHeight(Get.context) * 19,
                    // ),
                  )
                : Container(),
            Expanded(
              child: CustomText(
                value,
                fontSize: 14,
                height: 1.2,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMap() {
    return Obx(
      () => FlutterMap(
        mapController: controller.mapController.value,
        options: MapOptions(
          interactiveFlags: InteractiveFlag.none,
          center: controller.latLng,
          zoom: GlobalVariable.zoomMap,
          minZoom: GlobalVariable.zoomMap,
          maxZoom: GlobalVariable.zoomMap,
        ),
        layers: [
          GlobalVariable.tileLayerOptions,
          MarkerLayerOptions(markers: [
            Marker(
              width: 40.0,
              height: 40.0,
              point: controller.latLng,
              anchorPos: AnchorPos.align(AnchorAlign.top),
              builder: (ctx) => SvgPicture.asset(
                "assets/pin_truck_icon.svg",
                width: 14,
                height: 35,
              ),
            ),
          ])
        ],
      ),
    );
  }
}
