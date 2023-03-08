import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/detail_permintaan_muat/component/map_detail_permintaan_muat.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/detail_permintaan_muat/detail_permintaan_muat_controller.dart';
import 'package:muatmuat/app/modules/list_user/list_user_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/radio_button_custom_widget.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:latlong/latlong.dart';

class DetailPermintaanMuatView extends GetView<DetailPermintaanMuatController> {
  AppBar _appBar = AppBar(
    title: CustomText('Demo'),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (controller.editCatatanTambahan.value || controller.editStatusPermintaanMuat.value) {
          GlobalAlertDialog.showAlertDialogCustom(
              context: Get.context,
              title: "Peringatan",
              message: "Apakah anda yakin untuk membatalkan perubahan?",
              labelButtonPriority1: "Cancel",
              labelButtonPriority2: "Yakin",
              onTapPriority2: () async {
                controller.editCatatanTambahan.value = false;
                controller.editStatusPermintaanMuat.value = false;
              });
        } else {
          Get.back(result: controller.change);
        }
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Center(
          child: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Container(
              child: SvgPicture.asset(
                "assets/ic_back_blue_in_white.svg",
                width: GlobalVariable.ratioWidth(Get.context) * 24,
                height: GlobalVariable.ratioWidth(Get.context) * 24,
              ),
            ),
          )
        ),
          title: Obx(
            () => controller.slideIndex.value == 0
                ? CustomText("InfoPermintaanMuatLabelDetailInfoPermintaanMuat".tr, fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText("Kode Permintaan Muat", fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),
                      Obx(
                        () => CustomText(
                          controller.dataMuat["kode_pm"],
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
          ),
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 16),
              child: GestureDetector(onTap: () {}, child: Icon(Icons.share_outlined, size: GlobalVariable.ratioWidth(Get.context) * 24, color: Colors.white,)),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: _appBar.preferredSize.height,
                color: Color(ListColor.color4),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
                        height: 0.5,
                        child: Container(color: Colors.white)),
                    Expanded(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16, vertical: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Container(
                                alignment: Alignment.centerLeft,
                                child: Obx(() => CustomText(controller.title.value, color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                              )),
                              Obx(
                                () => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [for (int i = 0; i < 4; i++) _buildPageIndicator(i == controller.slideIndex.value, i)],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Expanded(
                    child: controller.loading.value
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            width: Get.context.mediaQuery.size.width,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: SizedBox(width: 30, height: 30, child: CircularProgressIndicator()),
                                ),
                                CustomText("Loading"),
                              ],
                            ))
                        : Obx(
                            () => Stack(
                              children: [
                                PageView(
                                  onPageChanged: (index) {
                                    controller.slideIndex.value = index;
                                    controller.updateTitle();
                                    controller.refreshMap(index);
                                  },
                                  controller: controller.pageController,
                                  children: [firstPage(), secondPage(), thirdPage(), fourthPage()],
                                ),
                                controller.onUpdate.value
                                    ? Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : SizedBox.shrink()
                              ],
                            ),
                          )),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16, vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                        topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.61),
                          offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * -3),
                          blurRadius: GlobalVariable.ratioWidth(Get.context) * 55,
                          spreadRadius: 0
                        )
                      ]
                    ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Obx(() => Opacity(
                            opacity: controller.slideIndex == 0 ? 0 : 1,
                            child: MaterialButton(
                              padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 9),
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)), side: BorderSide(color: Color(ListColor.color4))),
                              onPressed: () {
                                if (controller.editCatatanTambahan.value || controller.editStatusPermintaanMuat.value) {
                                  GlobalAlertDialog.showAlertDialogCustom(
                                      context: Get.context,
                                      title: "Peringatan",
                                      message: "Apakah anda yakin untuk membatalkan perubahan?",
                                      labelButtonPriority1: "Cancel",
                                      labelButtonPriority2: "Yakin",
                                      onTapPriority2: () async {
                                        controller.editCatatanTambahan.value = false;
                                        controller.editStatusPermintaanMuat.value = false;
                                      });
                                } else if (!controller.loading.value && controller.slideIndex.value != 0) {
                                  controller.slideIndex.value--;
                                  controller.pageController
                                      .animateToPage(controller.slideIndex.value, duration: Duration(milliseconds: 500), curve: Curves.linear);
                                }
                              },
                              child: CustomText(
                                "InfoPermintaanMuatLabelKembali".tr,
                                color: Color(ListColor.color4),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )),
                    ),
                    Container(width: GlobalVariable.ratioWidth(Get.context) * 12),
                    Expanded(
                      child: Obx(() =>
                          // controller.slideIndex.value == 3 &&
                          //     !controller.editCatatanTambahan.value &&
                          //     !controller.editStatusPermintaanMuat.value
                          // ? Container()
                          // :
                          MaterialButton(
                            padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 9),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            color: Color(controller.slideIndex.value == 3 && !controller.editCatatanTambahan.value && !controller.editStatusPermintaanMuat.value
                                ? ListColor.colorLightGrey2
                                : ListColor.color4),
                            onPressed: () {
                              if (controller.editCatatanTambahan.value || controller.editStatusPermintaanMuat.value) {
                                if (controller.formKey.currentState.validate()) {
                                  controller.updatePermintaanMuat();
                                }
                              } else if (!controller.loading.value && controller.slideIndex.value != 3) {
                                controller.slideIndex.value++;
                                controller.pageController
                                    .animateToPage(controller.slideIndex.value, duration: Duration(milliseconds: 500), curve: Curves.linear);
                              }
                            },
                            child: CustomText(
                              controller.slideIndex.value == 3 ? "InfoPermintaanMuatLabelSimpan".tr : "InfoPermintaanMuatLabelSelanjutnya".tr,
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: GlobalVariable.ratioWidth(Get.context) * 20,
          height: GlobalVariable.ratioWidth(Get.context) * 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isCurrentPage ? Color(ListColor.colorYellow) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(ListColor.colorYellow), width: 2),
          ),
          child:
              CustomText((index + 1).toString(), color: isCurrentPage ? Color(ListColor.colorBlue) : Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        index == 3 ? SizedBox.shrink() : Container(
                height: GlobalVariable.ratioWidth(Get.context) * 2, width: GlobalVariable.ratioWidth(Get.context) * 11, color: Color(ListColor.colorYellow))
      ],
    );
  }

  Widget firstPage() {
    return SingleChildScrollView(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
      child: Obx(
        () => Column(
          children: [
            Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
            Container(
              margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText("InfoPermintaanMuatLabelKode".tr, fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                  Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                  Obx(() => CustomText(controller.dataMuat["kode_pm"], fontWeight: FontWeight.w600))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText("InfoPermintaanMuatLabelTanggalDibuat".tr, fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                  Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                  Obx(() => CustomText(controller.dataMuat["tanggal_dibuat"], fontWeight: FontWeight.w600))
                ],
              ),
            ),
            Container(
                height: GlobalVariable.ratioWidth(Get.context) * 2,
                color: Colors.grey,
                margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12)),
            Container(
              margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText("InfoPermintaanMuatLabelTipePickup".tr, fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                  Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                  Obx(() => CustomText(controller.dataMuat["type_pickup_str"], fontWeight: FontWeight.w600))
                ],
              ),
            ),
            for (var index = 0; index < controller.lokasi.length; index++)
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                    child: Obx(
                      () => Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          SvgPicture.asset(
                            controller.lokasi.length == 1
                                ? "assets/pin_truck_icon.svg"
                                : index == 0
                                    ? "assets/pin_yellow_icon.svg"
                                    : "assets/pin_blue_icon.svg",
                            width: GlobalVariable.ratioWidth(Get.context) * 18,
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                          ),
                          Container(
                              margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 5),
                              child: CustomText(controller.lokasi.length == 1 ? "" : (index + 1).toString(),
                                  color: index == 0 ? Color(ListColor.color4) : Colors.white, fontWeight: FontWeight.bold, fontSize: 7))
                        ],
                      ),
                    ),
                  ),
                  Container(width: GlobalVariable.ratioWidth(Get.context) * 11),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                          child: CustomText("InfoPermintaanMuatLabelLokasiPickup".tr,
                              fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorDarkGrey3)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText("InfoPermintaanMuatLabelAlamatLokasi".tr,
                                  fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                              Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                              CustomText(controller.lokasi[index], fontWeight: FontWeight.w600)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText("InfoPermintaanMuatLabelDetailLokasi".tr,
                                  fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                              Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                              CustomText(controller.deskripsiLokasi[index], fontWeight: FontWeight.w600)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText("InfoPermintaanMuatLabelNamaPIC".tr, fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                              Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                              CustomText(controller.namaPICLokasi[index], fontWeight: FontWeight.w600)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText("InfoPermintaanMuatLabelNomorPIC".tr,
                                        fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                                    Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                                    CustomText(
                                      controller.nomorPICLokasi[index],
                                      fontWeight: FontWeight.w600,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: SvgPicture.asset("assets/socmed_logo_call.svg", width: GlobalVariable.ratioWidth(Get.context) * 20,))
                                  // child: Icon(
                                  //   Icons.call,
                                  //   color: Color(ListColor.colorGreen4),
                                  //   size: GlobalVariable.ratioWidth(Get.context) * 20,
                                  // ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 29, GlobalVariable.ratioWidth(Get.context) * 12, 0, GlobalVariable.ratioWidth(Get.context) * 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText("InfoPermintaanMuatLabelWaktuEkspektasi".tr, fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                  Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                  Obx(() => CustomText(controller.dataMuat["estimasi_muat_str"], fontWeight: FontWeight.w600))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              height: GlobalVariable.ratioWidth(Get.context) * 152,
              child: Obx(
                () => Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                      child: Obx(() => FlutterMap(
                            options: MapOptions(
                              interactiveFlags: InteractiveFlag.none,
                              center: GlobalVariable.centerMap,
                              zoom: 13.0,
                            ),
                            mapController: controller.mapLokasiController,
                            layers: [
                              GlobalVariable.tileLayerOptions,
                              MarkerLayerOptions(markers: [
                                for (var index = 0; index < controller.latlngLokasi.length; index++)
                                  Marker(
                                    width: GlobalVariable.ratioWidth(Get.context) * 30.0,
                                    height: GlobalVariable.ratioWidth(Get.context) * 30.0,
                                    point: controller.latlngLokasi[index],
                                    builder: (ctx) => Obx(
                                      () => Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          SvgPicture.asset(
                                            controller.latlngLokasi.length == 1
                                                ? "assets/pin_truck_icon.svg"
                                                : index == 0
                                                    ? "assets/pin_yellow_icon.svg"
                                                    : "assets/pin_blue_icon.svg",
                                            width: GlobalVariable.ratioWidth(Get.context) * 18,
                                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 6),
                                              child: CustomText(controller.latlngLokasi.length == 1 ? "" : (index + 1).toString(),
                                                  color: index == 0 ? Color(ListColor.color4) : Colors.white, fontWeight: FontWeight.bold, fontSize: 7))
                                        ],
                                      ),
                                    ),
                                  ),
                              ])
                            ],
                          )),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                            onTap: () => Get.to(
                                  () => MapDetailPermintaanMuatComponent(
                                    title: 'Lokasi Pick Up/Muat',
                                  ),
                                  arguments: 0,
                                  // 0 : Pickup/Muat
                                  // 1 : Destinasi/Bongkar
                                ),
                            child: Container(
                                width: double.infinity,
                                height: GlobalVariable.ratioWidth(Get.context) * 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                                        bottomRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
                                    color: Color(ListColor.color4)),
                                child: Center(
                                  child: CustomText(
                                    "Lihat Peta",
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )))),
                    !controller.loadMapLokasi.value
                        ? SizedBox.shrink()
                        : Positioned.fill(
                            child: Container(
                              color: Color(ListColor.colorLightGrey),
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            ),
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget secondPage() {
    return SingleChildScrollView(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
      child: Obx(
        () => Column(
          children: [
            Container(
              height: GlobalVariable.ratioWidth(Get.context) * 8,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText("InfoPermintaanMuatLabelTipeDestinasi".tr, fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                  Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                  Obx(() => CustomText(controller.dataMuat["type_bongkar_str"], fontWeight: FontWeight.w600))
                ],
              ),
            ),
            for (var index = 0; index < controller.destinasi.length; index++)
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                    child: Obx(
                      () => Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          SvgPicture.asset(
                            controller.destinasi.length == 1
                                ? "assets/pin_truck_icon.svg"
                                : index == 0
                                    ? "assets/pin_yellow_icon.svg"
                                    : "assets/pin_blue_icon.svg",
                                width:
                                    GlobalVariable.ratioWidth(
                                            Get.context) *
                                        18,
                                height:
                                    GlobalVariable.ratioWidth(
                                            Get.context) *
                                        24,
                          ),
                          Container(
                              margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 5),
                              child: CustomText(controller.destinasi.length == 1 ? "" : (index + 1).toString(),
                                  color: index == 0 ? Color(ListColor.color4) : Colors.white, fontWeight: FontWeight.bold, fontSize: 7))
                        ],
                      ),
                    ),
                  ),
                  Container(width: GlobalVariable.ratioWidth(Get.context) * 12),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                          child: CustomText("InfoPermintaanMuatLabelLokasiDestinasi".tr,
                              fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText("InfoPermintaanMuatLabelAlamatLokasi".tr,
                                  fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                              Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                              CustomText(controller.destinasi[index], fontWeight: FontWeight.w600),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText("InfoPermintaanMuatLabelDetailLokasi".tr,
                                  fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                              Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                              CustomText(controller.deskripsiDestinasi[index] ?? "", fontWeight: FontWeight.w600)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText("InfoPermintaanMuatLabelNamaPIC".tr, fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                              Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                              CustomText(controller.namaPICDestinasi[index], fontWeight: FontWeight.w600)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText("InfoPermintaanMuatLabelNomorPIC".tr,
                                        fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                                    Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                                    CustomText(controller.nomorPICDestinasi[index], fontWeight: FontWeight.w600)
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: SvgPicture.asset("assets/socmed_logo_call.svg", width: GlobalVariable.ratioWidth(Get.context) * 20,))
                                  // child: Icon(Icons.call, color: Color(ListColor.colorGreen4), size: GlobalVariable.ratioWidth(Get.context) * 20))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 29, GlobalVariable.ratioWidth(Get.context) * 12, 0, GlobalVariable.ratioWidth(Get.context) * 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText("InfoPermintaanMuatLabelWaktuEkspektasi".tr, fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                  Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                  Obx(() => CustomText(controller.dataMuat["estimasi_bongkar_str"], fontWeight: FontWeight.w600))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              height: GlobalVariable.ratioWidth(Get.context) * 152,
              child: Obx(
                () => Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                      child: Obx(() => FlutterMap(
                            options: MapOptions(
                              interactiveFlags: InteractiveFlag.none,
                              center: GlobalVariable.centerMap,
                              zoom: 13.0,
                            ),
                            mapController: controller.mapDestinasiController,
                            layers: [
                              GlobalVariable.tileLayerOptions,
                              MarkerLayerOptions(markers: [
                                for (var index = 0; index < controller.latlngDestinasi.length; index++)
                                  Marker(
                                    width: 30.0,
                                    height: 30.0,
                                    point: controller.latlngDestinasi[index],
                                    builder: (ctx) => Obx(
                                      () => Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          SvgPicture.asset(
                                            controller.latlngDestinasi.length == 1
                                                ? "assets/pin_truck_icon.svg"
                                                : index == 0
                                                    ? "assets/pin_yellow_icon.svg"
                                                    : "assets/pin_blue_icon.svg",
                                            width: GlobalVariable.ratioWidth(Get.context) * 18,
                                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 6),
                                              child: CustomText(controller.latlngDestinasi.length == 1 ? "" : (index + 1).toString(),
                                                  color: index == 0 ? Color(ListColor.color4) : Colors.white, fontWeight: FontWeight.bold, fontSize: 7))
                                        ],
                                      ),
                                    ),
                                  ),
                              ])
                            ],
                          )),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                            // belum multibahasa
                            onTap: () => Get.to(
                                  () => MapDetailPermintaanMuatComponent(
                                    title: 'Lokasi Destinasi/Bongkar',
                                  ),
                                  arguments: 1,
                                  // 0 : Pickup/Muat
                                  // 1 : Destinasi/Bongkar
                                ),
                            child: Container(
                                width: double.infinity,
                                height: GlobalVariable.ratioWidth(Get.context) * 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                                        bottomRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
                                    color: Color(ListColor.color4)),
                                child: Center(
                                  child: CustomText(
                                    "Lihat Peta",
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,),
                                )))),
                    !controller.loadMapDestinasi.value
                        ? SizedBox.shrink()
                        : Positioned.fill(
                            child: Container(
                              color: Color(ListColor.colorLightGrey),
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            ),
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget thirdPage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
      child: ListView(
        children: [
          Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
          Container(
            margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText("InfoPermintaanMuatLabelHeadDanKarier".tr, fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                Obx(() => CustomText(controller.dataMuat["jenis_truck"] + " - " + controller.dataMuat["jenis_carrier"], fontWeight: FontWeight.w600))
              ],
            ),
          ),
          Obx(
            () => Container(
                margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                alignment: Alignment.center,
                height: GlobalVariable.ratioWidth(Get.context) * 166,
                decoration: BoxDecoration(
                    color: controller.linkImage.value.isEmpty ? Color(ListColor.colorLightGrey2) : Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
                    border: Border.all(color: Color(ListColor.colorGrey2), width: GlobalVariable.ratioWidth(Get.context) * 1)),
                child: Obx(
                  () => controller.linkImage.value.isEmpty
                      ? CircularProgressIndicator()
                      : CachedNetworkImage(
                          fit: BoxFit.contain,
                          imageUrl: controller.linkImage.value,
                          imageBuilder: (context, imageProvider) => Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
                                image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
                          ),
                          progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                        ),
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText("Kapasitas/Dimensi Max", fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                CustomText(
                  "35 - 40 ton (20 x 8 x 10)",
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText("InfoPermintaanMuatLabelJumlahTruk".tr, fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                Obx(() => CustomText(controller.dataMuat["jumlah_truck_str"] + " unit", fontWeight: FontWeight.w600))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget fourthPage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
      child: Form(
        key: controller.formKey,
        child: ListView(
          children: [
            Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
            Container(
              margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText("InfoPermintaanMuatLabelDeskripsi".tr, fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                  Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                  Obx(() => CustomText(
                        controller.dataMuat["deskripsi"] ?? "",
                        fontWeight: FontWeight.w600,
                      ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText("InfoPermintaanMuatLabelBerat".tr + "/" + "Volume".tr,
                      fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                  Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                  Obx(() => CustomText(
                        controller.dataMuat["berat"].toString() + " ton / " + controller.dataMuat["volume"].toString() + " m3",
                        fontWeight: FontWeight.w600,
                      ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText("InfoPermintaanMuatLabelDimensi".tr, fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                  Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                  Obx(() => CustomText(
                        controller.dataMuat["dimensi"] != null
                            ? controller.dataMuat["dimensi"]
                            : controller.dataMuat["dimensi_p"].toString() +
                                "m x " +
                                controller.dataMuat["dimensi_l"].toString() +
                                "m x " +
                                controller.dataMuat["dimensi_t"].toString() +
                                "m",
                        fontWeight: FontWeight.w600,
                      ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText("InfoPermintaanMuatLabelJumlah".tr, fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                  Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                  Obx(() => CustomText(
                        controller.dataMuat["jumlah_koli"].toString(),
                        fontWeight: FontWeight.w600,
                      ))
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                height: GlobalVariable.ratioWidth(Get.context) * 2,
                color: Color(ListColor.colorLightGrey5)),
            Container(
              margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              child: Form(
                child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText("InfoPermintaanMuatLabelCatatanTambahan".tr, fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                      Container(
                          margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 4, bottom: GlobalVariable.ratioWidth(Get.context) * 3),
                          child: CustomText("Catatan tambahan maksimal 6 kali penambahan",
                              fontWeight: FontWeight.w600, fontSize: 11, color: Color(ListColor.colorDarkGrey3))),
                      for (var index = 0; index < controller.catatanTambahan.length; index++)
                        Container(
                          margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 7),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(controller.catatanTambahan[index]["Created"] ?? "",
                                  fontSize: 11, fontWeight: FontWeight.w500, color: Color(ListColor.colorGrey3)),
                              Container(height: GlobalVariable.ratioWidth(Get.context) * 6),
                              CustomText(controller.catatanTambahan[index]["catatan"] ?? "", fontWeight: FontWeight.w600, fontSize: 14)
                            ],
                          ),
                        ),
                      !controller.editCatatanTambahan.value
                          ? SizedBox.shrink()
                          : Container(
                              margin: EdgeInsets.only(
                                top: GlobalVariable.ratioWidth(Get.context) * 7,
                              ),
                              child: Stack(
                                children: [
                                  CustomTextFormField(
                                    context: Get.context,
                                    minLines: 4,
                                    maxLines: 4,
                                    controller: controller.catatanTambahanController,
                                    validator: (str) {
                                      if (str.isEmpty) return "Field harus diisi";
                                      return null;
                                    },
                                    newContentPadding: EdgeInsets.symmetric(
                                        vertical: GlobalVariable.ratioWidth(Get.context) * 12, horizontal: GlobalVariable.ratioWidth(Get.context) * 17),
                                    textSize: 12,
                                    style: TextStyle(fontWeight: FontWeight.w600, height: 1.2, color: Color(ListColor.colorLightGrey4)),
                                    newInputDecoration: InputDecoration(
                                      isDense: true,
                                      isCollapsed: true,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Color(ListColor.colorLightGrey10), width: 1)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Color(ListColor.color4), width: 1)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Color(ListColor.colorRed), width: 1)),
                                    ),
                                  ),
                                  Positioned.fill(
                                      child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  bottom: GlobalVariable.ratioWidth(Get.context) * 7, right: GlobalVariable.ratioWidth(Get.context) * 7),
                                              child: GestureDetector(
                                                  onTap: () {},
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Color(ListColor.colorLightGrey4),
                                                    size: GlobalVariable.ratioWidth(Get.context) * 15,
                                                  ))))),
                                ],
                              ),
                            ),
                      !controller.editCatatanTambahan.value && controller.catatanTambahan.length < controller.limitCatatan
                          ? Container(
                              margin: EdgeInsets.only(
                                top: GlobalVariable.ratioWidth(Get.context) * 7,
                              ),
                              child: GestureDetector(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      "Tambah Catatan",
                                      color: Color(ListColor.color4),
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                      fontSize: 14,
                                    ),
                                    Container(width: GlobalVariable.ratioWidth(Get.context) * 2),
                                    Icon(Icons.arrow_forward, color: Color(ListColor.color4), size: GlobalVariable.ratioWidth(Get.context) * 14)
                                  ],
                                ),
                                onTap: () {
                                  if (controller.editCatatanTambahan.value) {}
                                  controller.editCatatanTambahan.value = !controller.editCatatanTambahan.value;
                                },
                              ),
                            )
                          : SizedBox.shrink()
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => CustomText(controller.jumlahMitra.value == 0 ? "InfoPermintaanMuatLabelTransporterMitra".tr : "InfoPermintaanMuatLabelDiumumkan".tr,
                        fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3)),
                  ),
                  Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                  Obx(
                    () => Text.rich(
                      TextSpan(children: controller.diumumkanKepadaTextSpan.map((data) => data as InlineSpan).toList()),
                      textAlign: TextAlign.start,
                      style: TextStyle(height: 1.2),
                    ),
                  ),
                  // Obx(
                  //   () => Wrap(
                  //     spacing: 8,
                  //     runSpacing: 8,
                  //     children: [
                  //       for (var index = 0;
                  //           index < controller.selectedJenisMitra.length;
                  //           index++)
                  //         Container(
                  //             decoration: BoxDecoration(
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(15)),
                  //                 border: Border.all(
                  //                     width: 2,
                  //                     color: Color(ListColor.colorDarkGrey))),
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: 10, vertical: 4),
                  //             child: CustomText(controller
                  //                 .selectedJenisMitra.values
                  //                 .toList()[index])),
                  //       for (var index = 0;
                  //           index <
                  //               ((controller.limitTampil -
                  //                           controller
                  //                               .selectedJenisMitra.length >
                  //                       controller.selectedGroup.length)
                  //                   ? controller.selectedGroup.length
                  //                   : controller.limitTampil -
                  //                       controller.selectedJenisMitra.length);
                  //           index++)
                  //         Container(
                  //             decoration: BoxDecoration(
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(15)),
                  //                 border: Border.all(
                  //                     width: 2,
                  //                     color: Color(ListColor.colorDarkGrey))),
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: 10, vertical: 4),
                  //             child: CustomText(
                  //                 controller.selectedGroup[index]["Name"])),
                  //       for (var index = 0;
                  //           index <
                  //               ((controller.limitTampil -
                  //                           (controller
                  //                                   .selectedJenisMitra.length +
                  //                               controller
                  //                                   .selectedGroup.length) >
                  //                       controller.selectedTransporter.length)
                  //                   ? controller.selectedTransporter.length
                  //                   : controller.limitTampil -
                  //                       (controller.selectedJenisMitra.length +
                  //                           controller.selectedGroup.length));
                  //           index++)
                  //         Container(
                  //             decoration: BoxDecoration(
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(15)),
                  //                 border: Border.all(
                  //                     width: 2,
                  //                     color: Color(ListColor.color4))),
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: 10, vertical: 4),
                  //             child: CustomText(controller
                  //                 .selectedTransporter[index]["name"])),
                  //       controller.jumlahMitra.value <= controller.limitTampil
                  //           ? SizedBox.shrink()
                  //           : GestureDetector(
                  //               onTap: () {
                  //                 GetToPage.toNamed<ListUserController>(
                  //                     Routes.LIST_USER,
                  //                     arguments: [
                  //                       false,
                  //                       {
                  //                         "semua": controller
                  //                             .selectedJenisMitra.value,
                  //                         "group":
                  //                             controller.selectedGroup.value,
                  //                         "transporter": controller
                  //                             .selectedTransporter.value
                  //                       }
                  //                     ]);
                  //               },
                  //               child: Container(
                  //                   constraints: BoxConstraints(
                  //                       minWidth:
                  //                           GlobalVariable.ratioWidth(Get.context) *
                  //                               25),
                  //                   decoration: BoxDecoration(
                  //                       borderRadius: BorderRadius.all(
                  //                           Radius.circular(
                  //                               GlobalVariable.ratioWidth(Get.context) *
                  //                                   5)),
                  //                       border: Border.all(
                  //                           width:
                  //                               GlobalVariable.ratioWidth(Get.context) *
                  //                                   1,
                  //                           color: Color(ListColor.color4))),
                  //                   padding: EdgeInsets.symmetric(
                  //                       horizontal:
                  //                           GlobalVariable.ratioWidth(Get.context) * 6,
                  //                       vertical: GlobalVariable.ratioWidth(Get.context) * 5),
                  //                   child: Column(
                  //                     mainAxisSize: MainAxisSize.min,
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.center,
                  //                     children: [
                  //                       CustomText(
                  //                         (controller.jumlahMitra.value - 5)
                  //                             .toString(),
                  //                         color: Color(ListColor.color4),
                  //                         fontWeight: FontWeight.w600,
                  //                         fontSize: 12,
                  //                       ),
                  //                     ],
                  //                   )),
                  //             ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: CustomText("InfoPermintaanMuatLabelStatus".tr,
                                  fontWeight: FontWeight.bold, fontSize: 14, color: Color(ListColor.colorGrey3))),
                          controller.editStatusPermintaanMuat.value
                              ? SizedBox.shrink()
                              : Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: GestureDetector(
                                    child: SvgPicture.asset("assets/ic-contact-edit.svg",
                                        height: GlobalVariable.ratioWidth(Get.context) * 10, width: GlobalVariable.ratioWidth(Get.context) * 10),
                                    onTap: () {
                                      if (!controller.editStatusPermintaanMuat.value) {
                                        controller.changeStatus();
                                      } else
                                        controller.editStatusPermintaanMuat.value = !controller.editStatusPermintaanMuat.value;
                                    },
                                  ),
                                )
                        ],
                      ),
                    ),
                    Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                    !controller.editStatusPermintaanMuat.value
                        ? Obx(() => CustomText(controller.dataMuat["status_str"], color: controller.statusColor.value, fontWeight: FontWeight.w600))
                        : Container(
                            child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var index = 0; index < controller.listStatus.length; index++)
                                Container(
                                  margin: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(Get.context) * 6,
                                      bottom: index != (controller.listStatus.length - 1) ? GlobalVariable.ratioWidth(Get.context) * 6 : 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      RadioButtonCustom(
                                          width: GlobalVariable.ratioWidth(Get.context) * 20,
                                          height: GlobalVariable.ratioWidth(Get.context) * 20,
                                          isWithShadow: true,
                                          isDense: true,
                                          groupValue: controller.status.value ?? "",
                                          value: index.toString(),
                                          onChanged: (value) => controller.status.value = value),
                                      Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 11),
                                            child: CustomText(controller.listStatus[index], fontSize: 12, fontWeight: FontWeight.w600)),
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ))
                  ],
                ),
              ),
            ),
            Container(height: GlobalVariable.ratioWidth(Get.context) * 9)
          ],
        ),
      ),
    );
  }
}
